abstract class LogbookEvents {}

class FetchLogbookList extends LogbookEvents {
  final int pageNo;
  final bool isFromHome;

  FetchLogbookList({required this.isFromHome, required this.pageNo});
}

class FetchLogBookDetails extends LogbookEvents {
  final String logId;

  FetchLogBookDetails({required this.logId});
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

class ApplyLogBookFilter extends LogbookEvents {
  final Map filterMap;

  ApplyLogBookFilter({required this.filterMap});
}

class ClearLogBookFilter extends LogbookEvents {}

class SelectLogBookActivityFilter extends LogbookEvents {
  final String selectedIndex;

  SelectLogBookActivityFilter({required this.selectedIndex});
}

class SelectLogBookFilter extends LogbookEvents {
  final String selectedIndex;

  SelectLogBookFilter({required this.selectedIndex});
}

class SelectLogBookPriorityFilter extends LogbookEvents {
  final String selectedIndex;

  SelectLogBookPriorityFilter({required this.selectedIndex});
}

class SelectLogBookStatusFilter extends LogbookEvents {
  final String selectedIndex;

  SelectLogBookStatusFilter({required this.selectedIndex});
}
