import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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

class ChatBoxBloc extends Bloc<ChatEvent, ChatState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final ChatData chatData = getIt<ChatData>();
  final List<Map<String, dynamic>> messagesList = [];

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

  ChatBoxBloc._() : super(ChatInitial()) {
    on<FetchEmployees>(_fetchEmployees);
    on<SendChatMessage>(_sendMessage);
    on<RebuildChatMessagingScreen>(_rebuildChat);
    on<FetchChatsList>(_fetchChats);
    on<CreateChatGroup>(_createChatGroup);
  }

  static final ChatBoxBloc _instance = ChatBoxBloc._();

  factory ChatBoxBloc() => _instance;

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
        "sid": "1",
        "stype": "1",
        "rid": event.sendMessageMap['employee_id'] ?? '',
        "rtype": "3",
        "msg_type": "1",
        "msg_time": isoDateString,
        "msg": event.sendMessageMap['message'] ?? '',
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "sid_2": 2,
        "stype_2": "3"
      };
      Map<String, dynamic> employeeDetailsMap = {
        "employee_name": event.sendMessageMap['employee_name'] ?? '',
        "employee_id": event.sendMessageMap['employee_id'] ?? ''
      };
      Map<String, dynamic> chatDetailsMap = {
        ...sendMessageMap,
        ...employeeDetailsMap
      };
      chatDetailsMap['isReceiver'] = 0;
      await _databaseHelper.insertMessage(chatDetailsMap);
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

  FutureOr<void> _rebuildChat(
      RebuildChatMessagingScreen event, Emitter<ChatState> emit) async {
    List<Map<String, dynamic>> messages = await _databaseHelper
        .getMessagesForEmployee(event.employeeDetailsMap['employee_id']);
    messages = List.from(messages.reversed);
    messagesList.clear();
    messagesList.addAll(messages);
    _chatScreenMessagesStreamController.add(messagesList);
    add(FetchChatsList());
  }

  FutureOr<void> _fetchChats(
      FetchChatsList event, Emitter<ChatState> emit) async {
    List employees = await _databaseHelper.getLatestMessagesForEmployees();
    chatDetailsList.clear();
    for (int i = 0; i < employees.length; i++) {
      List<Map<String, dynamic>> message = await _databaseHelper
          .getMessagesForEmployee(employees[i]['employee_id']);
      List lastMessageList = [];
      lastMessageList.addAll(message);
      if (lastMessageList.last['employee_name'] == null) {
        lastMessageList[i]['employee_id'] ==
            lastMessageList.last['employee_id'];
        String employeeName = lastMessageList[i]['employee_name'];
        ChatData chat = ChatData(
            employeeId: employees[i]['employee_id'],
            employeeName: employeeName,
            message: lastMessageList.last['msg']);
        chatDetailsList.add(chat);
      } else {
        ChatData chat = ChatData(
            employeeId: employees[i]['employee_id'],
            employeeName: lastMessageList.last['employee_name'],
            message: lastMessageList.last['msg']);
        chatDetailsList.add(chat);
      }
    }
    _allChatScreenDetailsStreamController.add(chatDetailsList);
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
        _databaseHelper.insertGroupDetails(ChatData(
            groupId: groupId,
            groupName: chatData.groupName,
            groupPurpose: chatData.groupPurpose));
        _databaseHelper.insertGroupMembers(groupId, chatData.members);
        add(FetchChatsList());
        emit(ChatGroupCreated());
      } else {
        emit(ChatGroupCannotCreate(errorMessage: 'Error!'));
      }
    } catch (e) {
      emit(ChatGroupCannotCreate(errorMessage: e.toString()));
    }
  }
}
