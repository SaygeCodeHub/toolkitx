import 'package:toolkit/data/models/tickets/fetch_ticket_details_model.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_master_model.dart';
import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';
import 'package:toolkit/data/models/tickets/save_ticket_comment_model.dart';
import 'package:toolkit/data/models/tickets/save_ticket_model.dart';
import 'package:toolkit/data/models/tickets/update_ticket_status_model.dart';
import 'package:toolkit/repositories/tickets/tickets_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class TicketsRepositoryImpl extends TicketsRepository {
  @override
  Future<FetchTicketsModel> fetchTickets(
      int pageNo, String hashCode, String filter) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}ticket/get?pageno=$pageNo&hashcode=$hashCode&filter=$filter");
    return FetchTicketsModel.fromJson(response);
  }

  @override
  Future<FetchTicketMasterModel> fetchTicketMaster(String hashCode) async {
    final response = await DioClient()
        .get("${ApiConstants.baseUrl}ticket/getmaster?hashcode=$hashCode");
    return FetchTicketMasterModel.fromJson(response);
  }

  @override
  Future<FetchTicketDetailsModel> fetchTicketDetails(
      String hashCode, String ticketId, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}ticket/getticket?hashcode=$hashCode&ticketid=$ticketId&userid=$userId");
    return FetchTicketDetailsModel.fromJson(response);
  }

  @override
  Future<SaveTicketModel> saveTicketModel(Map saveTicketMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}ticket/save", saveTicketMap);
    return SaveTicketModel.fromJson(response);
  }

  @override
  Future<SaveTicketCommentModel> saveTicketComment(Map saveCommentMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}ticket/savecomments", saveCommentMap);
    return SaveTicketCommentModel.fromJson(response);
  }

  @override
  Future<UpdateTicketStatusModel> updateTicketStatus(
      Map updateStatusMap) async {
    final response = await DioClient()
        .post("${ApiConstants.baseUrl}ticket/updatestatus", updateStatusMap);
    return UpdateTicketStatusModel.fromJson(response);
  }
}
