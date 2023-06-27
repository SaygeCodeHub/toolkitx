import 'package:toolkit/data/models/permit/open_close_permit_model.dart';
import 'package:toolkit/data/models/permit/open_permit_details_model.dart';

import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
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
  final Map filters;

  const AllPermitsFetched(
      {required this.filters, required this.allPermitModel});
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
  final PdfGenerationModel pdfGenerationModel;
  final String pdfLink;

  const PDFGenerated({required this.pdfGenerationModel, required this.pdfLink});
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
