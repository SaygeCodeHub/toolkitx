import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/data/models/chatBox/fetch_messages_model.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/utils/database/database_util.dart';
import 'package:toolkit/utils/notifications/notification_util.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/client/client_list_model.dart';
import '../../data/models/client/home_screen_model.dart';
import '../../di/app_module.dart';
import '../../repositories/client/client_repository.dart';
import '../../utils/global.dart';
import '../../utils/modules_util.dart';
import 'client_events.dart';
import 'client_states.dart';

class ClientBloc extends Bloc<ClientEvents, ClientStates> {
  final ClientRepository _clientRepository = getIt<ClientRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();

  ClientStates get initialState => ClientInitial();

  ClientBloc() : super(ClientInitial()) {
    on<FetchClientList>(_fetchClientList);
    on<SelectClient>(_selectClient);
    on<FetchHomeScreenData>(_fetchHomeScreenData);
    on<FetchChatMessages>(_fetchChatMessages);
  }

  FutureOr<void> _fetchClientList(
      FetchClientList event, Emitter<ClientStates> emit) async {
    emit(ClientListFetching());
    try {
      String clientDataKey =
          (await _customerCache.getClientDataKey(CacheKeys.clientDataKey))!;
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      ClientListModel clientListModel =
          await _clientRepository.fetchClientList(clientDataKey, userType);
      if (clientListModel.data!.length == 1) {
        add(SelectClient(
            hashKey: clientListModel.data![0].hashkey.toString(),
            apiKey: clientListModel.data![0].apikey,
            image: clientListModel.data![0].hashimg,
            isFromProfile: false));
      }
      emit(ClientListFetched(clientListModel: clientListModel));
    } catch (e) {
      emit(FetchClientListError());
    }
  }

  FutureOr<void> _selectClient(
      SelectClient event, Emitter<ClientStates> emit) async {
    if (event.isFromProfile) {
      await _databaseHelper.recreateOfflinePermitTable();
    }
    _customerCache.setApiKey(CacheKeys.apiKey, event.apiKey);
    _customerCache.setClientId(CacheKeys.clientId, event.hashKey);
    String timeZoneCode =
        (await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode))!;
    String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
    String dateTimeValue =
        (await _customerCache.getDateFormat(CacheKeys.dateFormatKey))!;
    String hashCode =
        '${event.apiKey}|${event.hashKey}|$userType|$dateTimeValue|$timeZoneCode';
    _customerCache.setHashCode(CacheKeys.hashcode, hashCode);
    _customerCache.setClientImage(CacheKeys.clientImage, event.image);
    emit(ClientSelected());
  }

  FutureOr<void> _fetchHomeScreenData(
      FetchHomeScreenData event, Emitter<ClientStates> emit) async {
    emit(HomeScreenFetching());
    try {
      List permissionsList = [];
      int badgeCount = 0;
      String timeZoneCode =
          (await _customerCache.getTimeZoneCode(CacheKeys.timeZoneCode))!;
      String userType = (await _customerCache.getUserType(CacheKeys.userType))!;
      String hashKey = (await _customerCache.getClientId(CacheKeys.clientId))!;
      String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      String clientImage =
          (await _customerCache.getClientImage(CacheKeys.clientImage))!;
      Map fetchHomeScreenMap = {
        "hashkey": hashKey,
        "apikey": apiKey,
        "type": userType,
        "timezonecode": timeZoneCode
      };
      HomeScreenModel homeScreenModel =
          await _clientRepository.fetchHomeScreen(fetchHomeScreenMap);
      if (homeScreenModel.status == 200) {
        if (event.isFirstTime == true) {
          add(FetchChatMessages());
        }
        _customerCache.setUserId(
            CacheKeys.userId, homeScreenModel.data!.userid);
        _customerCache.setUserId2(
            CacheKeys.userId2, homeScreenModel.data!.userid2);
        permissionsList =
            homeScreenModel.data!.permission.replaceAll(' ', '').split(',');
        List availableModules = [];
        permissionsList.add('safetyNotice');
        if (permissionsList.contains('wf_calendar') != true) {
          permissionsList.add('calendar');
        }
        for (int i = 0; i < ModulesUtil.listModulesMode.length; i++) {
          if (permissionsList.contains(ModulesUtil.listModulesMode[i].key) ==
              true) {
            availableModules.add(ModulesUtil.listModulesMode[i]);
          }
        }
        if (homeScreenModel.data!.badges!.isNotEmpty) {
          for (int i = 0; i < homeScreenModel.data!.badges!.length; i++) {
            badgeCount = badgeCount + homeScreenModel.data!.badges![i].count;
          }
        }

        emit(HomeScreenFetched(
            homeScreenModel: homeScreenModel,
            image: clientImage,
            availableModules: availableModules,
            badgeCount: badgeCount,
            unreadMessageCount: 0));
      } else {
        emit(FetchHomeScreenError());
      }
    } catch (e) {
      emit(FetchHomeScreenError());
    }
  }

  FutureOr<void> _fetchChatMessages(
      FetchChatMessages event, Emitter<ClientStates> emit) async {
    int pageNo = 1;
    try {
      String? newToken = await NotificationUtil().getToken();
      bool hasMoreData = true;
      while (hasMoreData) {
        FetchChatMessagesModel fetchChatMessagesModel =
            await _clientRepository.fetchChatMessages({
          'page_no': pageNo,
          'hashcode': await _customerCache.getHashCode(CacheKeys.hashcode),
          'token': newToken
        });

        if (fetchChatMessagesModel.data.isNotEmpty) {
          for (var item in fetchChatMessagesModel.data) {
            Map<String, dynamic> chatDetailsMap = {
              'rid': item.msgJson.toJson()['rid'],
              'rtype': item.msgJson.toJson()['rtype'],
              'sid': item.msgJson.toJson()['sid'],
              'stype': item.msgJson.toJson()['stype'],
              "msg_id": item.msgJson.toJson()['msg_id'],
              "quote_msg_id": "",
              "msg_type": item.msgJson.toJson()['msg_type'],
              "msg_time": item.msgJson.toJson()['msg_time'],
              "msg": item.msgJson.toJson()['msg'],
              "sid_2": "2",
              "stype_2": "1",
              "msg_status": '1',
              "isMessageUnread": 1,
              "employee_name": item.userName,
              'isReceiver': 1
            };
            await _databaseHelper.insertMessage(chatDetailsMap).then((result) {
              if (chatScreenName == ChatMessagingScreen.routeName) {
                ChatBloc().add(RebuildChatMessagingScreen(
                    employeeDetailsMap: ChatBloc().chatDetailsMap));
              } else {
                ChatBloc().add(FetchChatsList());
              }
            });
          }
          if (fetchChatMessagesModel.data.length < 30) {
            hasMoreData = false;
          } else {
            pageNo++;
          }
        } else {
          hasMoreData = false;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
