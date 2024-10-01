part of 'tickets2_bloc.dart';

abstract class Tickets2States {}

class Tickets2Initial extends Tickets2States {}

// class Tickets2Fetching extends Tickets2States {}
//
// class Tickets2Fetched extends Tickets2States {
//   final FetchTickets2Model fetchTickets2Model;
//   final List<TicketListDatum> ticketData;
//   final Map filterMap;
//
//   Tickets2Fetched(
//       {required this.ticketData,
//       required this.filterMap,
//       required this.fetchTickets2Model});
// }
//
// class Tickets2NotFetched extends Tickets2States {
//   final String errorMessage;
//
//   Tickets2NotFetched({required this.errorMessage});
// }

class Ticket2MasterFetching extends Tickets2States {}

class Ticket2MasterFetched extends Tickets2States {
  final FetchTicket2MasterModel fetchTicket2MasterModel;
  final String desc;

  Ticket2MasterFetched(
      {required this.fetchTicket2MasterModel, required this.desc});
}

class Ticket2MasterNotFetched extends Tickets2States {
  final String errorMessage;

  Ticket2MasterNotFetched({required this.errorMessage});
}

// class Ticket2StatusFilterSelected extends Tickets2States {
//   final String selectedIndex;
//   final bool selected;
//
//   Ticket2StatusFilterSelected(
//       {required this.selected, required this.selectedIndex});
// }
//
// class Ticket2BugFilterSelected extends Tickets2States {
//   final String selectedIndex;
//   final bool selected;
//
//   Ticket2BugFilterSelected(
//       {required this.selected, required this.selectedIndex});
// }
//
// class Ticket2ApplicationFilterSelected extends Tickets2States {
//   final int selectApplicationName;
//
//   Ticket2ApplicationFilterSelected({required this.selectApplicationName});
// }
//
// class Ticket2DetailsFetching extends Tickets2States {}
//
// class Ticket2DetailsFetched extends Tickets2States {
//   final FetchTicket2DetailsModel fetchTicket2DetailsModel;
//   final List ticketPopUpMenu;
//   final String clientId;
//
//   Ticket2DetailsFetched(
//       {required this.fetchTicket2DetailsModel,
//       required this.ticketPopUpMenu,
//       required this.clientId});
// }
//
// class Ticket2DetailsNotFetched extends Tickets2States {
//   final String errorMessage;
//
//   Ticket2DetailsNotFetched({required this.errorMessage});
// }

class Ticket2Saving extends Tickets2States {}

class Ticket2Saved extends Tickets2States {
  final SaveTicket2Model saveTicket2Model;

  Ticket2Saved({required this.saveTicket2Model});
}

class Ticket2NotSaved extends Tickets2States {
  final String errorMessage;

  Ticket2NotSaved({required this.errorMessage});
}

// class PrioritySelected extends Tickets2States {
//   final int priorityId;
//   final String priorityName;
//
//   PrioritySelected({required this.priorityId, required this.priorityName});
// }
//
// class BugTypeSelected extends Tickets2States {
//   final String bugType;
//   final String bugValue;
//
//   BugTypeSelected({required this.bugType, required this.bugValue});
// }
//
// class Ticket2CommentSaving extends Tickets2States {}
//
// class Ticket2CommentSaved extends Tickets2States {}
//
// class Ticket2CommentNotSaved extends Tickets2States {
//   final String errorMessage;
//
//   Ticket2CommentNotSaved({required this.errorMessage});
// }
//
// class Ticket2DocumentSaving extends Tickets2States {}
//
// class Ticket2DocumentSaved extends Tickets2States {}
//
// class Ticket2DocumentNotSaved extends Tickets2States {
//   final String errorMessage;
//
//   Ticket2DocumentNotSaved({required this.errorMessage});
// }
//
// class Ticket2StatusUpdating extends Tickets2States {}
//
// class Ticket2StatusUpdated extends Tickets2States {}
//
// class Ticket2StatusNotUpdated extends Tickets2States {
//   final String errorMessage;
//
//   Ticket2StatusNotUpdated({required this.errorMessage});
// }
//
// class OpenTicket2Saving extends Tickets2States {}
//
// class OpenTicket2Saved extends Tickets2States {}
//
// class OpenTicket2NotSaved extends Tickets2States {
//   final String errorMessage;
//
//   OpenTicket2NotSaved({required this.errorMessage});
// }
//
// class VoValueSelected extends Tickets2States {
//   final String value;
//   final String vo;
//
//   VoValueSelected({required this.value, required this.vo});
// }