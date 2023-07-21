import 'package:toolkit/data/models/LogBook/fetch_log_book_details_model.dart';
import 'package:toolkit/data/models/LogBook/fetch_logbook_list_model.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';
import 'logbook_repository.dart';

class LogbookRepositoryImpl extends LogbookRepository {
  @override
  Future<FetchLogBookListModel> fetchLogbookList(
      String userId, String hashCode, String filter, int page) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}sllog/get?pageno=$page&userid=$userId&hashcode=$hashCode&filter=");
    return FetchLogBookListModel.fromJson(response);
  }

  @override
  Future<FetchLogBookDetailsModel> fetchLogBookDetails(
      String logId, String hashCode) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}sllog/getlog?logid=$logId&hashcode=$hashCode");
    return FetchLogBookDetailsModel.fromJson(response);
  }
}
