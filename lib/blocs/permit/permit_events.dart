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

  const ClosePermit({required this.closePermitMap, required this.permitId});
}

class OpenPermit extends PermitEvents {
  final Map openPermitMap;
  final String permitId;

  const OpenPermit(this.openPermitMap, this.permitId);
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

  const SaveMarkAsPrepared(
      {required this.permitId, required this.markAsPreparedMap});
}

class AcceptPermitRequest extends PermitEvents {
  final String permitId;
  final Map acceptPermitMap;
  final String syncDate;

  const AcceptPermitRequest(
      {required this.permitId,
      required this.acceptPermitMap,
      this.syncDate = ""});
}

class FetchClearPermit extends PermitEvents {
  final String permitId;

  FetchClearPermit({required this.permitId});
}

class SaveClearPermit extends PermitEvents {
  final Map clearPermitMap;
  final String syncDate;
  final String permitId;

  SaveClearPermit(
      {required this.clearPermitMap,
      this.syncDate = "",
      required this.permitId});
}

class SavePermitEditSafetyDocument extends PermitEvents {
  final Map editSafetyDocumentMap;
  final String permitId;

  SavePermitEditSafetyDocument(
      {required this.editSafetyDocumentMap, required this.permitId});
}

class SurrenderPermit extends PermitEvents {
  final String permitId;
  final Map surrenderPermitMap;

  SurrenderPermit({required this.permitId, required this.surrenderPermitMap});
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

class ChangePermitCP extends PermitEvents {
  final Map changePermitCPMap;
  final String permitId;

  ChangePermitCP({required this.changePermitCPMap, required this.permitId});
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

class GenerateOfflinePdf extends PermitEvents {
  final String permitId;

  GenerateOfflinePdf({required this.permitId});
}

class FetchSwitchingScheduleInstructions extends PermitEvents {
  final String scheduleId;

  FetchSwitchingScheduleInstructions({required this.scheduleId});
}

class UpdatePermitSwitchingSchedule extends PermitEvents {
  final Map editSwitchingScheduleMap;
  final bool isFromMultiSelect;

  UpdatePermitSwitchingSchedule(
      {required this.editSwitchingScheduleMap,
      required this.isFromMultiSelect});
}

class AddPermitSwitchingSchedule extends PermitEvents {
  final Map addSwitchingScheduleMap;

  AddPermitSwitchingSchedule({required this.addSwitchingScheduleMap});
}

class MoveDownPermitSwitchingSchedule extends PermitEvents {
  final String instructionId;

  MoveDownPermitSwitchingSchedule({required this.instructionId});
}

class MoveUpPermitSwitchingSchedule extends PermitEvents {
  final String instructionId;

  MoveUpPermitSwitchingSchedule({required this.instructionId});
}

class GenerateSwitchingSchedulePdf extends PermitEvents {
  final String switchingScheduleId;

  GenerateSwitchingSchedulePdf({required this.switchingScheduleId});
}

class MarkSwitchingScheduleComplete extends PermitEvents {
  final String switchingScheduleId;

  MarkSwitchingScheduleComplete({required this.switchingScheduleId});
}

class DeletePermitSwitchingSchedule extends PermitEvents {
  final String instructionId;

  DeletePermitSwitchingSchedule({required this.instructionId});
}

class FetchSwitchingScheduleDetails extends PermitEvents {
  final String instructionId;

  FetchSwitchingScheduleDetails({required this.instructionId});
}

class GenerateTextFile extends PermitEvents {

  GenerateTextFile();
}

class PickFileFromStorage extends PermitEvents {
  PickFileFromStorage();
}

class PickFileFromStorageInitialEvent extends PermitEvents {
  PickFileFromStorageInitialEvent();
}
class SaveFileData extends PermitEvents {
  SaveFileData();
}
