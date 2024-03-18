part of 'tickets_bloc.dart';

abstract class TicketsEvents {}

class FetchTickets extends TicketsEvents {
  final int pageNo;

  FetchTickets({required this.pageNo});
}

class FetchTicketMaster extends TicketsEvents {}