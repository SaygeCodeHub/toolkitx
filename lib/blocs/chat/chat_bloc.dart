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
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/data/models/uploadImage/upload_image_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/repositories/uploadImage/upload_image_repository.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';

import '../../utils/database/database_util.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final UploadImageRepository _uploadPictureRepository =
      getIt<UploadImageRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final ChatData chatData = getIt<ChatData>();
  Map<String, dynamic> chatDetailsMap = {};
  final List<Map<String, dynamic>> messagesList = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool isCameraImage = false;
  bool isCameraVideo = false;
  bool isSearchEnabled = false;
  String clientId = '';

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
      DateTime now = DateTime.now();
      Random random = Random();
      int randomValue = random.nextInt(100000);
      String messageId = '${now.millisecondsSinceEpoch}$randomValue';
      String isoDateString = now.toIso8601String();
      Map<String, dynamic> sendMessageMap = {
        "msg_id": messageId,
        "quote_msg_id": "",
        "sid": await _customerCache.getUserId2(CacheKeys.userId2),
        "stype": (await _customerCache.getUserType(CacheKeys.userType) == "2")
            ? "2"
            : "1",
        "rid": (event.sendMessageMap['isGroup'] == true)
            ? groupId
            : (event.sendMessageMap['isReceiver'] == 1)
                ? event.sendMessageMap['sid']
                : event.sendMessageMap['rid'],
        "rtype": (event.sendMessageMap['isReceiver'] == 1)
            ? event.sendMessageMap['stype']
            : event.sendMessageMap['rtype'] ?? '',
        "msg_type": event.sendMessageMap['message_type'] ?? '',
        "msg_time": isoDateString,
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
        ...sendMessageMap
      });
      // print('message map------>${jsonEncode(sendMessageMap)}');
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
    List<Map<String, dynamic>> messages =
        await _databaseHelper.getMessagesForEmployees(
            event.employeeDetailsMap['rid'].toString(),
            event.employeeDetailsMap['sid'].toString());
    messages = List.from(messages.reversed);
    for (var message in messages) {
      if (message['msg_type'] == '2' && message['isDownloadedImage'] == 0) {
        String image = message['msg'];
        String imageUrl =
            '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(image)[0]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}';
        String serverImagePath = imageUrl;
        if (serverImagePath.isNotEmpty) {
          await _databaseHelper.updateServerImagePath(
              message['msg_id'], serverImagePath);
        }
      }
    }
    messagesList.clear();
    messagesList.addAll(messages);
    _chatScreenMessagesStreamController.add(messagesList);
    add(FetchChatsList());
  }

  FutureOr<void> _fetchChatsList(
      FetchChatsList event, Emitter<ChatState> emit) async {
    List employees = await _databaseHelper.getLatestMessagesForEmployees();
    List<Map<String, dynamic>> groupChats =
        await _databaseHelper.getAllGroupsData();
    List<ChatData> individualChatList = [];
    List<ChatData> groupChatList = [];

    for (int i = 0; i < employees.length; i++) {
      List<Map<String, dynamic>> message =
          await _databaseHelper.getMessagesForEmployees(
              employees[i]['sid'].toString(), employees[i]['rid'].toString());
      if (message.isNotEmpty) {
        int existingChatIndex =
            findExistingChatIndex(individualChatList, message.last);

        if (existingChatIndex != -1) {
          ChatData existingChat = individualChatList[existingChatIndex];
          existingChat.message = message.last['msg'] ?? '';
          existingChat.date = formattedDate(message.last['msg_time']);
          existingChat.time = formattedTime(message.last['msg_time']);
        } else {
          ChatData chat = ChatData(
              rId: message.last['rid'].toString(),
              sId: message.last['sid'].toString(),
              sType: message.last['stype'].toString(),
              rType: message.last['rtype'].toString(),
              isReceiver: message.last['isReceiver'] ?? 0,
              userName: message.last['employee_name'] ?? '',
              message: message.last['msg'] ?? '',
              isGroup: false,
              date: formattedDate(message.last['msg_time']),
              time: formattedTime(message.last['msg_time']),
              messageType: message.last['msg_type'] ?? '');
          individualChatList.add(chat);
        }
      }
    }

    for (var item in groupChats) {
      ChatData chat = ChatData(
        groupName: item['group_name'],
        groupPurpose: item['purpose'],
        message: '',
        isGroup: true,
      );
      groupChatList.add(chat);
    }

    final chatsList = [...individualChatList, ...groupChatList];
    _allChatScreenDetailsStreamController.add(chatsList);
  }

  int findExistingChatIndex(
      List<ChatData> chatList, Map<String, dynamic> message) {
    return chatList.indexWhere((chat) =>
        chat.rId == message['rid'].toString() &&
        chat.sId == message['sid'].toString());
  }

  String formattedDate(String timestamp) {
    print('timestamp $timestamp');
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String formattedTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('h:mm a').format(dateTime);
  }

  FutureOr<void> _createChatGroup(
      CreateChatGroup event, Emitter<ChatState> emit) async {
    try {
      emit(CreatingChatGroup());
      CreateChatGroupModel chatGroupModel =
          await _chatBoxRepository.createChatGroup({
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "name": chatData.groupName,
        "purpose": chatData.groupPurpose,
        "members": chatData.membersToMap()
      });
      if (chatGroupModel.status == 200) {
        groupId = chatGroupModel.data.groupId;
        await _databaseHelper.insertGroup({
          'group_id': groupId,
          'group_name': chatData.groupName,
          'purpose': chatData.groupPurpose
        }, chatData.membersToMap());
        add(FetchChatsList());
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
        } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
          // add state
        }
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
              chatData.fileName = pickedFile.path;
              chatDetailsMap['picked_image'] = chatData.fileName;
              chatDetailsMap['isMedia'] = true;
              if (chatData.fileName.isNotEmpty) {
                add(UploadChatImage(pickedImage: chatData.fileName));
              }
              if (UploadChatImage(pickedImage: chatData.fileName)
                  .pickedImage
                  .isNotEmpty) {
                add(RebuildChatMessagingScreen(
                    employeeDetailsMap: event.mediaDetailsMap));
              }
            } else {
              return;
            }
            break;
          case 'Video':
            final pickVideo = await _imagePicker.pickVideo(
                source: (isCameraVideo == true)
                    ? ImageSource.camera
                    : ImageSource.gallery);
            if (pickVideo != null) {
              chatData.fileName = pickVideo.path;
              chatDetailsMap['isMedia'] = true;
              if (chatData.fileName.isNotEmpty) {
                add(UploadChatImage(pickedImage: chatData.fileName));
              }
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
            } else {
              return;
            }
            break;
          case 'Document':
            print('here----->');
            late File pickedFile;
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'doc', 'docx']);
            if (result != null) {
              pickedFile = File(result.files.single.path!);
              chatData.fileName = pickedFile.path;
              chatDetailsMap['isMedia'] = true;
              print('path====>${pickedFile.path}');
              if (chatData.fileName.isNotEmpty) {
                add(UploadChatImage(pickedImage: chatData.fileName));
              }
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
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      UploadPictureModel uploadPictureModel = await _uploadPictureRepository
          .uploadImage(File(event.pickedImage), hashCode);
      if (uploadPictureModel.data.first.isNotEmpty) {
        chatDetailsMap['message'] = uploadPictureModel.data.first;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error while uploading image $e');
      return false;
    }
  }
}
