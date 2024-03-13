import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/chat/chat_state.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';
import 'package:toolkit/utils/chat_database_util.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'dart:math';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final ChatData chatData = getIt<ChatData>();
  final List<Map<String, dynamic>> messagesList = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool isCameraImage = false;
  bool isCameraVideo = false;

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

  ChatBloc._() : super(ChatInitial()) {
    on<FetchEmployees>(_fetchEmployees);
    on<SendChatMessage>(_sendMessage);
    on<RebuildChatMessagingScreen>(_rebuildChatMessage);
    on<FetchChatsList>(_fetchChatsList);
    on<CreateChatGroup>(_createChatGroup);
    on<PickMedia>(_pickMedia);
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
              await _customerCache.getHashCode(CacheKeys.hashcode) ?? '');
      if (fetchEmployeesModel.data.isNotEmpty) {
        await _databaseHelper.insertEmployees(fetchEmployeesModel.data);
        emit(EmployeesFetched(fetchEmployeesModel: fetchEmployeesModel));
      } else {
        emit(
            EmployeesNotFetched(errorMessage: StringConstants.kNoRecordsFound));
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
        "sid": "1", // Aditya add is here
        "stype": "1",
        "rid": (event.sendMessageMap['isGroup'] == true)
            ? groupId
            : event.sendMessageMap['employee_id'] ?? '',
        "rtype": event.sendMessageMap['employee_type'] ?? '',
        "msg_type": "1",
        "msg_time": isoDateString,
        "msg": event.sendMessageMap['message'] ?? '',
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "sid_2": 2,
        "stype_2": "3"
      };
      print(
          'send message map---->${jsonEncode(sendMessageMap)}'); // you can check the post map here.
      Map<String, dynamic> employeeDetailsMap = {
        "employee_name": event.sendMessageMap['employee_name'] ?? '',
        "employee_id": event.sendMessageMap['employee_id'] ?? ''
      };
      Map<String, dynamic> chatDetailsMap = {
        ...sendMessageMap,
        ...employeeDetailsMap
      };
      chatDetailsMap['isReceiver'] = 0;
      chatDetailsMap['messageType'] = event.sendMessageMap['mediaType'];
      await _databaseHelper.insertMessage(chatDetailsMap);
      event.sendMessageMap['isMedia'] = false;
      add(RebuildChatMessagingScreen(employeeDetailsMap: event.sendMessageMap));
      SendMessageModel sendMessageModel =
          await _chatBoxRepository.sendMessage(sendMessageMap);
      if (sendMessageModel.status == 200) {
        await _databaseHelper.updateMessageStatus(messageId);
      }
    } catch (e) {
      emit(CouldNotSendMessage(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _rebuildChatMessage(
      RebuildChatMessagingScreen event, Emitter<ChatState> emit) async {
    List<Map<String, dynamic>> messages = await _databaseHelper
        .getMessagesForEmployee(event.employeeDetailsMap['employee_id']);
    messages = List.from(messages.reversed);
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
      List<Map<String, dynamic>> message = await _databaseHelper
          .getMessagesForEmployee(employees[i]['employee_id']);
      List lastMessageList = [];
      lastMessageList.addAll(message);
      ChatData chat = ChatData(
          employeeId: employees[i]['employee_id'],
          employeeName: lastMessageList.last['employee_name'] ?? 'xxx',
          message: lastMessageList.last['msg'],
          isGroup: false);
      individualChatList.add(chat);
    }

    if (groupChats.isNotEmpty) {
      for (var item in groupChats) {
        ChatData chat = ChatData(
            groupName: item['group_name'],
            groupPurpose: item['purpose'],
            message: '',
            isGroup: true);
        groupChatList.add(chat);
      }
    }

    final chatsList = [...individualChatList, ...groupChatList];
    _allChatScreenDetailsStreamController.add(chatsList);
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
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
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
              add(RebuildChatMessagingScreen(
                  employeeDetailsMap: event.mediaDetailsMap));
            } else {
              return;
            }
        }
      }
    } catch (e) {
      e.toString();
    }
  }
}
