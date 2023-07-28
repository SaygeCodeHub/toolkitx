abstract class LogbookEvents {}

class FetchLogbookList extends LogbookEvents {
  final int pageNo;

  FetchLogbookList({required this.pageNo});
}

class FetchLogBookMaster extends LogbookEvents {}

class SelectLogBookType extends LogbookEvents {
  final String typeName;
  final List typeNameList;

  SelectLogBookType({required this.typeNameList, required this.typeName});
}

class SelectLogBookActivity extends LogbookEvents {
  final String activityName;

  SelectLogBookActivity({required this.activityName});
}

class SelectLogBookLocation extends LogbookEvents {
  final String locationId;
  final String locationName;

  SelectLogBookLocation({required this.locationId, required this.locationName});
}

class SelectLogBookPriority extends LogbookEvents {
  final String priorityName;

  SelectLogBookPriority({required this.priorityName});
}

class SelectLogBookHandoverLog extends LogbookEvents {
  final String handoverValue;

  SelectLogBookHandoverLog({required this.handoverValue});
}

class ReportNewLogBook extends LogbookEvents {
  final Map reportLogbook;

  ReportNewLogBook({required this.reportLogbook});
}
