import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/data/models/permit/accept_permit_request_model.dart';
import 'package:toolkit/data/models/permit/change_permit_cp_model.dart';
import 'package:toolkit/data/models/permit/fetch_clear_permit_details_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import 'package:toolkit/data/models/permit/fetch_data_for_open_permit_model.dart';
import 'package:toolkit/data/models/permit/fetch_permit_basic_details_model.dart';
import 'package:toolkit/data/models/permit/save_clear_permit_model.dart';
import 'package:toolkit/data/models/permit/save_mark_as_prepared_model.dart';
import 'package:toolkit/data/models/permit/save_permit_safety_notice_model.dart';
import 'package:toolkit/data/models/permit/surrender_permit_model.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/encrypt_class.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/open_close_permit_model.dart';
import '../../data/models/permit/open_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_edit_safety_document_ui_plot_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import 'permit_events.dart';
import 'permit_states.dart';

class PermitBloc extends Bloc<PermitEvents, PermitStates> {
  final PermitRepository _permitRepository = getIt<PermitRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  PermitMasterDatum? selectedDatum;
  Map filters = {};
  List location = [];
  List<AllPermitDatum> permitListData = [];
  bool listReachedMax = false;
  PermitBasicData? permitBasicData;

  PermitBloc() : super(const FetchingPermitsInitial()) {
    on<GetAllPermits>(_getAllPermits);
    on<GetPermitDetails>(_getPermitDetails);
    on<GeneratePDF>(_generatePDF);
    on<GetPermitRoles>(_fetchPermitRoles);
    on<SelectPermitRoleEvent>(_selectPermitRoleEvent);
    on<FetchPermitMaster>(_fetchMasterApi);
    on<ApplyPermitFilters>(_applyFilters);
    on<ClearPermitFilters>(_clearFilters);
    on<FetchOpenPermitDetails>(_getOpenPermitDetails);
    on<FetchClosePermitDetails>(_getClosePermitDetails);
    on<OpenPermit>(_openPermit);
    on<ClosePermit>(_closePermit);
    on<RequestPermit>(_requestPermit);
    on<FetchPermitBasicDetails>(_fetchPermitBasicDetails);
    on<FetchDataForOpenPermit>(_fetchDataForOpenPermit);
    on<SaveMarkAsPrepared>(_saveMarkAsPrepared);
    on<AcceptPermitRequest>(_acceptPermitRequest);
    on<FetchClearPermit>(_fetchClearPermit);
    on<SaveClearPermit>(saveClearPermit);
    on<SavePermitEditSafetyDocument>(savePermitEditSafetyDocument);
    on<FetchDataForChangePermitCP>(_fetchDataForChangePermitCP);
    on<SelectTransferTo>(_selectTransferTo);
    on<SelectTransferCPWorkForce>(_selectTransferCPWorkForce);
    on<SelectTransferCPSap>(_selectTransferCPSap);
    on<SelectTransferValue>(_selectTransferValue);
    on<ChangePermitCP>(_changePermitCP);
    on<SurrenderPermit>(_surrenderPermit);
  }

