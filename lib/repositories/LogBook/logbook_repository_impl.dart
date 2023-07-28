import 'package:toolkit/data/models/LogBook/fetch_logbook_list_model.dart';
import 'package:toolkit/data/models/LogBook/fetch_logbook_master_model.dart';
import 'package:toolkit/data/models/LogBook/report_new_logbook_model.dart';

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
  Future<LogBookFetchMasterModel> fetchLogBookMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}sllog/getmaster?hashcode=$hashCode");
    return LogBookFetchMasterModel.fromJson(response);
  }

  @override
  Future<ReportNewLogBookModel> reportNewLogbook(
      Map reportNewLogbookMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}sllog/save", reportNewLogbookMap);
    return ReportNewLogBookModel.fromJson(response);
  }
}
