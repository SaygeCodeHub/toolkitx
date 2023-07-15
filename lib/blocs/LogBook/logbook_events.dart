abstract class LogbookEvents {}

class FetchLogbookList extends LogbookEvents {
  final int pageNo;

  FetchLogbookList({required this.pageNo});
}