  FutureOr<void> _fetchPermitRoles(
      GetPermitRoles event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingPermitRoles());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      PermitRolesModel permitRolesModel =
          await _permitRepository.fetchPermitRoles(hashCode, userId);
      emit(PermitRolesFetched(
          permitRolesModel: permitRolesModel, roleId: roleId));
    } catch (e) {
      emit(const CouldNotFetchPermitRoles());
    }
  }

  FutureOr<void> _selectPermitRoleEvent(
      SelectPermitRoleEvent event, Emitter<PermitStates> emit) async {
    roleId = event.roleId;
    emit(PermitRoleSelected());
  }

  FutureOr<void> _applyFilters(
      ApplyPermitFilters event, Emitter<PermitStates> emit) async {
    filters = event.permitFilters;
    location = List.from(event.location);
  }

  FutureOr<void> _clearFilters(
      ClearPermitFilters event, Emitter<PermitStates> emit) async {
    filters = {};
    location = [];
  }

  FutureOr<void> _fetchMasterApi(
      FetchPermitMaster event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingPermitMaster());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      PermitGetMasterModel permitGetMasterModel =
          await _permitRepository.fetchMaster(hashCode);
      emit(PermitMasterFetched(permitGetMasterModel, filters, location));
    } catch (e) {
      emit(const CouldNotFetchPermitMaster());
    }
  }

  FutureOr<void> _getOpenPermitDetails(
      FetchOpenPermitDetails event, Emitter<PermitStates> emit) async {
    try {
      List customFields = [];
      emit(const FetchingOpenPermitDetails());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      OpenPermitDetailsModel openPermitDetailsModel = await _permitRepository
          .openPermitDetails(hashCode, event.permitId, roleId);
      if (openPermitDetailsModel.data.panelSaint == '1') {
        customFields = [
          {"questionid": 3000009, "answer": ""},
          {"questionid": 3000001, "answer": ""},
          {"questionid": 3000002, "answer": ""},
          {"questionid": 3000003, "answer": ""},
          {"questionid": 3000004, "answer": ""},
          {"questionid": 3000005, "answer": ""},
          {"questionid": 3000006, "answer": ""},
          {"questionid": 3000007, "answer": ""},
          {"questionid": 3000008, "answer": ""},
          {"questionid": 3000013, "answer": ""},
          {"questionid": 3000014, "answer": ""}
        ];
      }
      emit(OpenPermitDetailsFetched(openPermitDetailsModel, customFields));
    } catch (e) {
      emit(const OpenPermitDetailsError());
    }
  }

  FutureOr<void> _getClosePermitDetails(
      FetchClosePermitDetails event, Emitter<PermitStates> emit) async {
    try {
      emit(const FetchingClosePermitDetails());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ClosePermitDetailsModel closePermitDetailsModel = await _permitRepository
          .closePermitDetails(hashCode, event.permitId, roleId);
      emit(ClosePermitDetailsFetched(closePermitDetailsModel));
    } catch (e) {
      emit(const ClosePermitDetailsError());
    }
  }

  FutureOr<void> _getAllPermits(
      GetAllPermits event, Emitter<PermitStates> emit) async {
    emit(const FetchingAllPermits());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      if (!listReachedMax) {
        if (roleId == '' || event.isFromHome) {
          add(const ClearPermitFilters());
          PermitRolesModel permitRolesModel =
              await _permitRepository.fetchPermitRoles(hashCode, userId);
          if (permitRolesModel.status == 200) {
            roleId = permitRolesModel.data![0].groupId!;
            AllPermitModel allPermitModel = await _permitRepository
                .getAllPermits(hashCode, '', roleId, event.page);
            permitListData.addAll(allPermitModel.data);
            listReachedMax = allPermitModel.data.isEmpty;
            emit(AllPermitsFetched(
                allPermitModel: allPermitModel,
                filters: {},
                permitListData: permitListData));
          }
        } else {
          AllPermitModel allPermitModel = await _permitRepository.getAllPermits(
              hashCode, jsonEncode(filters), roleId, event.page);
          permitListData.addAll(allPermitModel.data);
          listReachedMax = allPermitModel.data.isEmpty;
          emit(AllPermitsFetched(
              allPermitModel: allPermitModel,
              filters: filters,
              permitListData: permitListData));
        }
      }
    } catch (e) {
      emit(const CouldNotFetchPermits());
    }
  }

  FutureOr<void> _getPermitDetails(
      GetPermitDetails event, Emitter<PermitStates> emit) async {
    try {
      add(FetchPermitBasicDetails(permitId: event.permitId));
      emit(const FetchingPermitDetails());
      List permitPopUpMenu = [StringConstants.kGeneratePdf];
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      PermitDetailsModel permitDetailsModel = await _permitRepository
          .fetchPermitDetails(hashCode, event.permitId, roleId);
      if (permitDetailsModel.data.tab1.isopen == '1') {
        permitPopUpMenu.add(StringConstants.kOpenPermit);
      }
      if (permitDetailsModel.data.tab1.isclose == '1') {
        permitPopUpMenu.add(StringConstants.kClosePermit);
      }
      if (permitDetailsModel.data.tab1.status ==
          DatabaseUtil.getText('Created')) {
        permitPopUpMenu.add(StringConstants.kRequestPermit);
      }
      if (permitBasicData?.isprepared == '1') {
        permitPopUpMenu.add(StringConstants.kPreparePermit);
      }
      if (permitBasicData?.iseditsafetydocument == '1') {
        permitPopUpMenu.add(StringConstants.kEditSafetyDocument);
      }
      if (permitBasicData?.isacceptissue == '1') {
        permitPopUpMenu.add(StringConstants.kAcceptPermitRequest);
      }
      if (permitBasicData?.isclearpermit == '1') {
        permitPopUpMenu.add(StringConstants.kClearPermit);
      }
      if (permitBasicData?.istransfersafetydocument == '1') {
        permitPopUpMenu.add(StringConstants.kTransferComponentPerson);
      }
      if (permitBasicData?.issurrendercp == '1') {
        permitPopUpMenu.add(StringConstants.kSurrenderPermit);
      }
      emit(PermitDetailsFetched(
          permitDetailsModel: permitDetailsModel,
          permitPopUpMenu: permitPopUpMenu));
    } catch (e) {
      emit(const CouldNotFetchPermitDetails());
    }
  }

  FutureOr<void> _generatePDF(
      GeneratePDF event, Emitter<PermitStates> emit) async {
    try {
      emit(const GeneratingPDF());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String aipKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      final PdfGenerationModel pdfGenerationModel =
          await _permitRepository.generatePdf(hashCode, event.permitId);
      String pdfLink =
          EncryptData.decryptAESPrivateKey(pdfGenerationModel.message, aipKey);
      emit(PDFGenerated(
          pdfGenerationModel: pdfGenerationModel, pdfLink: pdfLink));
    } catch (e) {
      emit(const PDFGenerationFailed());
    }
  }

  FutureOr<void> _openPermit(
      OpenPermit event, Emitter<PermitStates> emit) async {
    try {
      emit(const OpeningPermit());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      if (event.openPermitMap['date'] == null ||
          event.openPermitMap['date'] == '') {
        emit(const OpenPermitError(StringConstants.kPleaseSelectDate));
      } else if (event.openPermitMap['time'] == null ||
          event.openPermitMap['time'] == '') {
        emit(const OpenPermitError(StringConstants.kPleaseSelectTime));
      } else {
        Map openPermitMap = {
          "hashcode": hashCode,
          "permitid": event.openPermitMap['permitId'],
          "userid": userId,
          "customfields": event.openPermitMap['customfields'],
          "date": (event.openPermitMap['date'] == null)
              ? DateFormat('dd.MM.yyyy').format(DateTime.now())
              : event.openPermitMap['date'],
          "time": event.openPermitMap['time'],
          "details": event.openPermitMap['details'] ?? '',
          "user_sign": "",
          "user_name": "",
          "user_email": ""
        };
        OpenClosePermitModel openClosePermitModel =
            await _permitRepository.openPermit(openPermitMap);
        emit(PermitOpened(openClosePermitModel));
      }
    } catch (e) {
      emit(OpenPermitError(e.toString()));
    }
  }

  FutureOr<void> _requestPermit(
      RequestPermit event, Emitter<PermitStates> emit) async {
    try {
      emit(const RequestingPermit());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      Map requestPermitMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
        "userid": userId
      };
      OpenClosePermitModel openClosePermitModel =
          await _permitRepository.requestPermit(requestPermitMap);
      emit(PermitRequested(openClosePermitModel));
    } catch (e) {
      emit(RequestPermitError(e.toString()));
    }
  }

  FutureOr<void> _closePermit(
      ClosePermit event, Emitter<PermitStates> emit) async {
    try {
      emit(const ClosingPermit());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      if (event.closePermitMap['panel_saint'] == '1' &&
          event.closePermitMap['controlPerson'] == null) {
        emit(const ClosePermitError(StringConstants.kAllFieldsMandatory));
      } else if (event.closePermitMap['time'] == null) {
        emit(const ClosePermitError(
            StringConstants.kPleaseEnterTimeToClosePermit));
      } else {
        Map closePermitMap = {
          "hashcode": hashCode,
          "permitid": event.closePermitMap['permitId'],
          "userid": userId,
          "controlpersons": event.closePermitMap['controlPerson'],
          "date": (event.closePermitMap['date'] == null)
              ? DateFormat('dd.MM.yyyy').format(DateTime.now())
              : event.closePermitMap['date'],
          "time": event.closePermitMap['time'],
          "details": event.closePermitMap['details'] ?? '',
          "user_sign": "",
          "user_name": "",
          "user_email": ""
        };
        OpenClosePermitModel openClosePermitModel =
            await _permitRepository.closePermit(closePermitMap);
        if (openClosePermitModel.message == '1') {
          emit(PermitClosed(openClosePermitModel));
        } else {
          emit(ClosePermitError(
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(ClosePermitError(e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchPermitBasicDetails(
      FetchPermitBasicDetails event, Emitter<PermitStates> emit) async {
    emit(PermitBasicDetailsFetching());
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      FetchPermitBasicDetailsModel fetchPermitBasicDetailsModel =
          await _permitRepository.fetchPermitBasicDetails(
              event.permitId, hashCode, roleId);
      if (fetchPermitBasicDetailsModel.status == 200) {
        emit(PermitBasicDetailsFetched(
            fetchPermitBasicDetailsModel: fetchPermitBasicDetailsModel));
        permitBasicData = fetchPermitBasicDetailsModel.data;
      } else {
        emit(PermitBasicDetailsNotFetched(
            errorMessage: fetchPermitBasicDetailsModel.message!));
      }
    } catch (e) {
      emit(PermitBasicDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchDataForOpenPermit(
      FetchDataForOpenPermit event, Emitter<PermitStates> emit) async {
    try {
      emit(DataForOpenPermitFetching());
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      FetchDataForOpenPermitModel fetchDataForOpenPermitModel =
          await _permitRepository.fetchDataForOpenPermit(
              event.permitId, hashCode, roleId);
      if (fetchDataForOpenPermitModel.status == 200) {
        final List<Question> questions = [
          Question(questionNo: StringConstants.kPermitFirstQuestion),
          Question(questionNo: StringConstants.kPanel12),
          Question(questionNo: StringConstants.kPanel15),
          Question(questionNo: StringConstants.kPanel16)
        ];
        emit(DataForOpenPermitFetched(
            fetchDataForOpenPermitModel: fetchDataForOpenPermitModel,
            questions: questions));
      } else {
        emit(DataForOpenPermitNotFetched(
            errorMessage: fetchDataForOpenPermitModel.message!));
      }
    } catch (e) {
      emit(DataForOpenPermitNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveMarkAsPrepared(
      SaveMarkAsPrepared event, Emitter<PermitStates> emit) async {
    emit(MarkAsPreparedSaving());
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      String userId = (await _customerCache.getUserId(CacheKeys.userId)) ?? '';
      Map saveMarkAsPreparedMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
        "userid": userId,
        "controlpersons": event.controlPerson,
        "user_sign": "",
        "user_name": "",
        "user_email": ""
      };
      if (event.controlPerson != '') {
        SaveMarkAsPreparedModel saveMarkAsPreparedModel =
            await _permitRepository.saveMarkAsPrepared(saveMarkAsPreparedMap);
        if (saveMarkAsPreparedModel.message == '1') {
          emit(MarkAsPreparedSaved());
        } else {
          emit(MarkAsPreparedNotSaved(
              errorMessage: saveMarkAsPreparedModel.message!));
        }
      } else {
        emit(const MarkAsPreparedNotSaved(
            errorMessage: StringConstants.kPleaseFillControlPerson));
      }
    } catch (e) {
      emit(MarkAsPreparedNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _acceptPermitRequest(
      AcceptPermitRequest event, Emitter<PermitStates> emit) async {
    emit(PermitRequestAccepting());
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      String userId = (await _customerCache.getUserId(CacheKeys.userId)) ?? '';
      Map acceptPermitRequestMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
        "userid": userId,
        "npw_name": "",
        "npw_auth": "",
        "npw_company": "",
        "npw_email": "",
        "npw_phone": ""
      };
      AcceptPermitRequestModel acceptPermitRequestModel =
          await _permitRepository.acceptPermitRequest(acceptPermitRequestMap);
      if (acceptPermitRequestModel.message == '1') {
        emit(PermitRequestAccepted());
      } else {
        emit(PermitRequestNotAccepted(
            errorMessage: acceptPermitRequestModel.message!));
      }
    } catch (e) {
      emit(PermitRequestNotAccepted(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchClearPermit(
      FetchClearPermit event, Emitter<PermitStates> emit) async {
    try {
      emit(FetchingClearPermitDetails());
      FetchClearPermitDetailsModel fetchClearPermitDetailsModel =
          await _permitRepository.fetchClearPermitDetails({
        'permit_id': event.permitId,
        'hashcode': await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
        'role': roleId
      });
      final List<Map<String, dynamic>> customFields = [
        {"questionid": 4000010, "answer": ""},
        {
          "questionid": 4000001,
          "answer": fetchClearPermitDetailsModel.data.keysafeno
        },
        {
          "questionid": 4000002,
          "answer": fetchClearPermitDetailsModel.data.earthscheduleno
        },
        {
          "questionid": 4000003,
          "answer": fetchClearPermitDetailsModel.data.selectedpersonreport
        },
        {
          "questionid": 4000004,
          "answer": fetchClearPermitDetailsModel.data.safetykeys
        },
        {
          "questionid": 4000005,
          "answer": fetchClearPermitDetailsModel.data.circuitflags
        },
        {
          "questionid": 4000006,
          "answer": fetchClearPermitDetailsModel.data.circuitwristlets
        },
        {
          "questionid": 4000007,
          "answer": fetchClearPermitDetailsModel.data.singleline
        },
        {
          "questionid": 4000008,
          "answer": fetchClearPermitDetailsModel.data.pid
        },
        {
          "questionid": 4000013,
          "answer": fetchClearPermitDetailsModel.data.accessKeys
        },
        {
          "questionid": 4000014,
          "answer": fetchClearPermitDetailsModel.data.other
        }
      ];
      if (fetchClearPermitDetailsModel.data.toJson().isNotEmpty) {
        emit(ClearPermitDetailsFetched(
            fetchClearPermitDetailsModel: fetchClearPermitDetailsModel,
            customFields: customFields));
      } else {
        emit(ClearPermitDetailsCouldNotFetched(
            errorMessage: StringConstants.kNoDataFound));
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> saveClearPermit(
      SaveClearPermit event, Emitter<PermitStates> emit) async {
    try {
      emit(SavingClearPermit());
      Map clearPermitMap = {
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "permitid": event.clearPermitMap['permit_id'],
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "customfields": event.clearPermitMap['customfields'],
        "npwid": "",
        "npw_name": "",
        "npw_auth": "",
        "npw_company": "",
        "npw_email": "",
        "npw_phone": ""
      };
      SaveClearPermitModel saveClearPermitModel =
          await _permitRepository.saveClearPermit(clearPermitMap);
      if (saveClearPermitModel.message == '1') {
        emit(ClearPermitSaved());
      } else {
        emit(ClearPermitNotSaved(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      emit(ClearPermitNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> savePermitEditSafetyDocument(
      SavePermitEditSafetyDocument event, Emitter<PermitStates> emit) async {
    try {
      emit(SavingPermitEditSafetyDocument());
      Map editSafetyDocumentMap = {
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "permitid": event.editSafetyDocumentMap['permit_id'],
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "location": event.editSafetyDocumentMap['location'] ?? '',
        "description": event.editSafetyDocumentMap['permit_id'] ?? '',
        "methodstmt": event.editSafetyDocumentMap['methodstmt'] ?? '',
        "lwc_environment": event.editSafetyDocumentMap['lwc_environment'] ?? '',
        "lwc_precautions": event.editSafetyDocumentMap['lwc_precautions'] ?? '',
        "lwc_accessto": event.editSafetyDocumentMap['lwc_accessto'] ?? '',
        "st_circuit": event.editSafetyDocumentMap['st_circuit'] ?? '',
        "st_precautions": event.editSafetyDocumentMap['st_precautions'] ?? '',
        "st_safety": event.editSafetyDocumentMap['st_safety'] ?? '',
        "ptw_isolation": event.editSafetyDocumentMap['ptw_isolation'] ?? '',
        "ptw_circuit": event.editSafetyDocumentMap['ptw_circuit'] ?? '',
        "ptw_circuit2": event.editSafetyDocumentMap['ptw_circuit2'] ?? '',
        "ptw_precautions": event.editSafetyDocumentMap['ptw_precautions'] ?? '',
        "ptw_precautions2":
            event.editSafetyDocumentMap['ptw_precautions2'] ?? '',
        "ptw_safety": event.editSafetyDocumentMap['ptw_safety'] ?? ''
      };
      SavePermitEditSafetyDocumentModel savePermitEditSafetyDocumentModel =
          await _permitRepository
              .saveEditSafetyNoticeDocument(editSafetyDocumentMap);
      if (savePermitEditSafetyDocumentModel.message == '1') {
        emit(PermitEditSafetyDocumentSaved());
      } else {
        emit(PermitEditSafetyDocumentNotSaved(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      emit(PermitEditSafetyDocumentNotSaved(
          errorMessage: StringConstants.kSomethingWentWrong));
    }
  }

  Future<FutureOr<void>> _fetchDataForChangePermitCP(
      FetchDataForChangePermitCP event, Emitter<PermitStates> emit) async {
    try {
      emit(DataForChangePermitCPFetching());
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchDataForChangePermitCpModel fetchDataForChangePermitCpModel =
          await _permitRepository.fetchDataForChangePermitCP(
              event.permitId, hashCode);
      if (fetchDataForChangePermitCpModel.status == 200) {
        emit(DataForChangePermitCPFetched(
            fetchDataForChangePermitCpModel: fetchDataForChangePermitCpModel));
      } else {
        emit(DataForChangePermitCPNotFetched(
            errorMessage: fetchDataForChangePermitCpModel.message!));
      }
    } catch (e) {
      emit(DataForChangePermitCPNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTransferTo(
      SelectTransferTo event, Emitter<PermitStates> emit) {
    emit(TransferToSelected(
        transferType: event.transferType, transferValue: event.transferValue));
  }

  FutureOr<void> _selectTransferCPWorkForce(
      SelectTransferCPWorkForce event, Emitter<PermitStates> emit) {
    emit(TransferCPWorkforceSelected(id: event.id, name: event.name));
  }

  FutureOr<void> _selectTransferCPSap(
      SelectTransferCPSap event, Emitter<PermitStates> emit) {
    emit(TransferCPSapSelected(id: event.id, name: event.name));
  }

  FutureOr<void> _selectTransferValue(
      SelectTransferValue event, Emitter<PermitStates> emit) {
    emit(TransferValueSelected(value: event.value));
  }

  Future<FutureOr<void>> _changePermitCP(
      ChangePermitCP event, Emitter<PermitStates> emit) async {
    emit(PermitCPChanging());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      Map changePermitCPMap = {
        "hashcode": hashCode,
        "permitid": event.changePermitCPMap['permitId'],
        "userid": userId,
        "npw": event.changePermitCPMap['npw'],
        "sap": event.changePermitCPMap['sap'],
        "role": roleId,
        "controlroom": event.changePermitCPMap['controlePerson']
      };
      if ((event.changePermitCPMap['sap'] != '' &&
          event.changePermitCPMap['controlePerson'] != null)) {
        ChangePermitCpModel changePermitCpModel =
            await _permitRepository.changePermitCP(changePermitCPMap);
        if (changePermitCpModel.message == '1') {
          emit(PermitCPChanged());
        } else {
          emit(PermitCPNotChanged(errorMessage: changePermitCpModel.message!));
        }
      } else {
        emit(PermitCPNotChanged(
            errorMessage: "SAP and control person can't be empty"));
      }
    } catch (e) {
      emit(PermitCPNotChanged(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _surrenderPermit(
      SurrenderPermit event, Emitter<PermitStates> emit) async {
    emit(SurrenderingPermit());
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      Map surrenderPermitMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
      };
      SurrenderPermitModel surrenderPermitModel =
          await _permitRepository.surrenderPermit(surrenderPermitMap);
      if (surrenderPermitModel.message == '1') {
        emit(PermitSurrendered());
      } else {
        emit(PermitNotSurrender(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      emit(PermitNotSurrender(errorMessage: e.toString()));
    }
  }
}
