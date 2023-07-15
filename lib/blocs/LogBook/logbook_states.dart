import '../../data/models/LogBook/fetch_logbook_list_model.dart';

abstract class LogbookStates {
  const LogbookStates();
}

class LogbookInitial extends LogbookStates {}

class FetchingLogbookList extends LogbookStates {}

class LogbookListFetched extends LogbookStates {
  final FetchLogBookListModel fetchLogBookListModel;

  const LogbookListFetched({required this.fetchLogBookListModel});
}

class LogbookFetchError extends LogbookStates {}
