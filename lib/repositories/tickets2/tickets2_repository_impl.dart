import 'package:toolkit/repositories/tickets2/tickets2_repository.dart';

import '../../data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../data/models/tickets2/save_ticket2_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class Tickets2RepositoryImpl extends Tickets2Repository {
  // @override
  // Future<FetchTickets2Model> fetchTickets2(
  //     int pageNo, String hashCode, String filter) async {
  //   final response = await DioClient().get(
  //       "${ApiConstants.baseUrl}ticket2/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
  //   return FetchTickets2Model.fromJson(response);
  // }
  //
  @override
  Future<FetchTicket2MasterModel> fetchTicket2Master(
      String hashCode, String responsequeid) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}ticket2/getmaster?hashcode=$hashCode&responsequeid=$responsequeid");
    return FetchTicket2MasterModel.fromJson(response);
  }

//
// @override
// Future<FetchTicket2DetailsModel> fetchTicket2Details(
//     String hashCode, String ticketId, String userId) async {
//   final response = await DioClient().get(
//       "${ApiConstants.baseUrl}ticket2/getticket?hashcode=$hashCode&ticketid=$ticketId&userid=$userId");
//   return FetchTicket2DetailsModel.fromJson(response);
// }

  @override
  Future<SaveTicket2Model> saveTicket2Model(Map saveTicket2Map) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}ticket2/save", saveTicket2Map);
    return SaveTicket2Model.fromJson(response);
  }

// @override
// Future<SaveTicket2CommentModel> saveTicket2Comment(Map saveCommentMap) async {
//   final response = await DioClient()
//       .post("${ApiConstants.baseUrl}ticket2/savecomments", saveCommentMap);
//   return SaveTicket2CommentModel.fromJson(response);
// }
//
// @override
// Future<SaveTicket2DocumentModel> saveTicket2Document(
//     Map saveDocumentMap) async {
//   final response = await DioClient()
//       .post("${ApiConstants.baseUrl}ticket2/savedocument", saveDocumentMap);
//   return SaveTicket2DocumentModel.fromJson(response);
// }
//
// @override
// Future<UpdateTicket2StatusModel> updateTicket2Status(
//     Map updateStatusMap) async {
//   final response = await DioClient()
//       .post("${ApiConstants.baseUrl}ticket2/updatestatus", updateStatusMap);
//   return UpdateTicket2StatusModel.fromJson(response);
// }
//
// @override
// Future<OpenTicket2Model> openTicket2(Map openTicket2Map) async {
//   final response = await DioClient()
//       .post("${ApiConstants.baseUrl}ticket2/OpenTicket", openTicket2Map);
//   return OpenTicket2Model.fromJson(response);
// }
}