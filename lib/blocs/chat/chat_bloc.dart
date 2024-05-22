import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_group_info_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/data/models/uploadImage/upload_image_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/repositories/uploadImage/upload_image_repository.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';

import '../../utils/database/database_util.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final ChatData chatData = getIt<ChatData>();
  Map<String, dynamic> chatDetailsMap = {};
  Map<String, dynamic> groupDataMap = {};
  final List<Map<String, dynamic>> messagesList = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool isCameraImage = false;
  bool isCameraVideo = false;
  bool isSearchEnabled = false;
  String clientId = '';
  String timeZoneFormat = '';

  List<ChatData> chatDetailsList = [];
  Map<String, dynamic> employeeDetailsMap = {};
  final _chatScreenMessagesStreamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get messageStream =>
      _chatScreenMessagesStreamController.stream;
  final _allChatScreenDetailsStreamController =
      StreamController<List<ChatData>>.broadcast();

  Stream<List<ChatData>> get allChatsStream =>
      _allChatScreenDetailsStreamController.stream;
  int groupId = 0;
  List<EmployeesDatum> employeeList = [];
  bool employeeListReachedMax = false;

  ChatBloc._() : super(ChatInitial()) {
    on<FetchEmployees>(_fetchEmployees);
    on<SendChatMessage>(_sendMessage);
    on<RebuildChatMessagingScreen>(_rebuildChatMessage);
    on<FetchChatsList>(_fetchChatsList);
    on<CreateChatGroup>(_createChatGroup);
    on<PickMedia>(_pickMedia);
    on<UploadChatImage>(_uploadImage);
    on<FetchGroupInfo>(_fetchGroupInfo);
    on<FetchChatMessage>(_fetchChatMessages);
  }

  static final ChatBloc _instance = ChatBloc._();

  factory ChatBloc() => _instance;

  @override
  Future<void> close() {
    _chatScreenMessagesStreamController.close();
    _allChatScreenDetailsStreamController.close();
    return super.close();
  }

  FutureOr<void> _fetchEmployees(
      FetchEmployees event, Emitter<ChatState> emit) async {
    try {
      emit(FetchingEmployees());
      FetchEmployeesModel fetchEmployeesModel =
          await _chatBoxRepository.fetchEmployees(
              event.pageNo,
              await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
              event.searchedName);
      employeeListReachedMax = fetchEmployeesModel.data.isEmpty;
      employeeList.addAll(fetchEmployeesModel.data);
      await _databaseHelper.insertEmployees(employeeList);
      if (event.searchedName.isEmpty && isSearchEnabled == true) {
        emit(EmployeesNotFetched(errorMessage: 'User not found!'));
      } else {
        emit(EmployeesFetched(employeeList: employeeList));
      }
    } catch (e) {
      emit(EmployeesNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _sendMessage(
      SendChatMessage event, Emitter<ChatState> emit) async {
    try {
      DateTime dateTime = DateTime.now();
      Random random = Random();
      int randomValue = random.nextInt(100000);
      String messageId = '${dateTime.millisecondsSinceEpoch}$randomValue';
      Map<String, dynamic> sendMessageMap = {
        "msg_id": messageId,
        "quote_msg_id": "",
        "sid": await _customerCache.getUserId2(CacheKeys.userId2),
        "stype": (await _customerCache.getUserType(CacheKeys.userType) == "2")
            ? "2"
            : "1",
        "rid": (event.sendMessageMap['isGroup'] == true)
            ? event.sendMessageMap['rid']
            : (event.sendMessageMap['isReceiver'] == 1)
                ? event.sendMessageMap['sid']
                : event.sendMessageMap['rid'],
        "rtype": (event.sendMessageMap['isGroup'] == true)
            ? '3'
            : (event.sendMessageMap['isReceiver'] == 1)
                ? event.sendMessageMap['stype']
                : event.sendMessageMap['rtype'] ?? '',
        "msg_type": event.sendMessageMap['message_type'] ?? '',
        "msg_time": dateTime.toUtc().toString(),
        "msg": event.sendMessageMap['message'] ?? '',
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "sid_2": 2,
        "stype_2": "3"
      };
      sendMessageMap['isReceiver'] = 0;
      await _databaseHelper.insertMessage({
        'employee_name': event.sendMessageMap['employee_name'],
        'messageType': event.sendMessageMap['mediaType'],
        'pickedMedia': event.sendMessageMap['picked_image'],
        'isDownloadedImage': 0,
        'showCount': 1,
        'isGroup': (event.sendMessageMap['isGroup'] == true) ? 1 : 0,
        'attachementExtension':
            event.sendMessageMap['attachementExtension'] ?? '',
        ...sendMessageMap
      });
      event.sendMessageMap['isMedia'] = false;
      clientId = await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      add(RebuildChatMessagingScreen(employeeDetailsMap: sendMessageMap));
      sendMessageMap.remove('isReceiver');
      SendMessageModel sendMessageModel =
          await _chatBoxRepository.sendMessage(sendMessageMap);
      if (sendMessageModel.status == 200) {
        await _databaseHelper.updateMessageStatus(sendMessageModel.data.msgId);
      }
    } catch (e) {
      emit(CouldNotSendMessage(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _rebuildChatMessage(
      RebuildChatMessagingScreen event, Emitter<ChatState> emit) async {
    try {
      await _databaseHelper.getUnreadMessageCount(
        event.employeeDetailsMap['sid'].toString(),
        event.employeeDetailsMap['currentSenderId'].toString(),
        event.employeeDetailsMap['rid'].toString(),
        event.employeeDetailsMap['currentReceiverId'].toString(),
        event.employeeDetailsMap['isCurrentUser'] ?? false,
      );

      timeZoneFormat =
          await _customerCache.getTimeZoneOffset(CacheKeys.timeZoneOffset) ??
              '';

      List<Map<String, dynamic>> messages =
          await _databaseHelper.getMessagesForEmployees(
        event.employeeDetailsMap['rid'].toString(),
        event.employeeDetailsMap['sid'].toString(),
      );
      messagesList
        ..clear()
        ..addAll(messages.reversed);
      _chatScreenMessagesStreamController.sink.add(messagesList);

      if (chatDetailsMap['isMedia'] == false) {
        emit(ShowChatMessagingTextField());
      }

      add(FetchChatsList());
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> _fetchChatsList(
      FetchChatsList event, Emitter<ChatState> emit) async {
    final List<ChatData> individualChatList = [];

    try {
      List users = await _databaseHelper.getLatestMessagesForEmployees();

      await Future.wait(users.map((employee) async {
        List<Map<String, dynamic>> messagesForLastUser =
            await _databaseHelper.getMessagesForEmployees(
                employee['sid'].toString(), employee['rid'].toString());

        if (messagesForLastUser.isNotEmpty) {
          var lastMessage = messagesForLastUser.last;

          int existingChatIndex =
              await findExistingChatIndex(individualChatList, lastMessage);

          if (existingChatIndex != -1) {
            ChatData existingChat = individualChatList[existingChatIndex];
            existingChat
              ..message = lastMessage['msg'] ?? ''
              ..date = await formattedDate(lastMessage['msg_time'])
              ..time = await formattedTime(lastMessage['msg_time'])
              ..dateTime = lastMessage['msg_time']
              ..userName = lastMessage['employee_name'] ?? ''
              ..isReceiver = lastMessage['isReceiver'] ?? ''
              ..unreadMsgCount = await _isMessageForCurrentChat(
                      chatDetailsMap['sid'], lastMessage['sid'].toString())
                  ? 0
                  : lastMessage['unreadMessageCount'] ?? 0;
          } else {
            ChatData chat = ChatData(
              rId: lastMessage['rid'].toString(),
              sId: lastMessage['sid'].toString(),
              sType: lastMessage['stype'].toString(),
              rType: lastMessage['rtype'].toString(),
              isReceiver: lastMessage['isReceiver'] ?? 0,
              userName: lastMessage['employee_name'] ?? '',
              message: lastMessage['msg'] ?? '',
              isGroup: (lastMessage['isGroup'] == 1),
              date: await formattedDate(lastMessage['msg_time']),
              dateTime: lastMessage['msg_time'],
              time: await formattedTime(lastMessage['msg_time']),
              messageType: lastMessage['msg_type'] ?? '',
              unreadMsgCount: await _isMessageForCurrentChat(
                      chatDetailsMap['sid'], lastMessage['sid'].toString())
                  ? lastMessage['unreadMessageCount'] ?? 0
                  : 0,
            );
            individualChatList.add(chat);
          }
        }
      }).toList());

      individualChatList.sort((a, b) => b.time.compareTo(a.time));

      _allChatScreenDetailsStreamController.add(individualChatList);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> findExistingChatIndex(
      List<ChatData> chatList, Map<String, dynamic> message) async {
    return chatList.indexWhere((chat) =>
        chat.rId == message['rid'].toString() &&
        chat.sId == message['sid'].toString());
  }

  Future<bool> _isMessageForCurrentChat(mapId, senderId) async {
    bool isMessageForCurrentChat = senderId == mapId;
    return isMessageForCurrentChat;
  }

  Future<String> formattedDate(String timestamp) async {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  Future<String> formattedTime(String timestamp) async {
    DateTime dateTime = DateTime.parse(timestamp);
    String? timeZoneOffset =
        await _customerCache.getTimeZoneOffset(CacheKeys.timeZoneOffset);
    if (timeZoneOffset != null) {
      List offset =
          timeZoneOffset.replaceAll('+', '').replaceAll('-', '').split(':');
      if (timeZoneOffset.contains('+')) {
        dateTime = dateTime.toUtc().add(Duration(
            hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
      } else {
        dateTime = dateTime.toUtc().subtract(Duration(
            hours: int.parse(offset[0]), minutes: int.parse(offset[1].trim())));
      }
    }
    return DateFormat('H:mm:ss').format(dateTime);
  }

  FutureOr<void> _createChatGroup(
      CreateChatGroup event, Emitter<ChatState> emit) async {
    try {
      emit(CreatingChatGroup());
      CreateChatGroupModel chatGroupModel =
          await _chatBoxRepository.createChatGroup({
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "name": groupDataMap['group_name'],
        "purpose": groupDataMap['group_purpose'] ?? '',
        "members": groupDataMap['members']
      });
      if (chatGroupModel.status == 200) {
        groupId = chatGroupModel.data.groupId;
        await _databaseHelper.insertGroup({
          'group_id': groupId,
          'group_name': groupDataMap['group_name'],
          'purpose': groupDataMap['group_purpose']
        }, groupDataMap['members']);
        emit(ChatGroupCreated());
      } else {
        emit(ChatGroupCannotCreate(errorMessage: 'Error!'));
      }
    } catch (e) {
      emit(ChatGroupCannotCreate(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _pickMedia(PickMedia event, Emitter<ChatState> emit) async {
    try {
      Future<bool> handlePermission() async {
        final permissionStatus = (isCameraImage == true)
            ? await Permission.camera.request()
            : await Permission.storage.request();
        if (permissionStatus == PermissionStatus.denied) {
          openAppSettings();
        } else if (permissionStatus == PermissionStatus.permanentlyDenied) {}
        return true;
      }

      final hasPermission = await handlePermission();
      if (!hasPermission) {
        return;
      } else {
        switch (event.mediaDetailsMap['mediaType']) {
          case 'Image':
            final pickedFile = await _imagePicker.pickImage(
                source: (isCameraImage == true)
                    ? ImageSource.camera
                    : ImageSource.gallery,
                imageQuality: 25);
            if (pickedFile != null) {
              chatDetailsMap['isUploadComplete'] = false;
              chatData.fileName = pickedFile.path;
              int fileSizeInBytes = await pickedFile.length();
              int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);
              chatDetailsMap['picked_image'] = chatData.fileName;
              chatDetailsMap['isMedia'] = true;

              if (chatDetailsMap['isMedia'] == true) {
                emit(ChatMessagingTextFieldHidden());
              }
              if (chatDetailsMap['isUploadComplete'] == false) {
                chatDetailsMap['file_size'] = fileSizeInMB;
                add(RebuildChatMessagingScreen(
                    employeeDetailsMap: chatDetailsMap));
              }
              if (pickedFile.path.isNotEmpty) {
                add(UploadChatImage(
                    pickedImage: pickedFile.path,
                    chatDataMap: event.mediaDetailsMap));
              }
            } else {
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
            }
            break;
          case 'Video':
            final pickVideo = await _imagePicker.pickVideo(
                source: (isCameraVideo == true)
                    ? ImageSource.camera
                    : ImageSource.gallery);
            if (pickVideo != null) {
              chatDetailsMap['isUploadComplete'] = false;
              chatData.fileName = pickVideo.path;
              int fileSizeInBytes = await pickVideo.length();
              int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);
              chatDetailsMap['picked_image'] = chatData.fileName;
              chatDetailsMap['isMedia'] = true;
              if (chatDetailsMap['isMedia'] == true) {
                emit(ChatMessagingTextFieldHidden());
              }
              if (chatDetailsMap['isUploadComplete'] == false) {
                chatDetailsMap['file_size'] = fileSizeInMB;
                add(RebuildChatMessagingScreen(
                    employeeDetailsMap: chatDetailsMap));
              }
              if (chatData.fileName.isNotEmpty) {
                add(UploadChatImage(
                    pickedImage: pickVideo.path, chatDataMap: chatDetailsMap));
              }
            } else {
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
            }
            break;
          case 'Document':
            late File pickedFile;
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'pdf',
                  'doc',
                  'docx',
                  'ppt',
                  'pptx',
                  'xlsx'
                ]);
            if (result != null) {
              pickedFile = File(result.files.single.path!);
              int fileSizeInBytes = await pickedFile.length();
              int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);
              chatDetailsMap['attachementExtension'] =
                  result.files.single.extension;
              chatDetailsMap['isUploadComplete'] = false;
              chatData.fileName = pickedFile.path;
              chatDetailsMap['picked_image'] = chatData.fileName;
              chatDetailsMap['isMedia'] = true;
              if (chatDetailsMap['isMedia'] == true) {
                emit(ChatMessagingTextFieldHidden());
              }
              if (chatDetailsMap['isUploadComplete'] == false) {
                chatDetailsMap['file_size'] = fileSizeInMB;
                add(RebuildChatMessagingScreen(
                    employeeDetailsMap: chatDetailsMap));
              }
              if (chatData.fileName.isNotEmpty) {
                add(UploadChatImage(
                    pickedImage: chatData.fileName,
                    chatDataMap: event.mediaDetailsMap));
              }
            } else {
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
            }
        }
      }
    } catch (e) {
      e.toString();
    }
  }

  FutureOr<bool> _uploadImage(
      UploadChatImage event, Emitter<ChatState> emit) async {
    bool isUploadComplete = false;
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      UploadPictureModel uploadPictureModel = await _uploadPictureRepository
          .uploadImage(File(event.pickedImage), hashCode);
      if (uploadPictureModel.data.isNotEmpty) {
        chatDetailsMap['message'] = uploadPictureModel.data.first;
        isUploadComplete = true;
      } else {
        isUploadComplete = false;
      }
      if (isUploadComplete == true) {
        chatDetailsMap['isUploadComplete'] = true;
        Future.delayed(const Duration(seconds: 3));
        if (chatDetailsMap['isUploadComplete'] == true) {
          add(RebuildChatMessagingScreen(employeeDetailsMap: chatDetailsMap));
          emit(ChatMessagingTextFieldHidden());
        }
      }
    } catch (e) {
      e.toString();
    }
    return isUploadComplete;
  }

  FutureOr<void> _fetchGroupInfo(
      FetchGroupInfo event, Emitter<ChatState> emit) async {
    List<Map<String, dynamic>> membersList = [];
    try {
      FetchGroupInfoModel fetchGroupInfoModel =
          await _chatBoxRepository.fetchGroupInfo({
        'hashcode': await _customerCache.getHashCode(CacheKeys.hashcode),
        'group_id': event.groupId
      });
      if (fetchGroupInfoModel.data.toJson().isNotEmpty) {
        for (var item in fetchGroupInfoModel.data.members) {
          membersList.add({
            'id': item.id,
            'type': item.type,
            'name': item.username,
            'isowner': item.isowner,
            'group_id': event.groupId,
            'date': item.date
          });
        }
        DateTime date = DateTime.now().toUtc();
        DateTime dateTime = DateTime.parse(date.toIso8601String());
        String finalDate = DateFormat('dd/MM/yyyy').format(dateTime);
        await _databaseHelper.insertGroup({
          'group_id': event.groupId,
          'group_name': fetchGroupInfoModel.data.name,
          'purpose': fetchGroupInfoModel.data.purpose,
          'date': finalDate
        }, membersList);
        add(FetchChatsList());
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> _fetchChatMessages(
      FetchChatMessage event, Emitter<ChatState> emit) async {
    try {
      List<Map<String, dynamic>> chatMessages =
          await _databaseHelper.getMessagesWithStatusZero();
      for (var item in chatMessages) {
        Map<String, dynamic> sendMessageMap = {
          "msg_id": item['msg_id'],
          "quote_msg_id": "",
          "sid": item['sid'],
          "stype": item['stype'],
          "rid": item['rid'],
          "rtype": item['rtype'],
          "msg_type": item['msg_type'],
          "msg_time": item['msg_time'],
          "msg": item['msg'],
          "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
          "sid_2": 2,
          "stype_2": "3"
        };
        SendMessageModel sendMessageModel =
            await _chatBoxRepository.sendMessage(sendMessageMap);
        if (sendMessageModel.status == 200) {
          await _databaseHelper
              .updateMessageStatus(sendMessageModel.data.msgId);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
