abstract class PermitEvents {
  const PermitEvents();
}

class GetAllPermits extends PermitEvents {
  final bool isFromHome;
  final int page;

  const GetAllPermits({required this.page, required this.isFromHome});
}

class GetPermitDetails extends PermitEvents {
  final String permitId;

  const GetPermitDetails({required this.permitId});
}

class GeneratePDF extends PermitEvents {
  final String permitId;

  const GeneratePDF(this.permitId);
}

class GetPermitRoles extends PermitEvents {
  const GetPermitRoles();
}

class SelectPermitRoleEvent extends PermitEvents {
  final String roleId;

  const SelectPermitRoleEvent(this.roleId);
}

class SaveFilterEvent extends PermitEvents {
  final Map filter;

  const SaveFilterEvent(this.filter);
}

class FetchPermitMaster extends PermitEvents {
  const FetchPermitMaster();
}

class ApplyPermitFilters extends PermitEvents {
  final Map permitFilters;
  final List location;

  const ApplyPermitFilters(this.permitFilters, this.location);
}

class ClearPermitFilters extends PermitEvents {
  const ClearPermitFilters();
}

class FetchClosePermitDetails extends PermitEvents {
  final String permitId;

  const FetchClosePermitDetails(this.permitId);
}

class FetchOpenPermitDetails extends PermitEvents {
  final String permitId;

  const FetchOpenPermitDetails(this.permitId);
}

class ClosePermit extends PermitEvents {
  final String permitId;
  final Map closePermitMap;
  final int? offlineActionId;

  const ClosePermit(
      {required this.closePermitMap,
      required this.permitId,
      this.offlineActionId});
}

class OpenPermit extends PermitEvents {
  final Map openPermitMap;
  final String permitId;
  final int? offlineActionId;

  const OpenPermit(this.openPermitMap, this.permitId, this.offlineActionId);
}

class RequestPermit extends PermitEvents {
  final String permitId;

  const RequestPermit(this.permitId);
}

class PreparePermitLocalDatabase extends PermitEvents {}

class FetchDataForOpenPermit extends PermitEvents {
  final String permitId;

  const FetchDataForOpenPermit({required this.permitId});
}

class FetchPermitBasicDetails extends PermitEvents {
  final String permitId;

  const FetchPermitBasicDetails({required this.permitId});
}

class SaveMarkAsPrepared extends PermitEvents {
  final String permitId;
  final Map markAsPreparedMap;
  final int? offlineActionId;

  const SaveMarkAsPrepared(
      {required this.permitId,
      required this.markAsPreparedMap,
      this.offlineActionId});
}

class AcceptPermitRequest extends PermitEvents {
  final String permitId;
  final Map acceptPermitMap;
  final String syncDate;
  final int? offlineActionId;

  const AcceptPermitRequest(
      {required this.permitId,
      required this.acceptPermitMap,
      this.syncDate = "",
      this.offlineActionId});
}

class FetchClearPermit extends PermitEvents {
  final String permitId;

  FetchClearPermit({required this.permitId});
}

class SaveClearPermit extends PermitEvents {
  final Map clearPermitMap;
  final String syncDate;
  final String permitId;
  final int? offlineActionId;

  SaveClearPermit(
      {required this.clearPermitMap,
      this.syncDate = "",
      required this.permitId,
      this.offlineActionId});
}

class SavePermitEditSafetyDocument extends PermitEvents {
  final Map editSafetyDocumentMap;
  final int? offlineActionId;

  SavePermitEditSafetyDocument(
      {required this.editSafetyDocumentMap, this.offlineActionId});
}

class FetchDataForChangePermitCP extends PermitEvents {
  final String permitId;

  FetchDataForChangePermitCP({required this.permitId});
}

class SelectTransferTo extends PermitEvents {
  final String transferType;
  final String transferValue;

  SelectTransferTo({required this.transferType, required this.transferValue});
}

class SelectTransferCPWorkForce extends PermitEvents {
  final int id;
  final String name;

  SelectTransferCPWorkForce({required this.id, required this.name});
}

class SelectTransferCPSap extends PermitEvents {
  final int id;
  final String name;

  SelectTransferCPSap({required this.id, required this.name});
}

class SelectTransferValue extends PermitEvents {
  final String value;

  SelectTransferValue({required this.value});
}

class SavePermitOfflineAction extends PermitEvents {
  final Map offlineDataMap;
  final String permitId;
  final String signature;
  final String actionKey;
  final String dateTime;

  SavePermitOfflineAction(
      {required this.offlineDataMap,
      required this.permitId,
      required this.signature,
      required this.actionKey,
      required this.dateTime});
}

class PermitInternetActions extends PermitEvents {
  PermitInternetActions();
}
