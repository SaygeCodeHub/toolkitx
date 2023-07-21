import '../../data/models/LogBook/fetch_log_book_details_model.dart';
import '../../data/models/LogBook/fetch_logbook_list_model.dart';

abstract class LogbookStates {
  const LogbookStates();
}

class LogbookInitial extends LogbookStates {}

class FetchingLogbookList extends LogbookStates {}

class LogbookListFetched extends LogbookStates {
  final FetchLogBookListModel fetchLogBookListModel;
  final String privateApiKey;

  const LogbookListFetched(
      {required this.privateApiKey, required this.fetchLogBookListModel});
}

class LogbookFetchError extends LogbookStates {}

class FetchingLogBookDetails extends LogbookStates {}

class LogBookDetailsFetched extends LogbookStates {
  final FetchLogBookDetailsModel fetchLogBookDetailsModel;

  LogBookDetailsFetched({required this.fetchLogBookDetailsModel});
}

class LogBookDetailsNotFetched extends LogbookStates {
  final String detailsNotFetched;

  LogBookDetailsNotFetched({required this.detailsNotFetched});
}
