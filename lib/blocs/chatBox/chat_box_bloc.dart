import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/cache/customer_cache.dart';
import 'package:toolkit/data/models/chatBox/fetch_employees_model.dart';
import 'package:toolkit/data/models/chatBox/send_message_model.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/repositories/chatBox/chat_box_repository.dart';
import 'package:toolkit/screens/chatBox/widgets/chat_details_model_class.dart';
import 'package:toolkit/utils/chat_database_util.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'dart:math';

class ChatBoxBloc extends Bloc<ChatBoxEvent, ChatBoxState> {
  final ChatBoxRepository _chatBoxRepository = getIt<ChatBoxRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final List<Map<String, dynamic>> messagesList = [];
  final List<Chat> chatsList = [];

  ChatBoxBloc() : super(ChatBoxInitial()) {
    on<FetchEmployees>(_fetchEmployees);
    on<SendMessage>(_sendMessage);
    on<RebuildChat>(_rebuildChat);
    on<FetchChatsList>(_fetchChats);
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
        "rid": 2,
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
    emit(ChatHasBeenRebuild(messages: messagesList));
    chatsList.clear();
    add(FetchChatsList());
  }

  FutureOr<void> _fetchChats(
      FetchChatsList event, Emitter<ChatBoxState> emit) async {
    List<Map<String, dynamic>> messages =
        await _databaseHelper.getLatestMessagesForEmployees();
    for (var message in messages) {
      Chat chat = Chat(
        employeeId: message['employee_id'],
        employeeName: message['employee_name'],
        message: message['msg'],
      );
      chatsList.add(chat);
    }
    emit(ChatListFetched(chatsList: chatsList));
  }
}
