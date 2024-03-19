part of 'tickets_bloc.dart';

abstract class TicketsStates {}

class TicketsInitial extends TicketsStates {}

class TicketsFetching extends TicketsStates {}

class TicketsFetched extends TicketsStates {
  final FetchTicketsModel fetchTicketsModel;
  final List<TicketListDatum> ticketData;
  final Map filterMap;

  TicketsFetched(
      {required this.ticketData,
      required this.filterMap,
      required this.fetchTicketsModel});
}

class TicketsNotFetched extends TicketsStates {
  final String errorMessage;

  TicketsNotFetched({required this.errorMessage});
}

class TicketMasterFetching extends TicketsStates {}

class TicketMasterFetched extends TicketsStates {
  final FetchTicketMasterModel fetchTicketMasterModel;

  TicketMasterFetched({required this.fetchTicketMasterModel});
}

class TicketMasterNotFetched extends TicketsStates {
  final String errorMessage;

  TicketMasterNotFetched({required this.errorMessage});
}

class TicketStatusFilterSelected extends TicketsStates {
  final String selectedIndex;
  final bool selected;

  TicketStatusFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class TicketBugFilterSelected extends TicketsStates {
  final String selectedIndex;
  final bool selected;

  TicketBugFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class TicketApplicationFilterSelected extends TicketsStates {
  final int selectApplicationName;

  TicketApplicationFilterSelected({required this.selectApplicationName});
}
