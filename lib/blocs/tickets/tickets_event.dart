part of 'tickets_bloc.dart';

abstract class TicketsEvents {}

class FetchTickets extends TicketsEvents {
  final int pageNo;
  final bool isFromHome;

  FetchTickets({required this.isFromHome, required this.pageNo});
}

class FetchTicketMaster extends TicketsEvents {}

class SelectTicketStatusFilter extends TicketsEvents {
  final String selectedIndex;
  final bool selected;

  SelectTicketStatusFilter(
      {required this.selected, required this.selectedIndex});
}

class SelectTicketBugFilter extends TicketsEvents {
  final String selectedIndex;
  final bool selected;

  SelectTicketBugFilter({required this.selected, required this.selectedIndex});
}

class SelectTicketApplication extends TicketsEvents {
  final int selectApplicationName;

  SelectTicketApplication({required this.selectApplicationName});
}

class ApplyTicketsFilter extends TicketsEvents {
  final Map ticketsFilterMap;

  ApplyTicketsFilter({required this.ticketsFilterMap});
}

class ClearTicketsFilter extends TicketsEvents {}

class FetchTicketDetails extends TicketsEvents {
  final String ticketId;
  final int ticketTabIndex;

  FetchTicketDetails({required this.ticketId, required this.ticketTabIndex});
}
