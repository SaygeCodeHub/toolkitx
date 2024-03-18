import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';

import '../../data/models/tickets/fetch_ticket_master_model.dart';

abstract class TicketsRepository {
  Future<FetchTicketsModel> fetchTickets(
      int pageNo, String hashCode, String filter);

  Future<FetchTicketMasterModel> fetchTicketMaster(String hashCode);
}
