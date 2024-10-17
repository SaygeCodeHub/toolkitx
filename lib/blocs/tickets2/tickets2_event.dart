part of 'tickets2_bloc.dart';

abstract class Tickets2Events {}

class FetchTickets2 extends Tickets2Events {
  final int pageNo;
  final bool isFromHome;

  FetchTickets2({required this.isFromHome, required this.pageNo});
}

class FetchTicket2Master extends Tickets2Events {
  final String responsequeid;

  FetchTicket2Master({required this.responsequeid});
}

class SelectTicket2StatusFilter extends Tickets2Events {
  final String selectedIndex;
  final bool selected;

  SelectTicket2StatusFilter(
      {required this.selected, required this.selectedIndex});
}

class SelectTicket2BugFilter extends Tickets2Events {
  final String selectedIndex;
  final bool selected;

  SelectTicket2BugFilter({required this.selected, required this.selectedIndex});
}

class SelectTicket2Application extends Tickets2Events {
  final int selectApplicationName;

  SelectTicket2Application({required this.selectApplicationName});
}

class ApplyTickets2Filter extends Tickets2Events {
  final Map ticketsFilterMap;

  ApplyTickets2Filter({required this.ticketsFilterMap});
}

class ClearTickets2Filter extends Tickets2Events {}

class FetchTicket2Details extends Tickets2Events {
  final String ticketId;
  final int ticketTabIndex;

  FetchTicket2Details({required this.ticketId, required this.ticketTabIndex});
}

class SaveTicket2 extends Tickets2Events {
  final Map saveTicket2Map;

  SaveTicket2({required this.saveTicket2Map});
}

class SelectPriority extends Tickets2Events {
  final int priorityId;
  final String priorityName;

  SelectPriority({required this.priorityId, required this.priorityName});
}

class SelectBugType extends Tickets2Events {
  final String bugType;
  final String bugValue;

  SelectBugType({required this.bugType, required this.bugValue});
}

class SaveTicket2Comment extends Tickets2Events {
  final String comment;

  SaveTicket2Comment({required this.comment});
}

class SaveTicket2Document extends Tickets2Events {
  final Map saveDocumentMap;

  SaveTicket2Document({required this.saveDocumentMap});
}

class UpdateTicket2Status extends Tickets2Events {
  final int? edtHrs;
  final String completionDate;
  final String status;

  UpdateTicket2Status(
      {required this.edtHrs,
      required this.completionDate,
      required this.status});
}

class SaveOpenTicket2 extends Tickets2Events {
  final String value;

  SaveOpenTicket2({required this.value});
}

class SelectVoValue extends Tickets2Events {
  final String value;
  final String vo;

  SelectVoValue({required this.value, required this.vo});
}
