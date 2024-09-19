
import '../../data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../data/models/tickets2/save_ticket2_model.dart';

abstract class Tickets2Repository {
  // Future<FetchTickets2Model> fetchTickets2(
  //     int pageNo, String hashCode, String filter);
  //
  Future<FetchTicket2MasterModel> fetchTicket2Master(String hashCode,String responsequeid);
  //
  // Future<FetchTicket2DetailsModel> fetchTicket2Details(
  //     String hashCode, String ticketId, String userId);

  Future<SaveTicket2Model> saveTicket2Model(Map saveTicket2Map);

  // Future<SaveTicket2CommentModel> saveTicket2Comment(Map saveCommentMap);
  //
  // Future<SaveTicket2DocumentModel> saveTicket2Document(Map saveDocumentMap);
  //
  // Future<UpdateTicket2StatusModel> updateTicket2Status(Map updateStatusMap);
  //
  // Future<OpenTicket2Model> openTicket2(Map openTicket2Map);
}
