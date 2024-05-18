import 'package:toolkit/data/models/permit/fetch_clear_permit_details_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/data/models/permit/fetch_permit_basic_details_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import '../../data/models/permit/open_close_permit_model.dart';
import '../../data/models/permit/open_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_edit_safety_document_ui_plot_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/permit_roles_model.dart';

abstract class PermitStates {
  const PermitStates();
}

class FetchingPermitsInitial extends PermitStates {
  const FetchingPermitsInitial();
}

class FetchingAllPermits extends PermitStates {
  const FetchingAllPermits();
}

class AllPermitsFetched extends PermitStates {
  final AllPermitModel allPermitModel;
  final List<AllPermitDatum> permitListData;
  final Map filters;

  const AllPermitsFetched(
      {required this.filters,
      required this.allPermitModel,
      required this.permitListData});
}

class CouldNotFetchPermits extends PermitStates {
  const CouldNotFetchPermits();
}

class FetchingPermitDetails extends PermitStates {
  const FetchingPermitDetails();
}

class PermitDetailsFetched extends PermitStates {
  final PermitDetailsModel permitDetailsModel;
  final List permitPopUpMenu;

  const PermitDetailsFetched(
      {required this.permitDetailsModel, required this.permitPopUpMenu});
}

class CouldNotFetchPermitDetails extends PermitStates {
  const CouldNotFetchPermitDetails();
}

class GeneratingPDF extends PermitStates {
  const GeneratingPDF();
}

class PDFGenerated extends PermitStates {
  final PdfGenerationModel? pdfGenerationModel;
  final String pdfLink;

  const PDFGenerated({this.pdfGenerationModel, required this.pdfLink});
}

class PDFGenerationFailed extends PermitStates {
  const PDFGenerationFailed();
}

class FetchingPermitRoles extends PermitStates {
  const FetchingPermitRoles();
}

class PermitRolesFetched extends PermitStates {
  final PermitRolesModel permitRolesModel;
  final String? roleId;

  const PermitRolesFetched(
      {required this.roleId, required this.permitRolesModel});
}

class CouldNotFetchPermitRoles extends PermitStates {
  const CouldNotFetchPermitRoles();
}

class PermitRoleSelected extends PermitStates {
  PermitRoleSelected();
}

class FetchingPermitMaster extends PermitStates {
  const FetchingPermitMaster();
}

class PermitMasterFetched extends PermitStates {
  final PermitGetMasterModel permitGetMasterModel;
  final Map permitFilterMap;
  final List location;

  const PermitMasterFetched(
      this.permitGetMasterModel, this.permitFilterMap, this.location);
}

class CouldNotFetchPermitMaster extends PermitStates {
  const CouldNotFetchPermitMaster();
}

class ClosingPermit extends PermitStates {
  const ClosingPermit();
}

class PermitClosed extends PermitStates {
  final OpenClosePermitModel openClosePermitModel;

  const PermitClosed(this.openClosePermitModel);
}

class ClosePermitError extends PermitStates {
  final String errorMessage;

  const ClosePermitError(this.errorMessage);
}

class OpeningPermit extends PermitStates {
  const OpeningPermit();
}

class PermitOpened extends PermitStates {
  final OpenClosePermitModel openClosePermitModel;

  const PermitOpened(this.openClosePermitModel);
}

class OpenPermitError extends PermitStates {
  final String errorMessage;

  const OpenPermitError(this.errorMessage);
}

class RequestingPermit extends PermitStates {
  const RequestingPermit();
}

class PermitRequested extends PermitStates {
  final OpenClosePermitModel openClosePermitModel;

  const PermitRequested(this.openClosePermitModel);
}

class RequestPermitError extends PermitStates {
  final String errorMessage;

  const RequestPermitError(this.errorMessage);
}

class FetchingOpenPermitDetails extends PermitStates {
  const FetchingOpenPermitDetails();
}

class OpenPermitDetailsFetched extends PermitStates {
  final OpenPermitDetailsModel openPermitDetailsModel;
  final List customFields;

  const OpenPermitDetailsFetched(
      this.openPermitDetailsModel, this.customFields);
}

class OpenPermitDetailsError extends PermitStates {
  const OpenPermitDetailsError();
}

class FetchingClosePermitDetails extends PermitStates {
  const FetchingClosePermitDetails();
}

