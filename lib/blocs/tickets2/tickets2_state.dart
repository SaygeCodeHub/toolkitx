import '../../data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../data/models/tickets2/fetch_ticket_two_details_model.dart';
import '../../data/models/tickets2/fetch_tickets_two_model.dart';
import '../../data/models/tickets2/save_ticket2_model.dart';

abstract class Tickets2States {}

class Tickets2Initial extends Tickets2States {}

class Tickets2Fetching extends Tickets2States {}

class Tickets2Fetched extends Tickets2States {
  final FetchTicketsTwoModel fetchTickets2Model;
  final List<TicketListDatum> ticketData;
  final Map filterMap;

  Tickets2Fetched(
      {required this.ticketData,
      required this.filterMap,
      required this.fetchTickets2Model});
}

class Tickets2NotFetched extends Tickets2States {
  final String errorMessage;

  Tickets2NotFetched({required this.errorMessage});
}

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

class Ticket2StatusFilterSelected extends Tickets2States {
  final String selectedIndex;
  final bool selected;

  Ticket2StatusFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class Ticket2BugFilterSelected extends Tickets2States {
  final String selectedIndex;
  final bool selected;

  Ticket2BugFilterSelected(
      {required this.selected, required this.selectedIndex});
}

class Ticket2ApplicationFilterSelected extends Tickets2States {
  final int selectApplicationName;

  Ticket2ApplicationFilterSelected({required this.selectApplicationName});
}

class Ticket2DetailsFetching extends Tickets2States {}

class Ticket2DetailsFetched extends Tickets2States {
  final FetchTicketTwoDetailsModel fetchTicketTwoDetailsModel;
  final List ticketPopUpMenu;
  final String clientId;

  Ticket2DetailsFetched(
      {required this.fetchTicketTwoDetailsModel,
      required this.ticketPopUpMenu,
      required this.clientId});
}

class Ticket2DetailsNotFetched extends Tickets2States {
  final String errorMessage;

  Ticket2DetailsNotFetched({required this.errorMessage});
}

class Ticket2Saving extends Tickets2States {}

class Ticket2Saved extends Tickets2States {
  final SaveTicket2Model saveTicket2Model;

  Ticket2Saved({required this.saveTicket2Model});
}

class Ticket2NotSaved extends Tickets2States {
  final String errorMessage;

  Ticket2NotSaved({required this.errorMessage});
}

class TicketTwoPrioritySelected extends Tickets2States {
  final int priorityId;
  final String priorityName;

  TicketTwoPrioritySelected(
      {required this.priorityId, required this.priorityName});
}

class TicketTwoBugTypeSelected extends Tickets2States {
  final String bugType;
  final String bugValue;

  TicketTwoBugTypeSelected({required this.bugType, required this.bugValue});
}

class Ticket2CommentSaving extends Tickets2States {}

class Ticket2CommentSaved extends Tickets2States {}

class Ticket2CommentNotSaved extends Tickets2States {
  final String errorMessage;

  Ticket2CommentNotSaved({required this.errorMessage});
}

class Ticket2DocumentSaving extends Tickets2States {}

class Ticket2DocumentSaved extends Tickets2States {}

class Ticket2DocumentNotSaved extends Tickets2States {
  final String errorMessage;

  Ticket2DocumentNotSaved({required this.errorMessage});
}

class Ticket2StatusUpdating extends Tickets2States {}

class Ticket2StatusUpdated extends Tickets2States {}

class Ticket2StatusNotUpdated extends Tickets2States {
  final String errorMessage;

  Ticket2StatusNotUpdated({required this.errorMessage});
}

class OpenTicket2Saving extends Tickets2States {}

class OpenTicket2Saved extends Tickets2States {}

class OpenTicket2NotSaved extends Tickets2States {
  final String errorMessage;

  OpenTicket2NotSaved({required this.errorMessage});
}

class TicketTwoVoValueSelected extends Tickets2States {
  final String value;
  final String vo;

  TicketTwoVoValueSelected({required this.value, required this.vo});
}

class UpdatingTicketTwo extends Tickets2States {}

class TicketTwoUpdated extends Tickets2States {}

class TicketTwoNotUpdated extends Tickets2States {
  final String errorMessage;

  TicketTwoNotUpdated({required this.errorMessage});
}

class RejectingTicketTwo extends Tickets2States {}

class TicketTwoRejected extends Tickets2States {}

class TicketTwoNotRejected extends Tickets2States {
  final String errorMessage;

  TicketTwoNotRejected({required this.errorMessage});
}
