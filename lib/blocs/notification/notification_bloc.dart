import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/notification/fetch_messages_model.dart';
import 'package:toolkit/repositories/notification/notification_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository =
      getIt<NotificationRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  NotificationState get initialState => NotificationInitial();

  NotificationBloc() : super(NotificationInitial()) {
    on<FetchMessages>(_fetchMessages);
  }

  Future<FutureOr<void>> _fetchMessages(
      FetchMessages event, Emitter<NotificationState> emit) async {
    emit(MessagesFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';

      FetchMessagesModel fetchMessagesModel =
          await _notificationRepository.fetchMessages(hashCode, userId);
      if (fetchMessagesModel.status == 200) {
        emit(MessagesFetched(fetchMessagesModel: fetchMessagesModel));
      } else {
        emit(MessagesNotFetched(errorMessage: fetchMessagesModel.message!));
      }
    } catch (e) {
      emit(MessagesNotFetched(errorMessage: e.toString()));
    }
  }
}
