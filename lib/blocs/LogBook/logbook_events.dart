abstract class LogbookEvents {}

class FetchLogbookList extends LogbookEvents {
  final int pageNo;

  FetchLogbookList({required this.pageNo});
}

class FetchLogBookDetails extends LogbookEvents {
  final String logId;

  FetchLogBookDetails({required this.logId});
}
