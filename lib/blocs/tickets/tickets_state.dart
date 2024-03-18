part of 'tickets_bloc.dart';

abstract class TicketsStates {}

class TicketsInitial extends TicketsStates {}

class TicketsFetching extends TicketsStates {}

class TicketsFetched extends TicketsStates {
  final FetchTicketsModel fetchTicketsModel;

  TicketsFetched({required this.fetchTicketsModel});
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
