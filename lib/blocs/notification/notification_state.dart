part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class MessagesFetching extends NotificationState {}

class MessagesFetched extends NotificationState {
  final FetchMessagesModel fetchMessagesModel;

  MessagesFetched({required this.fetchMessagesModel});
}

class MessagesNotFetched extends NotificationState {
  final String errorMessage;

  MessagesNotFetched({required this.errorMessage});
}
