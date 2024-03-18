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
