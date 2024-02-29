import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/chatBox/create_chat_group_model.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/screens/chatBox/widgets/chat_data_model.dart';
import 'package:toolkit/utils/chat_database_util.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'dart:math';

class ChatBoxBloc extends Bloc<ChatBoxEvent, ChatBoxState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final ChatData newGroupDetails = getIt<ChatData>();
  final List<Map<String, dynamic>> messagesList = [];
  List<ChatData> chatDetailsList = [];
  final _chatScreenMessagesStreamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get messageStream =>
      _chatScreenMessagesStreamController.stream;
  final _allChatScreenDetailsStreamController =
      StreamController<List<ChatData>>.broadcast();

  Stream<List<ChatData>> get allChatsStream =>
      _allChatScreenDetailsStreamController.stream;
  int groupId = 0;

  ChatBoxBloc() : super(ChatBoxInitial()) {
    on<FetchEmployees>(_fetchEmployees);
    on<SendMessage>(_sendMessage);
    on<RebuildChat>(_rebuildChat);
    on<FetchChatsList>(_fetchChats);
    on<CreateChatGroup>(_createChatGroup);
  }

  @override
  Future<void> close() {
    _chatScreenMessagesStreamController.close();
    return super.close();
  }

  FutureOr<void> _fetchEmployees(
      FetchEmployees event, Emitter<ChatBoxState> emit) async {
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
      SendMessage event, Emitter<ChatBoxState> emit) async {
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
      await _databaseHelper.insertMessage(chatDetailsMap);
      add(RebuildChat(employeeDetailsMap: event.sendMessageMap));
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
      RebuildChat event, Emitter<ChatBoxState> emit) async {
    List<Map<String, dynamic>> messages = await _databaseHelper
        .getMessagesForEmployee(event.employeeDetailsMap['employee_id']);
    messages = List.from(messages.reversed);
    messagesList.clear();
    messagesList.addAll(messages);
    _chatScreenMessagesStreamController.add(messages);
    chatDetailsList.clear();
    add(FetchChatsList());
  }

  FutureOr<void> _fetchChats(
      FetchChatsList event, Emitter<ChatBoxState> emit) async {
    List<Map<String, dynamic>> messages =
        await _databaseHelper.getLatestMessagesForEmployees();
    String name = '';
    if (groupId != 0) {
      ChatData? data = await _databaseHelper.getGroupDetails(groupId);
      name = data?.groupName ?? '';
      print('data----->${data?.chatToMap()}');
      List<Members> members = await _databaseHelper.getGroupMembers(groupId);
      print('group details------>${members.first.toMap()}');
    }
    print('outside----->$name');
    for (var message in messages) {
      ChatData chat = ChatData(
          employeeId: message['employee_id'],
          employeeName: message['employee_name'],
          message: message['msg'],
          groupName: name);
      chatDetailsList.add(chat);
      _allChatScreenDetailsStreamController.add(chatDetailsList);
    }
  }

  FutureOr<void> _createChatGroup(
      CreateChatGroup event, Emitter<ChatBoxState> emit) async {
    try {
      emit(CreatingChatGroup());
      CreateChatGroupModel chatGroupModel =
          await _chatBoxRepository.createChatGroup({
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "name": newGroupDetails.groupName,
        "purpose": newGroupDetails.groupPurpose ?? '',
        "members": newGroupDetails.membersToMap()
      });
      if (chatGroupModel.status == 200) {
        groupId = chatGroupModel.data.groupId;
        _databaseHelper.insertGroupDetails(ChatData(
            groupId: groupId,
            groupName: newGroupDetails.groupName,
            groupPurpose: newGroupDetails.groupPurpose));
        _databaseHelper.insertGroupMembers(groupId, newGroupDetails.members);
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
