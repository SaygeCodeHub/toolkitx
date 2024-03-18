import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';

abstract class TicketsRepository {
  Future<FetchTicketsModel> fetchTickets(
      int pageNo, String hashCode, String filter);
}
