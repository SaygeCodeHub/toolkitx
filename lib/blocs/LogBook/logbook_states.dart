import '../../data/models/LogBook/fetch_log_book_details_model.dart';
import '../../data/models/LogBook/fetch_logbook_list_model.dart';
import '../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../data/models/LogBook/report_new_logbook_model.dart';

abstract class LogbookStates {
  const LogbookStates();
}

class LogbookInitial extends LogbookStates {}

class FetchingLogbookList extends LogbookStates {}

class LogbookListFetched extends LogbookStates {
  final FetchLogBookListModel fetchLogBookListModel;
  final String privateApiKey;
  final Map filtersMap;

  const LogbookListFetched(
      {required this.filtersMap,
      required this.privateApiKey,
      required this.fetchLogBookListModel});
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

class LogBookFetchingMaster extends LogbookStates {}

class LogBookMasterFetched extends LogbookStates {
  final LogBookFetchMasterModel logBookFetchMasterModel;
  final Map filterMap;

  LogBookMasterFetched(
      {required this.filterMap, required this.logBookFetchMasterModel});
}

class LogBookMasterNotFetched extends LogbookStates {
  final String masterNotFetched;

  LogBookMasterNotFetched({required this.masterNotFetched});
}

class LogBookTypeSelected extends LogbookStates {
  final String typeName;
  final List typeNameList;

  LogBookTypeSelected({required this.typeNameList, required this.typeName});
}

class LogBookActivitySelected extends LogbookStates {
  final String activityName;

  LogBookActivitySelected({required this.activityName});
}

class LogBookLocationSelected extends LogbookStates {
  final String locationId;
  final String locationName;

  LogBookLocationSelected(
      {required this.locationId, required this.locationName});
}

class LogBookPrioritySelected extends LogbookStates {
  final Map priorityMap;
  final String priorityName;

  LogBookPrioritySelected(
      {required this.priorityName, required this.priorityMap});
}

class LogBookHandoverSelected extends LogbookStates {
  final Map handoverMap;
  final String handoverValue;

  LogBookHandoverSelected(
      {required this.handoverMap, required this.handoverValue});
}

class NewLogBookReporting extends LogbookStates {}

class NewLogBookReported extends LogbookStates {
  final ReportNewLogBookModel reportNewLogBookModel;

  NewLogBookReported({required this.reportNewLogBookModel});
}

class NewLogBookNotReported extends LogbookStates {
  final String logbookNotReported;

  NewLogBookNotReported({required this.logbookNotReported});
}

class LogBookActivityFilterSelected extends LogbookStates {
  final String selectIndex;

  LogBookActivityFilterSelected({required this.selectIndex});
}

class LogBookFilterSelected extends LogbookStates {
  final String selectIndex;

  LogBookFilterSelected({required this.selectIndex});
}

class LogBookFilterPrioritySelected extends LogbookStates {
  final String selectIndex;

  LogBookFilterPrioritySelected({required this.selectIndex});
}

class LogBookFilterStatusSelected extends LogbookStates {
  final String selectIndex;

  LogBookFilterStatusSelected({required this.selectIndex});
}

class LogBookFilterTypesSelected extends LogbookStates {
  final List selectedTypesList;

  LogBookFilterTypesSelected({required this.selectedTypesList});
}