class ClosePermitDetailsFetched extends PermitStates {
  final ClosePermitDetailsModel closePermitDetailsModel;

  const ClosePermitDetailsFetched(this.closePermitDetailsModel);
}

class ClosePermitDetailsError extends PermitStates {
  const ClosePermitDetailsError();
}

class PreparingPermitLocalDatabase extends PermitStates {
  const PreparingPermitLocalDatabase();
}

class PermitLocalDatabasePrepared extends PermitStates {
  const PermitLocalDatabasePrepared();
}

class PreparingPermitLocalDatabaseFailed extends PermitStates {
  const PreparingPermitLocalDatabaseFailed();
}

class PermitBasicDetailsFetching extends PermitStates {}

class PermitBasicDetailsFetched extends PermitStates {
  final FetchPermitBasicDetailsModel fetchPermitBasicDetailsModel;

  const PermitBasicDetailsFetched({required this.fetchPermitBasicDetailsModel});
}

class PermitBasicDetailsNotFetched extends PermitStates {
  final String errorMessage;

  const PermitBasicDetailsNotFetched({required this.errorMessage});
}

class DataForOpenPermitFetching extends PermitStates {}

class DataForOpenPermitFetched extends PermitStates {
  final FetchDataForOpenPermitModel fetchDataForOpenPermitModel;
  final List<Question> questions;

  const DataForOpenPermitFetched(
      {required this.questions, required this.fetchDataForOpenPermitModel});
}

class DataForOpenPermitNotFetched extends PermitStates {
  final String errorMessage;

  const DataForOpenPermitNotFetched({required this.errorMessage});
}

class MarkAsPreparedSaving extends PermitStates {}

class MarkAsPreparedSaved extends PermitStates {}

class MarkAsPreparedNotSaved extends PermitStates {
  final String errorMessage;

  const MarkAsPreparedNotSaved({required this.errorMessage});
}

class PermitRequestAccepting extends PermitStates {}

class PermitRequestAccepted extends PermitStates {}

class PermitRequestNotAccepted extends PermitStates {
  final String errorMessage;

  const PermitRequestNotAccepted({required this.errorMessage});
}

class FetchingClearPermitDetails extends PermitStates {}

class ClearPermitDetailsFetched extends PermitStates {
  final FetchClearPermitDetailsModel fetchClearPermitDetailsModel;
  final List<Map<String, dynamic>> customFields;

  ClearPermitDetailsFetched(
      {required this.fetchClearPermitDetailsModel, required this.customFields});
}

class ClearPermitDetailsCouldNotFetched extends PermitStates {
  final String errorMessage;

  ClearPermitDetailsCouldNotFetched({required this.errorMessage});
}

class SavingClearPermit extends PermitStates {}

class ClearPermitSaved extends PermitStates {}

class ClearPermitNotSaved extends PermitStates {
  final String errorMessage;

  ClearPermitNotSaved({required this.errorMessage});
}

class SavingPermitEditSafetyDocument extends PermitStates {}

class PermitEditSafetyDocumentSaved extends PermitStates {
  final String successMessage;

  PermitEditSafetyDocumentSaved({this.successMessage = ''});
}

class PermitEditSafetyDocumentNotSaved extends PermitStates {
  final String errorMessage;

  PermitEditSafetyDocumentNotSaved({required this.errorMessage});
}

class DataForChangePermitCPFetching extends PermitStates {}

class DataForChangePermitCPFetched extends PermitStates {
  final FetchDataForChangePermitCpModel fetchDataForChangePermitCpModel;

  DataForChangePermitCPFetched({required this.fetchDataForChangePermitCpModel});
}

class DataForChangePermitCPNotFetched extends PermitStates {
  final String errorMessage;

  DataForChangePermitCPNotFetched({required this.errorMessage});
}

class TransferToSelected extends PermitStates {
  final String transferType;
  final String transferValue;

  TransferToSelected({required this.transferType, required this.transferValue});
}

class TransferCPWorkforceSelected extends PermitStates {
  final int id;
  final String name;

  TransferCPWorkforceSelected({required this.id, required this.name});
}

class TransferCPSapSelected extends PermitStates {
  final int id;
  final String name;

  TransferCPSapSelected({required this.id, required this.name});
}

class TransferValueSelected extends PermitStates {
  final String value;

  TransferValueSelected({required this.value});
}
