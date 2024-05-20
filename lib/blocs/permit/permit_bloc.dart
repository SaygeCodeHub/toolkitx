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
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/data/models/permit/surrender_permit_model.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/encrypt_class.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/offline_permit_model.dart';
import '../../data/models/permit/open_close_permit_model.dart';
import '../../data/models/permit/open_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_edit_safety_document_ui_plot_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database/database_util.dart';
import '../../utils/database_utils.dart';
import 'permit_events.dart';
import 'permit_states.dart';

class PermitBloc extends Bloc<PermitEvents, PermitStates> {
  final PermitRepository _permitRepository = getIt<PermitRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  String roleId = '';
  PermitMasterDatum? selectedDatum;
  Map filters = {};
  List location = [];
  List<AllPermitDatum> permitListData = [];
  bool listReachedMax = false;
  PermitBasicData? permitBasicData;
  int statusId = 0;
  Map transferAndSurrenderMap = {};

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
    on<PreparePermitLocalDatabase>(_preparePermitLocalDatabase);
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
    on<SavePermitOfflineAction>(_saveOfflineData);
    on<PermitInternetActions>(_permitInternetActions);
  }

  FutureOr<void> _preparePermitLocalDatabase(
      PreparePermitLocalDatabase event, Emitter<PermitStates> emit) async {
    try {
      emit(const PreparingPermitLocalDatabase());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      OfflinePermitModel offlinePermitModel =
          await _permitRepository.fetchOfflinePermit(hashCode);
      if (offlinePermitModel.status == 200) {
        for (var datum in offlinePermitModel.data) {
          await _databaseHelper.insertOfflinePermit(datum);
        }
        emit(const PermitLocalDatabasePrepared());
      } else {
        emit(const PreparingPermitLocalDatabaseFailed());
      }
    } catch (e) {
      emit(const PreparingPermitLocalDatabaseFailed());
    }
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
      if (isNetworkEstablished) {
        emit(const FetchingOpenPermitDetails());
        String hashCode =
            (await _customerCache.getHashCode(CacheKeys.hashcode))!;
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
      } else {
        Map<String, dynamic> permitHtmlMap =
            await _databaseHelper.fetchPermitDetailsHtml(event.permitId);
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
        OpenPermitDetailsModel openPermitDetailsModel = OpenPermitDetailsModel(
            status: 200,
            message: '',
            data: GetOpenPermitData.fromJson(permitHtmlMap));
        int typeOfPermit =
            await _databaseHelper.getTypeOfPermit(event.permitId);
        openPermitDetailsModel.data.permitStatus =
            getStatusText(typeOfPermit.toString(), statusId.toString());
        if (permitHtmlMap.isNotEmpty) {
          emit(OpenPermitDetailsFetched(openPermitDetailsModel, customFields));
        } else {
          emit(const OpenPermitDetailsError());
        }
      }
    } catch (e) {
      emit(const OpenPermitDetailsError());
    }
  }

  FutureOr<void> _getClosePermitDetails(
      FetchClosePermitDetails event, Emitter<PermitStates> emit) async {
    try {
      if (isNetworkEstablished) {
        emit(const FetchingClosePermitDetails());
        String hashCode =
            (await _customerCache.getHashCode(CacheKeys.hashcode))!;
        ClosePermitDetailsModel closePermitDetailsModel =
            await _permitRepository.closePermitDetails(
                hashCode, event.permitId, roleId);
        if (closePermitDetailsModel.status == 200) {
          emit(ClosePermitDetailsFetched(closePermitDetailsModel));
        } else {
          emit(const ClosePermitDetailsError());
        }
      } else {
        Map<String, dynamic> permitHtmlMap =
            await _databaseHelper.fetchPermitDetailsHtml(event.permitId);
        ClosePermitDetailsModel closePermitDetailsModel =
            ClosePermitDetailsModel(
                status: 200,
                message: '',
                data: GetClosePermitData.fromJson(permitHtmlMap));
        int typeOfPermit =
            await _databaseHelper.getTypeOfPermit(event.permitId);
        closePermitDetailsModel.data.permitStatus =
            getStatusText(typeOfPermit.toString(), statusId.toString());
        if (permitHtmlMap.isNotEmpty) {
          emit(ClosePermitDetailsFetched(closePermitDetailsModel));
        } else {
          emit(const ClosePermitDetailsError());
        }
      }
    } catch (e) {
      emit(const ClosePermitDetailsError());
    }
  }

  FutureOr<void> _getAllPermits(
      GetAllPermits event, Emitter<PermitStates> emit) async {
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;

      if (!listReachedMax) {
        if (isNetworkEstablished) {
          emit(const FetchingAllPermits());
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
            AllPermitModel allPermitModel =
                await _permitRepository.getAllPermits(
                    hashCode, jsonEncode(filters), roleId, event.page);
            permitListData.addAll(allPermitModel.data);
            listReachedMax = allPermitModel.data.isEmpty;
            emit(AllPermitsFetched(
                allPermitModel: allPermitModel,
                filters: filters,
                permitListData: permitListData));
          }
        } else {
          List<Map<String, dynamic>> fetchListPageData =
              await _databaseHelper.fetchPermitListOffline();
          AllPermitModel allPermitModel = AllPermitModel.fromJson(
              {'Status': 200, 'Message': '', 'Data': fetchListPageData});
          permitListData.addAll(allPermitModel.data);
          listReachedMax = allPermitModel.data.isEmpty;
          emit(AllPermitsFetched(
              allPermitModel: allPermitModel,
              filters: {},
              permitListData: permitListData));
        }
      }
    } catch (e) {
      emit(const CouldNotFetchPermits());
    }
  }

  FutureOr<void> _getPermitDetails(
      GetPermitDetails event, Emitter<PermitStates> emit) async {
    List permitPopUpMenu = [StringConstants.kGeneratePdf];
    try {
      if (isNetworkEstablished) {
        add(FetchPermitBasicDetails(permitId: event.permitId));
        emit(const FetchingPermitDetails());
        String hashCode =
            (await _customerCache.getHashCode(CacheKeys.hashcode))!;
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
      } else {
        emit(const FetchingPermitDetails());
        Map<String, dynamic> permitDetailsMap =
            await _databaseHelper.fetchPermitDetailsOffline(event.permitId);
        statusId = await _databaseHelper.fetchPermitStatusId(event.permitId);
        PermitDetailsData permitDerailsData =
            PermitDetailsData.fromJson(permitDetailsMap);
        permitDerailsData.tab1.status = getStatusText(
            permitDerailsData.tab1.permitType.toString(), statusId.toString());
        PermitDetailsModel permitDetailsModel = PermitDetailsModel(
            status: 200,
            message: '',
            data: PermitDetailsData.fromJson(permitDerailsData.toJson()));
        permitPopUpMenu.add(StringConstants.kTransferComponentPerson);
        permitPopUpMenu.add(StringConstants.kSurrenderPermit);
        if (statusId == 16 || statusId == 7) {
          permitPopUpMenu.add(StringConstants.kOpenPermit);
        }
        if (statusId == 18) {
          permitPopUpMenu.add(StringConstants.kClosePermit);
        }
        if (statusId == 10) {
          permitPopUpMenu.add(StringConstants.kPreparePermit);
        }
        if (statusId == 10 || statusId == 5) {
          permitPopUpMenu.add(StringConstants.kEditSafetyDocument);
        }
        if (statusId == 2) {
          permitPopUpMenu.add(StringConstants.kAcceptPermitRequest);
        }
        if (statusId == 17) {
          permitPopUpMenu.add(StringConstants.kClearPermit);
        }
        if (permitDetailsModel.toJson().isNotEmpty) {
          emit(PermitDetailsFetched(
              permitDetailsModel: permitDetailsModel,
              permitPopUpMenu: permitPopUpMenu));
        } else {
          emit(const CouldNotFetchPermitDetails());
        }
      }
    } catch (e) {
      emit(const CouldNotFetchPermitDetails());
    }
  }

  String getStatusText(String ptype, String pstatus) {
    Map<String, String> statusArray = {
      '0_0': 'Created',
      '0_1': 'Requested',
      '0_2': 'Opened',
      '0_3': 'Closed',
      '0_4': 'Cancelled',
      '0_5': 'Approved',
      '0_6': 'Deleted',
      '0_7': 'Hold',
      '0_8': 'Unlock Applied',
      '0_9': 'Withdraw Permit',
      '0_10': 'Approved',
      '0_16': 'Prepared',
      '0_17': 'Issued (Accepted)',
      '0_18': 'Cleared',
      '19_17': 'Accepted',
      '19_18': 'Request Closure',
      '18_17': 'Accepted',
      '18_18': 'Request Closure',
      '12_5': 'Pre-prepared',
      '12_2': 'Issued (not receipted)',
      '15_5': 'Pre-prepared',
      '12_3': 'Cancelled',
      '15_2': 'Issued (not receipted)',
      '15_3': 'Cancelled',
      '16_5': 'Pre-prepared',
      '16_2': 'Issued (not receipted)',
      '16_3': 'Cancelled'
    };

    String key = '${ptype}_$pstatus';
    String? status = statusArray[key];

    if (status == null) {
      key = '0_$pstatus';
      status = statusArray[key];
    }

    return status ?? '';
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
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      if (event.openPermitMap['time'] == null ||
          event.openPermitMap['time'] == '') {
        emit(const OpenPermitError(StringConstants.kPleaseSelectTime));
      } else {
        Map openPermitMap = {
          "hashcode": hashCode,
          "permitid": event.permitId,
          "userid": userId,
          "customfields": event.openPermitMap['customfields'],
          "date": (event.openPermitMap['date'] == null)
              ? DateFormat('dd.MM.yyyy').format(DateTime.now())
              : event.openPermitMap['date'],
          "time": event.openPermitMap['time'],
          "details": event.openPermitMap['details'] ?? '',
          "user_sign": event.openPermitMap['user_sign'] ?? '',
          "user_name": event.openPermitMap['user_name'] ?? '',
          "user_email": event.openPermitMap['user_email'] ?? ''
        };
        if (isNetworkEstablished) {
          emit(const OpeningPermit());
          OpenClosePermitModel openClosePermitModel =
              await _permitRepository.openPermit(openPermitMap);
          if (openClosePermitModel.message == '1') {
            if (event.offlineActionId != null) {
              await _databaseHelper
                  .deleteOfflinePermitAction(event.offlineActionId!);
            }
            emit(PermitOpened(openClosePermitModel));
          }
        } else {
          add(SavePermitOfflineAction(
              offlineDataMap: openPermitMap,
              permitId: event.openPermitMap['permitId'],
              signature: event.openPermitMap['user_sign'],
              actionKey: 'open_permit',
              dateTime:
                  '${event.openPermitMap['user_date']}${event.openPermitMap['user_time']}'));
        }
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
          "permitid": event.permitId,
          "userid": userId,
          "controlpersons": event.closePermitMap['controlPerson'],
          "date": (event.closePermitMap['date'] == null)
              ? DateFormat('dd.MM.yyyy').format(DateTime.now())
              : event.closePermitMap['date'],
          "time": event.closePermitMap['time'],
          "details": event.closePermitMap['details'] ?? '',
          "user_sign": event.closePermitMap['user_sign'] ?? '',
          "user_name": event.closePermitMap['user_name'] ?? '',
          "user_email": event.closePermitMap['user_email'] ?? ''
        };
        if (isNetworkEstablished) {
          emit(const ClosingPermit());
          OpenClosePermitModel openClosePermitModel =
              await _permitRepository.closePermit(closePermitMap);
          if (openClosePermitModel.message == '1') {
            if (event.offlineActionId != null) {
              await _databaseHelper
                  .deleteOfflinePermitAction(event.offlineActionId!);
            }
            emit(PermitClosed(openClosePermitModel));
          } else {
            emit(ClosePermitError(
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
          }
        } else {
          add(SavePermitOfflineAction(
              offlineDataMap: closePermitMap,
              permitId: event.closePermitMap['permitId'],
              signature: event.closePermitMap['user_sign'] ?? '',
              actionKey: 'cancel_permit',
              dateTime:
                  '${event.closePermitMap['user_date']}${event.closePermitMap['user_time']}'));
        }
      }
    } catch (e) {
      emit(ClosePermitError(e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchPermitBasicDetails(
      FetchPermitBasicDetails event, Emitter<PermitStates> emit) async {
    try {
      if (isNetworkEstablished) {
        emit(PermitBasicDetailsFetching());
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
      } else {
        Map<String, dynamic> permitHtmlMap =
            await _databaseHelper.fetchPermitDetailsHtml(event.permitId);
        FetchPermitBasicDetailsModel fetchPermitBasicDetailsModel =
            FetchPermitBasicDetailsModel(
                status: 200,
                message: '',
                data: PermitBasicData.fromJson(permitHtmlMap));
        if (permitHtmlMap.isNotEmpty) {
          emit(PermitBasicDetailsFetched(
              fetchPermitBasicDetailsModel: fetchPermitBasicDetailsModel));
        } else {
          emit(const PermitBasicDetailsNotFetched(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      }
    } catch (e) {
      emit(PermitBasicDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchDataForOpenPermit(
      FetchDataForOpenPermit event, Emitter<PermitStates> emit) async {
    emit(DataForOpenPermitFetching());
    try {
      if (isNetworkEstablished) {
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
      } else {
        Map<String, dynamic> permitHtmlMap =
            await _databaseHelper.fetchPermitDetailsHtml(event.permitId);
        FetchDataForOpenPermitModel fetchDataForOpenPermitModel =
            FetchDataForOpenPermitModel(
                status: 200,
                message: '',
                data: FetchDataForOpenPermitData.fromJson(permitHtmlMap));
        final List<Question> questions = [
          Question(questionNo: StringConstants.kPermitFirstQuestion),
          Question(questionNo: StringConstants.kPanel12),
          Question(questionNo: StringConstants.kPanel15),
          Question(questionNo: StringConstants.kPanel16)
        ];
        if (permitHtmlMap.isNotEmpty) {
          emit(DataForOpenPermitFetched(
              fetchDataForOpenPermitModel: fetchDataForOpenPermitModel,
              questions: questions));
        } else {
          emit(const DataForOpenPermitNotFetched(
              errorMessage: StringConstants.kNoDataFound));
        }
      }
    } catch (e) {
      emit(DataForOpenPermitNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveMarkAsPrepared(
      SaveMarkAsPrepared event, Emitter<PermitStates> emit) async {
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      String userId = (await _customerCache.getUserId(CacheKeys.userId)) ?? '';
      Map saveMarkAsPreparedMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
        "userid": userId,
        "controlpersons": event.markAsPreparedMap['controlpersons'],
        "user_sign": event.markAsPreparedMap['user_sign'] ?? '',
        "user_name": event.markAsPreparedMap['user_name'] ?? '',
        "user_email": event.markAsPreparedMap['user_email'] ?? ''
      };
      if (isNetworkEstablished) {
        emit(MarkAsPreparedSaving());
        if (event.markAsPreparedMap['controlpersons'] != '') {
          SaveMarkAsPreparedModel saveMarkAsPreparedModel =
              await _permitRepository.saveMarkAsPrepared(saveMarkAsPreparedMap);
          if (saveMarkAsPreparedModel.message == '1') {
            if (event.offlineActionId != null) {
              await _databaseHelper
                  .deleteOfflinePermitAction(event.offlineActionId!);
            }
            emit(MarkAsPreparedSaved());
          } else {
            emit(MarkAsPreparedNotSaved(
                errorMessage: saveMarkAsPreparedModel.message!));
          }
        } else {
          emit(const MarkAsPreparedNotSaved(
              errorMessage: StringConstants.kPleaseFillControlPerson));
        }
      } else {
        add(SavePermitOfflineAction(
            offlineDataMap: event.markAsPreparedMap,
            permitId: event.permitId,
            signature: event.markAsPreparedMap['user_sign'] ?? '',
            actionKey: 'prepare_permit',
            dateTime:
                '${event.markAsPreparedMap['user_date']}${event.markAsPreparedMap['user_time']}'));
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
        "npw_name": event.acceptPermitMap['npw_name'] ?? '',
        "npw_auth": event.acceptPermitMap['npw_auth'] ?? '',
        "npw_company": event.acceptPermitMap['npw_company'] ?? '',
        "npw_email": event.acceptPermitMap['npw_email'] ?? '',
        "npw_phone": event.acceptPermitMap['npw_phone'] ?? '',
        "sync_sign:": event.acceptPermitMap['user_sign'] ?? '',
        "sync-date": event.syncDate,
      };
      if (isNetworkEstablished) {
        AcceptPermitRequestModel acceptPermitRequestModel =
            await _permitRepository.acceptPermitRequest(acceptPermitRequestMap);
        if (acceptPermitRequestModel.message == '1') {
          if (event.offlineActionId != null) {
            await _databaseHelper
                .deleteOfflinePermitAction(event.offlineActionId!);
          }
          emit(PermitRequestAccepted());
        } else {
          emit(PermitRequestNotAccepted(
              errorMessage: acceptPermitRequestModel.message!));
        }
      } else {
        add(SavePermitOfflineAction(
            offlineDataMap: acceptPermitRequestMap,
            permitId: event.permitId,
            signature: event.acceptPermitMap['user_sign'],
            actionKey: event.acceptPermitMap['action_key'],
            dateTime:
                '${event.acceptPermitMap['user_date']}${event.acceptPermitMap['user_time']}'));
      }
    } catch (e) {
      emit(PermitRequestNotAccepted(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchClearPermit(
      FetchClearPermit event, Emitter<PermitStates> emit) async {
    try {
      if (isNetworkEstablished) {
        emit(FetchingClearPermitDetails());
        FetchClearPermitDetailsModel fetchClearPermitDetailsModel =
            await _permitRepository.fetchClearPermitDetails({
          'permit_id': event.permitId,
          'hashcode':
              await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
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
      } else {
        List<Map<String, dynamic>> customFields = [];
        Map<String, dynamic> populateDataMap = {};
        Map<String, dynamic> permitHtmlMap =
            await _databaseHelper.fetchPermitDetailsHtml(event.permitId);
        List populateClearPermitData =
            await _databaseHelper.populateClearPermitData(event.permitId);
        FetchClearPermitDetailsModel fetchClearPermitDetailsModel =
            FetchClearPermitDetailsModel(
                status: 200,
                message: '',
                data: ClearPermitData.fromJson(permitHtmlMap));
        fetchClearPermitDetailsModel.data.permitStatus = getStatusText(
            fetchClearPermitDetailsModel.data.typeOfPermit.toString(),
            statusId.toString());
        if (populateClearPermitData.isNotEmpty) {
          for (var field in populateClearPermitData) {
            int questionId = field['questionid'];
            String answer = field['answer'];
            switch (questionId) {
              case 3000009:
                populateDataMap['4000009'] = answer;
                break;
              case 3000001:
                populateDataMap['4000001'] = answer;
                break;
              case 3000002:
                populateDataMap['4000002'] = answer;
                break;
              case 3000003:
                populateDataMap['4000003'] = answer;
                break;
              case 3000004:
                populateDataMap['4000004'] = answer;
                break;
              case 3000005:
                populateDataMap['4000005'] = answer;
                break;
              case 3000006:
                populateDataMap['4000006'] = answer;
                break;
              case 3000007:
                populateDataMap['4000007'] = answer;
                break;
              case 3000008:
                populateDataMap['4000008'] = answer;
                break;
              case 3000013:
                populateDataMap['40000013'] = answer;
                break;
              case 3000014:
                populateDataMap['40000014'] = answer;
                break;
            }
          }
          customFields = [
            {"questionid": 40000010, "answer": ''},
            {"questionid": 4000001, "answer": populateDataMap['4000001'] ?? ''},
            {"questionid": 4000002, "answer": populateDataMap['4000002'] ?? ''},
            {"questionid": 4000003, "answer": populateDataMap['4000003'] ?? ''},
            {"questionid": 4000004, "answer": populateDataMap['4000004'] ?? ''},
            {"questionid": 4000005, "answer": populateDataMap['4000005'] ?? ''},
            {"questionid": 4000006, "answer": populateDataMap['4000006'] ?? ''},
            {"questionid": 4000007, "answer": populateDataMap['4000007'] ?? ''},
            {"questionid": 4000008, "answer": populateDataMap['4000008'] ?? ''},
            {
              "questionid": 4000013,
              "answer": populateDataMap['40000013'] ?? ''
            },
            {"questionid": 4000014, "answer": populateDataMap['40000014'] ?? ''}
          ];
        } else {
          customFields = [
            {"questionid": 4000010, "answer": ""},
            {
              "questionid": 4000001,
              "answer": permitHtmlMap['open_permit_3000001'] ?? ''
            },
            {
              "questionid": 4000002,
              "answer": permitHtmlMap['open_permit_3000002'] ?? ''
            },
            {
              "questionid": 4000003,
              "answer": permitHtmlMap['open_permit_3000003'] ?? ''
            },
            {
              "questionid": 4000004,
              "answer": permitHtmlMap['open_permit_3000004'] ?? ''
            },
            {
              "questionid": 4000005,
              "answer": permitHtmlMap['open_permit_3000005'] ?? ''
            },
            {
              "questionid": 4000006,
              "answer": permitHtmlMap['open_permit_3000006'] ?? ''
            },
            {
              "questionid": 4000007,
              "answer": permitHtmlMap['open_permit_3000007'] ?? ''
            },
            {
              "questionid": 4000008,
              "answer": permitHtmlMap['open_permit_3000008'] ?? ''
            },
            {
              "questionid": 4000013,
              "answer": permitHtmlMap['open_permit_30000013'] ?? ''
            },
            {
              "questionid": 4000014,
              "answer": permitHtmlMap['open_permit_30000014'] ?? ''
            }
          ];
        }

        emit(ClearPermitDetailsFetched(
            fetchClearPermitDetailsModel: fetchClearPermitDetailsModel,
            customFields: customFields));
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
        "permitid": event.clearPermitMap['permit_id'] ??
            event.clearPermitMap['permitid'],
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "customfields": event.clearPermitMap['customfields'],
        "npwid": "",
        "npw_name": event.clearPermitMap['npw_name'] ?? '',
        "npw_auth": event.clearPermitMap['npw_auth'] ?? '',
        "npw_company": event.clearPermitMap['npw_company'] ?? '',
        "npw_email": event.clearPermitMap['npw_email'] ?? '',
        "npw_phone": event.clearPermitMap['npw_phone'] ?? '',
        "sync_sign": event.clearPermitMap['user_sign'] ?? '',
        "sync-date": event.syncDate
      };
      if (isNetworkEstablished) {
        SaveClearPermitModel saveClearPermitModel =
            await _permitRepository.saveClearPermit(clearPermitMap);
        if (saveClearPermitModel.message == '1') {
          if (event.offlineActionId != null) {
            await _databaseHelper
                .deleteOfflinePermitAction(event.offlineActionId!);
          }
          emit(ClearPermitSaved());
        } else {
          emit(ClearPermitNotSaved(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        add(SavePermitOfflineAction(
            offlineDataMap: clearPermitMap,
            permitId: event.clearPermitMap['permitid'],
            signature: event.clearPermitMap['user_sign'],
            actionKey: event.clearPermitMap['action_key'],
            dateTime:
                '${event.clearPermitMap['user_date']}${event.clearPermitMap['user_time']}'));
      }
    } catch (e) {
      emit(ClearPermitNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> savePermitEditSafetyDocument(
      SavePermitEditSafetyDocument event, Emitter<PermitStates> emit) async {
    try {
      Map editSafetyDocumentMap = {
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode),
        "permitid": event.permitId,
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
      if (isNetworkEstablished) {
        emit(SavingPermitEditSafetyDocument());
        SavePermitEditSafetyDocumentModel savePermitEditSafetyDocumentModel =
            await _permitRepository
                .saveEditSafetyNoticeDocument(editSafetyDocumentMap);
        if (savePermitEditSafetyDocumentModel.message == '1') {
          if (event.offlineActionId != null) {
            await _databaseHelper
                .deleteOfflinePermitAction(event.offlineActionId!);
          }
          emit(PermitEditSafetyDocumentSaved());
        } else {
          emit(PermitEditSafetyDocumentNotSaved(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        bool isDataInserted = await _databaseHelper.insertOfflinePermitAction(
            event.permitId,
            'edit_safety_document',
            editSafetyDocumentMap,
            "",
            null);
        if (isDataInserted) {
          await _databaseHelper.updateEquipmentSafetyDoc(
              event.permitId, event.editSafetyDocumentMap);
          emit(PermitEditSafetyDocumentSaved(
              successMessage: StringConstants.kDataSavedSuccessfully));
        } else {
          emit(PermitEditSafetyDocumentNotSaved(
              errorMessage: StringConstants.kFailedToSaveData));
        }
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
    if (isNetworkEstablished) {
      emit(PermitCPChanging());
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
    } else {
      Map saveTransferMap = {
        'npw_id': 0,
        'npw_name': event.changePermitCPMap['npw_name'] ?? '',
        'npw_auth': event.changePermitCPMap['npw_auth'] ?? '',
        'npw_sign': event.changePermitCPMap['user_sign'] ?? '',
        'date': event.changePermitCPMap['user_date'] ?? '',
        'time': event.changePermitCPMap['user_time'] ?? '',
        'user_id': 0,
        'user_name': event.changePermitCPMap['user_name'] ?? '',
        'user_sign': event.changePermitCPMap['user_sign'] ?? '',
        'controlusername': event.changePermitCPMap['controlPerson'] ?? ''
      };
      Map<String, dynamic> fetchTransferData =
          await _databaseHelper.fetchOfflinePermitTransferData(event.permitId);
      if (fetchTransferData['receiver'] != [] &&
          fetchTransferData['receiver'] != null) {
        transferAndSurrenderMap['reciever'] = fetchTransferData['transfer'];
        transferAndSurrenderMap['reciever'].add(saveTransferMap);
        transferAndSurrenderMap['isSurrender'] = '0';
        transferAndSurrenderMap['hashcode'] =
            await _customerCache.getHashCode(CacheKeys.hashcode);
      } else {
        transferAndSurrenderMap['surrender'] = [];
        transferAndSurrenderMap['reciever'] = [];
        transferAndSurrenderMap['reciever'].add(saveTransferMap);
        transferAndSurrenderMap['isSurrender'] = '0';
        transferAndSurrenderMap['hashcode'] =
            await _customerCache.getHashCode(CacheKeys.hashcode);
      }
      add(SavePermitOfflineAction(
          offlineDataMap: transferAndSurrenderMap,
          permitId: event.permitId,
          signature: event.changePermitCPMap['npw_sign'] ?? '',
          actionKey: 'transfer_permit',
          dateTime:
              '${saveTransferMap['user_date']}${saveTransferMap['user_time']}'));
    }
    } catch (e) {
      emit(PermitCPNotChanged(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _saveOfflineData(
      SavePermitOfflineAction event, Emitter<PermitStates> emit) async {
    try {
    bool isDataInserted = await _databaseHelper.insertOfflinePermitAction(
        event.permitId,
        event.actionKey,
        event.offlineDataMap,
        event.signature,
        event.dateTime);
    int typeOfPermit = await _databaseHelper.getTypeOfPermit(event.permitId);
    if (isDataInserted) {
      switch (event.actionKey) {
        case 'open_permit':
          await _databaseHelper.updateStatusId(event.permitId, 2);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '2'));
          break;
        case 'cancel_permit':
          await _databaseHelper.updateStatusId(event.permitId, 3);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '3'));
          break;
        case 'prepare_permit':
          await _databaseHelper.updateStatusId(event.permitId, 16);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '16'));
          break;
        case 'clear_permit':
          await _databaseHelper.updateStatusId(event.permitId, 18);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '18'));
          break;
        case 'accept_permit_request':
          await _databaseHelper.updateStatusId(event.permitId, 17);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '17'));
          break;
        case 'edit_safety_document':
          await _databaseHelper.updateStatusId(event.permitId, 0);
          await _databaseHelper.updateStatus(
              event.permitId, getStatusText(typeOfPermit.toString(), '0'));
          break;
        default:
          '';
          break;
      }
      emit(OfflineDataSaved(
          successMessage: StringConstants.kDataSavedSuccessfully));
    } else {
      emit(
          OfflineDataNotSaved(errorMessage: StringConstants.kFailedToSaveData));
    }
    } catch (e) {
      emit(
          OfflineDataNotSaved(errorMessage: StringConstants.kFailedToSaveData));
    }
  }

  FutureOr<void> _permitInternetActions(
      PermitInternetActions event, Emitter<PermitStates> emit) async {
    List<Map<String, dynamic>> permitActions =
        await _databaseHelper.fetchOfflinePermitAction();
    if (permitActions.isNotEmpty) {
      for (var action in permitActions) {
        switch (action['actionText']) {
          case 'edit_safety_document':
            add(SavePermitEditSafetyDocument(
                editSafetyDocumentMap: jsonDecode(action['actionJson']),
                offlineActionId: action['id'],
                permitId: action['permitId']));
            break;
          case 'prepare_permit':
            add(SaveMarkAsPrepared(
                permitId: action['permitId'],
                markAsPreparedMap: jsonDecode(action['actionJson']),
                offlineActionId: action['id']));
            break;
          case 'open_permit':
            add(OpenPermit(jsonDecode(action['actionJson']), action['permitId'],
                action['id']));
            break;
          case 'accept_permit_request':
            add(AcceptPermitRequest(
                permitId: action['permitId'],
                acceptPermitMap: jsonDecode(action['actionJson']),
                syncDate: action['actionDateTime'],
                offlineActionId: action['id']));
            break;
          case 'clear_permit':
            add(SaveClearPermit(
                permitId: action['permitId'],
                clearPermitMap: jsonDecode(action['actionJson']),
                syncDate: action['actionDateTime'],
                offlineActionId: action['id']));
            break;
          case 'cancel_permit':
            add(ClosePermit(
                permitId: action['permitId'],
                closePermitMap: jsonDecode(action['actionJson']),
                offlineActionId: action['id']));
            break;
          case 'surrender_permit':
            Map surrenderMap = jsonDecode(action['actionJson']);
            surrenderMap['permitid'] = await EncryptData.decryptAESPrivateKey(
                action['permitId'],
                await _customerCache.getApiKey(CacheKeys.apiKey));
            await _permitRepository.syncTransferCp(surrenderMap);
            break;
          case 'transfer_permit':
            Map transferMap = jsonDecode(action['actionJson']);
            transferMap['permitid'] = await EncryptData.decryptAESPrivateKey(
                action['permitId'],
                await _customerCache.getApiKey(CacheKeys.apiKey));
            await _permitRepository.syncTransferCp(transferMap);
            break;
          default:
            null;
            break;
        }
      }
    }
  }

  FutureOr<void> _surrenderPermit(
      SurrenderPermit event, Emitter<PermitStates> emit) async {
    try {
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      Map surrenderPermitMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
      };
      if (isNetworkEstablished) {
        emit(SurrenderingPermit());
        SurrenderPermitModel surrenderPermitModel =
            await _permitRepository.surrenderPermit(surrenderPermitMap);
        if (surrenderPermitModel.message == '1') {
          emit(PermitSurrendered());
        } else {
          emit(PermitNotSurrender(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        Map surrenderPermitOfflineMap = {
          "npw_id": 0,
          "npw_name": event.surrenderPermitMap['npw_name'] ?? '',
          "npw_auth": event.surrenderPermitMap['npw_auth'] ?? '',
          "npw_sign": event.surrenderPermitMap['user_sign'] ?? '',
          "date": event.surrenderPermitMap['user_date'] ?? '',
          "time": event.surrenderPermitMap['user_time'] ?? '',
        };
        Map<String, dynamic> fetchSurrenderData = await _databaseHelper
            .fetchOfflinePermitSurrenderData(event.permitId);
        if (fetchSurrenderData['surrender'] != [] &&
            fetchSurrenderData['surrender'] != null) {
          transferAndSurrenderMap['surrender'] =
              fetchSurrenderData['surrender'];
          transferAndSurrenderMap['surrender'].add(surrenderPermitOfflineMap);
          transferAndSurrenderMap['issurrender'] = '1';
          transferAndSurrenderMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        } else {
          if (transferAndSurrenderMap.isEmpty) {
            transferAndSurrenderMap['surrender'] = [];
            transferAndSurrenderMap['reciever'] = [];
          }
          transferAndSurrenderMap['surrender'].add(surrenderPermitOfflineMap);
          transferAndSurrenderMap['issurrender'] = '1';
          transferAndSurrenderMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        }

        add(SavePermitOfflineAction(
            offlineDataMap: transferAndSurrenderMap,
            permitId: event.permitId,
            signature: event.surrenderPermitMap['npw_sign'] ?? '',
            actionKey: 'surrender_permit',
            dateTime:
                '${event.surrenderPermitMap['date']}${event.surrenderPermitMap['time']}'));
      }
    } catch (e) {
      emit(PermitNotSurrender(errorMessage: e.toString()));
    }
  }
}
