import 'package:toolkit/data/models/tickets/fetch_ticket_details_model.dart';
import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';

import '../../data/models/tickets/fetch_ticket_master_model.dart';
import '../../data/models/tickets/save_ticket_model.dart';

abstract class TicketsRepository {
  Future<FetchTicketsModel> fetchTickets(
      int pageNo, String hashCode, String filter);

  Future<FetchTicketMasterModel> fetchTicketMaster(String hashCode);

  Future<FetchTicketDetailsModel> fetchTicketDetails(
      String hashCode, String ticketId, String userId);

  Future<SaveTicketModel> saveTicketModel(Map saveTicketMap);
}
