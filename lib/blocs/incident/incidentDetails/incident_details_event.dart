abstract class IncidentDetailsEvent {
  const IncidentDetailsEvent();
}

class FetchIncidentDetailsEvent extends IncidentDetailsEvent {
  final String incidentId;
  final String role;
  final int initialIndex;

  const FetchIncidentDetailsEvent(
      {required this.initialIndex,
      required this.incidentId,
      required this.role});
}

class GenerateIncidentPDF extends IncidentDetailsEvent {
  final String incidentId;

  const GenerateIncidentPDF(this.incidentId);
}

class FetchPermitToLinkList extends IncidentDetailsEvent {
  final String incidentId;
  final int pageNo;

  FetchPermitToLinkList({required this.pageNo, required this.incidentId});
}

class SaveLikedPermits extends IncidentDetailsEvent {
  final String incidentId;
  final String savedPermitList;

  SaveLikedPermits({required this.savedPermitList, required this.incidentId});
}
