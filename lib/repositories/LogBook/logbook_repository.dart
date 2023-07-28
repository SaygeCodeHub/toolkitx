import '../../data/models/LogBook/fetch_log_book_details_model.dart';
import '../../data/models/LogBook/fetch_logbook_list_model.dart';

abstract class LogbookRepository {
  Future<FetchLogBookListModel> fetchLogbookList(
      String userId, String hashCode, String filter, int page);

  Future<FetchLogBookDetailsModel> fetchLogBookDetails(
      String logId, String hashCode);
}
