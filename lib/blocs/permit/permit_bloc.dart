import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/encrypt_class.dart';
import '../../data/models/pdf_generation_model.dart';
import '../../data/models/permit/accept_permit_request_model.dart';
import '../../data/models/permit/all_permits_model.dart';
import '../../data/models/permit/change_permit_cp_model.dart';
import '../../data/models/permit/close_permit_details_model.dart';
import '../../data/models/permit/fetch_clear_permit_details_model.dart';
import '../../data/models/permit/fetch_data_for_change_permit_cp_model.dart';
import '../../data/models/permit/fetch_data_for_open_permit_model.dart';
import '../../data/models/permit/fetch_permit_basic_details_model.dart';
import '../../data/models/permit/offline_permit_model.dart';
import '../../data/models/permit/open_close_permit_model.dart';
import '../../data/models/permit/open_permit_details_model.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../data/models/permit/permit_edit_safety_document_ui_plot_model.dart';
import '../../data/models/permit/permit_get_master_model.dart';
import '../../data/models/permit/permit_roles_model.dart';
import '../../data/models/permit/save_clear_permit_model.dart';
import '../../data/models/permit/save_mark_as_prepared_model.dart';
import '../../data/models/permit/save_permit_safety_notice_model.dart';
import '../../data/models/permit/surrender_permit_model.dart';
import '../../data/models/permit/sync_transfer_cp_model.dart';
import '../../di/app_module.dart';
import '../../repositories/permit/permit_repository.dart';
import '../../utils/constants/html_constants.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database/database_util.dart';
import '../../utils/database_utils.dart';
import '../../utils/global.dart';
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
    on<SaveClearPermit>(_saveClearPermit);
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
    on<GenerateOfflinePdf>(_generateOfflinePdf);
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
          List<Map<String, dynamic>> result =
              await _databaseHelper.fetchPermitListOffline();
          final List<Map<String, dynamic>> fetchListPageData = [];
          for (var data in result) {
            var listPageJson = jsonDecode(data['listPage']);
            listPageJson['actionCount'] = data['actionCount'];
            fetchListPageData.add(listPageJson);
          }
          AllPermitModel allPermitModel = AllPermitModel.fromJson(
              {'Status': 200, 'Message': '', 'Data': fetchListPageData});
          permitListData.addAll(allPermitModel.data);
          listReachedMax = true;
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
            emit(PermitOpened(openClosePermitModel));
          }
        } else {
          add(SavePermitOfflineAction(
              offlineDataMap: openPermitMap,
              permitId: event.openPermitMap['permitId'],
              signature: event.openPermitMap['user_sign'],
              actionKey: 'open_permit',
              dateTime:
                  '${event.openPermitMap['user_date']} ${event.openPermitMap['user_time']}'));
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
                  '${event.closePermitMap['date']} ${event.closePermitMap['time']}'));
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
            offlineDataMap: saveMarkAsPreparedMap,
            permitId: event.permitId,
            signature: event.markAsPreparedMap['user_sign'] ?? '',
            actionKey: 'prepare_permit',
            dateTime:
                '${event.markAsPreparedMap['user_date']} ${event.markAsPreparedMap['user_time']}'));
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
        "sync_sign": event.acceptPermitMap['npw_sign'] ?? '',
        "sync_date":
            '${event.acceptPermitMap['user_date']} ${event.acceptPermitMap['user_time']}',
      };
      if (isNetworkEstablished) {
        AcceptPermitRequestModel acceptPermitRequestModel =
            await _permitRepository.acceptPermitRequest(acceptPermitRequestMap);
        if (acceptPermitRequestModel.message == '1') {
          emit(PermitRequestAccepted());
        } else {
          emit(PermitRequestNotAccepted(
              errorMessage: acceptPermitRequestModel.message!));
        }
      } else {
        add(SavePermitOfflineAction(
            offlineDataMap: acceptPermitRequestMap,
            permitId: event.permitId,
            signature: event.acceptPermitMap['npw_sign'],
            actionKey: event.acceptPermitMap['action_key'],
            dateTime:
                '${event.acceptPermitMap['user_date']} ${event.acceptPermitMap['user_time']}'));
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

  FutureOr<void> _saveClearPermit(
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
        "sync_sign": event.clearPermitMap['npw_sign'] ?? '',
        "sync_date": event.clearPermitMap['user_date'] ?? '',
      };
      if (isNetworkEstablished) {
        SaveClearPermitModel saveClearPermitModel =
            await _permitRepository.saveClearPermit(clearPermitMap);
        if (saveClearPermitModel.message == '1') {
          emit(ClearPermitSaved());
        } else {
          emit(ClearPermitNotSaved(
              errorMessage: StringConstants.kSomethingWentWrong));
        }
      } else {
        add(SavePermitOfflineAction(
            offlineDataMap: clearPermitMap,
            permitId: event.clearPermitMap['permitid'],
            signature: event.clearPermitMap['npw_sign'],
            actionKey: event.clearPermitMap['action_key'],
            dateTime:
                '${event.clearPermitMap['user_date']} ${event.clearPermitMap['user_time']}'));
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
        "description": event.editSafetyDocumentMap['description'] ?? '',
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
      Map transferMap = {};
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
            emit(
                PermitCPNotChanged(errorMessage: changePermitCpModel.message!));
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
          'npw_sign': event.changePermitCPMap['npw_sign'] ?? '',
          'date': event.changePermitCPMap['user_date'] ?? '',
          'time': event.changePermitCPMap['user_time'] ?? '',
          'user_id': 0,
          'user_name': event.changePermitCPMap['user_name'] ?? '',
          'user_sign': event.changePermitCPMap['user_sign'] ?? '',
          'controlusername': event.changePermitCPMap['controlPerson'] ?? '',
          'company': event.changePermitCPMap['npw_company'] ?? ''
        };
        Map<String, dynamic> fetchTransferData = await _databaseHelper
            .fetchOfflinePermitTransferData(event.permitId);
        if (fetchTransferData['reciever'] != [] &&
            fetchTransferData['reciever'] != null) {
          transferMap['reciever'] = fetchTransferData['reciever'];
          transferMap['reciever'].add(saveTransferMap);
          transferMap['isSurrender'] = '0';
          transferMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        } else {
          transferMap['surrender'] = [];
          transferMap['reciever'] = [];
          transferMap['reciever'].add(saveTransferMap);
          transferMap['isSurrender'] = '0';
          transferMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        }
        add(SavePermitOfflineAction(
            offlineDataMap: transferMap,
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

  FutureOr<void> _surrenderPermit(
      SurrenderPermit event, Emitter<PermitStates> emit) async {
    emit(SurrenderingPermit());
    try {
      Map surrenderMap = {};
      String hashCode =
          (await _customerCache.getHashCode(CacheKeys.hashcode)) ?? '';
      Map surrenderPermitMap = {
        "hashcode": hashCode,
        "permitid": event.permitId,
      };
      if (isNetworkEstablished) {
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
          "npw_sign": event.surrenderPermitMap['npw_sign'] ?? '',
          "date": event.surrenderPermitMap['user_date'] ?? '',
          "time": event.surrenderPermitMap['user_time'] ?? '',
        };
        Map<String, dynamic> fetchSurrenderData = await _databaseHelper
            .fetchOfflinePermitSurrenderData(event.permitId);
        if (fetchSurrenderData['surrender'] != [] &&
            fetchSurrenderData['surrender'] != null) {
          surrenderMap['surrender'] = fetchSurrenderData['surrender'];
          surrenderMap['surrender'].add(surrenderPermitOfflineMap);
          surrenderMap['issurrender'] = '1';
          surrenderMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        } else {
          surrenderMap['surrender'] = [];
          surrenderMap['reciever'] = [];

          surrenderMap['surrender'].add(surrenderPermitOfflineMap);
          surrenderMap['issurrender'] = '1';
          surrenderMap['hashcode'] =
              await _customerCache.getHashCode(CacheKeys.hashcode);
        }
        add(SavePermitOfflineAction(
            offlineDataMap: surrenderMap,
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
        emit(OfflineDataNotSaved(
            errorMessage: StringConstants.kFailedToSaveData));
      }
    } catch (e) {
      emit(
          OfflineDataNotSaved(errorMessage: StringConstants.kFailedToSaveData));
    }
  }

  FutureOr<void> _permitInternetActions(
      PermitInternetActions event, Emitter<PermitStates> emit) async {
    try {
      List<Map<String, dynamic>> permitActions =
          await _databaseHelper.fetchAllOfflinePermitAction();
      if (permitActions.isNotEmpty) {
        for (var action in permitActions) {
          switch (action['actionText']) {
            case 'edit_safety_document':
              SavePermitEditSafetyDocumentModel
                  savePermitEditSafetyDocumentModel =
                  await _permitRepository.saveEditSafetyNoticeDocument(
                      jsonDecode(action['actionJson']));
              if (savePermitEditSafetyDocumentModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']!);
              }
              break;
            case 'prepare_permit':
              SaveMarkAsPreparedModel saveMarkAsPreparedModel =
                  await _permitRepository
                      .saveMarkAsPrepared(jsonDecode(action['actionJson']));
              if (saveMarkAsPreparedModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            case 'open_permit':
              OpenClosePermitModel openClosePermitModel =
                  await _permitRepository
                      .openPermit(jsonDecode(action['actionJson']));
              if (openClosePermitModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']!);
              }
              break;
            case 'accept_permit_request':
              AcceptPermitRequestModel acceptPermitRequestModel =
                  await _permitRepository
                      .acceptPermitRequest(jsonDecode(action['actionJson']));
              if (acceptPermitRequestModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            case 'clear_permit':
              SaveClearPermitModel saveClearPermitModel =
                  await _permitRepository
                      .saveClearPermit(jsonDecode(action['actionJson']));
              if (saveClearPermitModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            case 'cancel_permit':
              OpenClosePermitModel openClosePermitModel =
                  await _permitRepository
                      .closePermit(jsonDecode(action['actionJson']));
              if (openClosePermitModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            case 'surrender_permit':
              Map surrenderMap = jsonDecode(action['actionJson']);
              surrenderMap['permitid'] = await EncryptData.decryptAESPrivateKey(
                  action['permitId'],
                  await _customerCache.getApiKey(CacheKeys.apiKey));
              SyncTransferCpPermitModel syncTransferCpModel =
                  await _permitRepository.syncTransferCp(surrenderMap);
              if (syncTransferCpModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            case 'transfer_permit':
              Map transferMap = jsonDecode(action['actionJson']);
              transferMap['permitid'] = await EncryptData.decryptAESPrivateKey(
                  action['permitId'],
                  await _customerCache.getApiKey(CacheKeys.apiKey));
              SyncTransferCpPermitModel syncTransferCpModel =
                  await _permitRepository.syncTransferCp(transferMap);
              if (syncTransferCpModel.message == '1') {
                await _databaseHelper.deleteOfflinePermitAction(action['id']);
              }
              break;
            default:
              null;
              break;
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _generateOfflinePdf(
      GenerateOfflinePdf event, Emitter<PermitStates> emit) async {
    try {
      emit(GeneratingOfflinePdf());
      Map<String, dynamic> offlinePermitData =
          await _databaseHelper.fetchPermitDetailsOffline(event.permitId);
      String htmlText = '';
      switch (offlinePermitData['tab1']['type_of_permit']) {
        case 12:
          htmlText = HTMLOfflineConstants.offlinePermitType12;
          break;
        case 15:
          htmlText = HTMLOfflineConstants.offlinePermitType15;
          break;
        case 16:
          htmlText = HTMLOfflineConstants.offlinePermitType16;
          break;
        default:
          emit(
              ErrorGeneratingPdfOffline(errorMessage: 'permit type not found'));
          break;
      }

      htmlText = htmlText.replaceAll(
          '#permitname', offlinePermitData['tab1']['permit']);
      htmlText = htmlText.replaceAll(
          '#location', offlinePermitData['tab1']['location']);
      htmlText =
          htmlText.replaceAll('#enddate', offlinePermitData['html']['enddate']);

      List surrenderList = [];
      List receiverList = [];
      for (int j = 1; j <= 4; j++) {
        if (offlinePermitData['html']["201202_${j}_date"].length > 0) {
          surrenderList.add({
            "npw_id": 0,
            "npw_name": offlinePermitData['html']["201202_${j}_name"] ?? "",
            "npw_auth": offlinePermitData['html']["201202_${j}_authno"] ?? "",
            "npw_sign": offlinePermitData['html']["201202_${j}_npwsign"] ?? "",
            "date": offlinePermitData['html']["201202_${j}_date"] ?? "",
            "time": offlinePermitData['html']["201202_${j}_time"] ?? ""
          });
        }

        if (offlinePermitData['html']["203204_${j}_date"].length > 0) {
          receiverList.add({
            "npw_id": 0,
            "npw_name": offlinePermitData['html']["203204_${j}_name"] ?? '',
            "npw_auth": offlinePermitData['html']["203204_${j}_authno"] ?? '',
            "npw_sign": offlinePermitData['html']["203204_${j}_npwsign"] ?? '',
            "date": offlinePermitData['html']["203204_${j}_date"] ?? '',
            "time": offlinePermitData['html']["203204_${j}_time"] ?? '',
            "user_id": 0,
            "user_name":
                offlinePermitData['html']["203204_${j}_username"] ?? '',
            "user_sign":
                offlinePermitData['html']["203204_${j}_usersign"] ?? '',
            "controlusername":
                offlinePermitData['html']["203204_${j}_controlusername"] ?? '',
            "company": offlinePermitData['html']["203204_${j}_company"] ?? ''
          });
        }
      }

      List<Map<String, dynamic>> permitActionsList =
          await _databaseHelper.fetchOfflinePermitAction(event.permitId);

      for (var action in permitActionsList) {
        if (action.isNotEmpty) {
          switch (action['actionText']) {
            case 'prepare_permit':
              htmlText = htmlText.replaceAll(
                  '#16_comments', action['actionJson']['controlpersons']);
              htmlText = htmlText.replaceAll(
                  '#16_name', action['actionJson']['user_name']);
              htmlText = htmlText.replaceAll(
                  '#16_email', (action['actionJson']['user_email']) ?? '');
              htmlText = htmlText.replaceAll('#16_phone', '');
              htmlText = htmlText.replaceAll(
                  '#16_sign', action['actionJson']['user_sign']);

              List dateTime = action['actionDateTime'].split(' ');
              String d1 = "${dateTime[0]}";
              String t1 = "${dateTime[1]}";

              htmlText = htmlText.replaceAll('#16_time', t1);
              htmlText = htmlText.replaceAll('#16_date', d1);
              break;

            case 'edit_safety_document':
              htmlText = htmlText.replaceAll('#ptw_isolation',
                  (action['actionJson']['ptw_isolation'] ?? ''));
              htmlText = htmlText.replaceAll(
                  '#ptw_circuit', (action['actionJson']['ptw_circuit'] ?? ''));
              htmlText = htmlText.replaceAll('#2ptw_circuit',
                  (action['actionJson']['ptw_circuit2'] ?? ''));
              htmlText = htmlText.replaceAll(
                  '#ptw_safety', (action['actionJson']['ptw_safety'] ?? ''));
              htmlText = htmlText.replaceAll('#ptw_precautions',
                  (action['actionJson']['ptw_precautions'] ?? ''));
              htmlText = htmlText.replaceAll('#2ptw_precautions',
                  (action['actionJson']['ptw_precautions2'] ?? ''));

              htmlText = htmlText.replaceAll(
                  '#st_circuit', (action['actionJson']['st_circuit'] ?? ''));
              htmlText = htmlText.replaceAll('#st_precautions',
                  (action['actionJson']['st_precautions'] ?? ''));
              htmlText = htmlText.replaceAll(
                  '#st_safety', (action['actionJson']['st_safety'] ?? ''));

              htmlText = htmlText.replaceAll('#lwc_accessto',
                  (action['actionJson']['lwc_accessto'] ?? ''));
              htmlText = htmlText.replaceAll('#lwc_environment',
                  (action['actionJson']['lwc_environment'] ?? ''));
              htmlText = htmlText.replaceAll('#lwc_precautions',
                  (action['actionJson']['lwc_precautions'] ?? ''));

              htmlText = htmlText.replaceAll(
                  '#methodstmt', action['actionJson']['methodstmt']);
              htmlText = htmlText.replaceAll(
                  '#description', action['actionJson']['description']);
              break;

            case 'open_permit':
              htmlText = htmlText.replaceAll(
                  '#2_name', action['actionJson']['user_name']);
              htmlText = htmlText.replaceAll(
                  '#2_email', (action['actionJson']['user_email']) ?? '');
              htmlText = htmlText.replaceAll('#2_phone', '');
              htmlText = htmlText.replaceAll(
                  '#2_sign', action['actionJson']['user_sign']);

              List dateTime = action['actionDateTime'].split(' ');
              String d2 = "${dateTime[0]}";
              String t2 = "${dateTime[1]}";

              htmlText = htmlText.replaceAll('#2_time', t2);
              htmlText = htmlText.replaceAll('#2_date', d2);

              if (action['actionJson']['customfields'].isNotEmpty) {
                for (int i = 0;
                    i < action['actionJson']['customfields'].length;
                    i++) {
                  var f = action['actionJson']['customfields'][i];
                  switch (f['questionid']) {
                    case 3000001:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000001', f['answer']);
                      break;
                    case 3000002:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000002', f['answer']);
                      break;
                    case 3000003:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000003', f['answer']);
                      break;
                    case 3000004:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000004', f['answer']);
                      break;
                    case 3000005:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000005', f['answer']);
                      break;
                    case 3000006:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000006', f['answer']);
                      break;
                    case 3000007:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000007', f['answer']);
                      break;
                    case 3000008:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000008', f['answer']);
                      break;
                    case 3000009:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000009', f['answer']);
                      break;
                    case 3000013:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000013', f['answer']);
                      break;
                    case 3000014:
                      htmlText = htmlText.replaceAll(
                          '#open_permit_3000014', f['answer']);
                      break;
                  }
                }
              }
              break;

            case 'accept_permit_request':
              htmlText = htmlText.replaceAll(
                  '#32_name', action['actionJson']['npw_name']);
              htmlText = htmlText.replaceAll(
                  '#32_authcode', (action['actionJson']['npw_auth']) ?? '');
              htmlText = htmlText.replaceAll(
                  '#32_company', (action['actionJson']['npw_company']) ?? '');
              htmlText = htmlText.replaceAll(
                  '#32_email', (action['actionJson']['npw_email']) ?? '');
              htmlText = htmlText.replaceAll('#32_phone', '');

              List dateTime = action['actionDateTime'].split(' ');
              String d3 = "${dateTime[0]}";
              String t3 = "${dateTime[1]}";

              htmlText = htmlText.replaceAll('#32_time', t3);
              htmlText = htmlText.replaceAll('#32_date', d3);

              htmlText = htmlText.replaceAll('#32_sign', action['sign']);
              break;

            case 'clear_permit':
              htmlText = htmlText.replaceAll(
                  '#18_name', action['actionJson']['npw_name']);
              htmlText = htmlText.replaceAll(
                  '#18_authcode', action['actionJson']['npw_auth']);

              List dateTime = action['actionDateTime'].split(' ');
              String d4 = "${dateTime[0]}";
              String t4 = "${dateTime[1]}";

              htmlText = htmlText.replaceAll('#18_time', t4);
              htmlText = htmlText.replaceAll('#18_date', d4);
              htmlText = htmlText.replaceAll('#18_sign', action['sign']);

              if (action['actionJson']['customfields'].isNotEmpty) {
                for (int i = 0;
                    i < action['actionJson']['customfields'].length;
                    i++) {
                  var f = action['actionJson']['customfields'][i];
                  switch (f['questionid']) {
                    case 4000001:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000001', f['answer']);
                      break;
                    case 4000002:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000002', f['answer']);
                      break;
                    case 4000003:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000003', f['answer']);
                      break;
                    case 4000004:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000004', f['answer']);
                      break;
                    case 4000005:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000005', f['answer']);
                      break;
                    case 4000006:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000006', f['answer']);
                      break;
                    case 4000007:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000007', f['answer']);
                      break;
                    case 4000008:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000008', f['answer']);
                      break;
                    case 4000010:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000010', f['answer']);
                      break;
                    case 4000013:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000013', f['answer']);
                      break;
                    case 4000014:
                      htmlText = htmlText.replaceAll(
                          '#clear_permit_4000014', f['answer']);
                      break;
                  }
                }
              }
              break;

            case 'cancel_permit':
              htmlText = htmlText.replaceAll(
                  '#3_comments', action['actionJson']['controlpersons']);
              htmlText = htmlText.replaceAll(
                  '#3_name', action['actionJson']['user_name']);
              htmlText = htmlText.replaceAll('#3_email', '');
              htmlText = htmlText.replaceAll('#3_phone', '');
              htmlText = htmlText.replaceAll(
                  '#3_sign', action['actionJson']['user_sign']);

              List dateTime = action['actionDateTime'].split(' ');
              String d5 = "${dateTime[0]}";
              String t5 = "${dateTime[1]}";

              htmlText = htmlText.replaceAll('#3_time', t5);
              htmlText = htmlText.replaceAll('#3_date', d5);
              break;

            case 'surrender_permit':
              if (action['actionJson']['surrender'].length > 0) {
                for (int j = 0;
                    j < action['actionJson']['surrender'].length;
                    j++) {
                  surrenderList.add(action['actionJson']['surrender'][j]);
                }
              }
              break;
            case 'transfer_permit':
              if (action['actionJson']['reciever'].length > 0) {
                for (int j = 0;
                    j < action['actionJson']['reciever'].length;
                    j++) {
                  receiverList.add(action['actionJson']['reciever'][j]);
                }
              }
              break;
          }
        }
      }

      htmlText = htmlText.replaceAll(
          '#methodstmt', offlinePermitData['html']['methodstmt']);
      htmlText = htmlText.replaceAll(
          '#description', offlinePermitData['html']['description']);

      if (offlinePermitData['html']['16_date'].length > 0) {
        htmlText = htmlText.replaceAll(
            '#16_comments', offlinePermitData['html']['16_comments']);
        htmlText = htmlText.replaceAll(
            '#16_name', offlinePermitData['html']['16_name']);
        htmlText = htmlText.replaceAll(
            '#16_email', (offlinePermitData['html']['16_email']) ?? '');
        htmlText = htmlText.replaceAll(
            '#16_phone', (offlinePermitData['html']['16_phone']) ?? '');
        htmlText = htmlText.replaceAll(
            '#16_sign', offlinePermitData['html']['16_sign']);
        htmlText = htmlText.replaceAll(
            '#16_time', offlinePermitData['html']['16_time']);
        htmlText = htmlText.replaceAll(
            '#16_date', offlinePermitData['html']['16_date']);
      } else {
        htmlText = htmlText.replaceAll('#16_comments', '');
        htmlText = htmlText.replaceAll('#16_name', '');
        htmlText = htmlText.replaceAll('#16_email', '');
        htmlText = htmlText.replaceAll('#16_phone', '');
        htmlText = htmlText.replaceAll('#16_sign', '');
        htmlText = htmlText.replaceAll('#16_time', '');
        htmlText = htmlText.replaceAll('#16_date', '');
      }
      if (offlinePermitData['html']['2_date'].length > 0) {
        htmlText =
            htmlText.replaceAll('#2_name', offlinePermitData['html']['2_name']);
        htmlText = htmlText.replaceAll(
            '#2_email', (offlinePermitData['html']['2_email']) ?? '');
        htmlText = htmlText.replaceAll(
            '#2_phone', offlinePermitData['html']['2_phone']);
        htmlText =
            htmlText.replaceAll('#2_sign', offlinePermitData['html']['2_sign']);
        htmlText =
            htmlText.replaceAll('#2_time', offlinePermitData['html']['2_time']);
        htmlText =
            htmlText.replaceAll('#2_date', offlinePermitData['html']['2_date']);
        htmlText = htmlText.replaceAll('#open_permit_3000001',
            offlinePermitData['html']['open_permit_3000001']);
        htmlText = htmlText.replaceAll('#open_permit_3000002',
            offlinePermitData['html']['open_permit_3000002']);
        htmlText = htmlText.replaceAll('#open_permit_3000003',
            offlinePermitData['html']['open_permit_3000003']);
        htmlText = htmlText.replaceAll('#open_permit_3000004',
            offlinePermitData['html']['open_permit_3000004']);
        htmlText = htmlText.replaceAll('#open_permit_3000005',
            offlinePermitData['html']['open_permit_3000005']);
        htmlText = htmlText.replaceAll('#open_permit_3000006',
            offlinePermitData['html']['open_permit_3000006']);
        htmlText = htmlText.replaceAll('#open_permit_3000007',
            offlinePermitData['html']['open_permit_3000007']);
        htmlText = htmlText.replaceAll('#open_permit_3000008',
            offlinePermitData['html']['open_permit_3000008']);
        htmlText = htmlText.replaceAll('#open_permit_3000009',
            offlinePermitData['html']['open_permit_3000009']);
        htmlText = htmlText.replaceAll('#open_permit_3000013',
            offlinePermitData['html']['open_permit_3000013']);
        htmlText = htmlText.replaceAll('#open_permit_3000014',
            (offlinePermitData['html']['open_permit_3000014']));
      } else {
        htmlText = htmlText.replaceAll('#2_name', '');
        htmlText = htmlText.replaceAll('#2_email', '');
        htmlText = htmlText.replaceAll('#2_phone', '');
        htmlText = htmlText.replaceAll('#2_sign', '');
        htmlText = htmlText.replaceAll('#2_time', '');
        htmlText = htmlText.replaceAll('#2_date', '');

        htmlText = htmlText.replaceAll('#open_permit_3000001', '');
        htmlText = htmlText.replaceAll('#open_permit_3000002', '');
        htmlText = htmlText.replaceAll('#open_permit_3000003', '');
        htmlText = htmlText.replaceAll('#open_permit_3000004', '');
        htmlText = htmlText.replaceAll('#open_permit_3000005', '');
        htmlText = htmlText.replaceAll('#open_permit_3000006', '');
        htmlText = htmlText.replaceAll('#open_permit_3000007', '');
        htmlText = htmlText.replaceAll('#open_permit_3000008', '');
        htmlText = htmlText.replaceAll('#open_permit_3000009', '');
        htmlText = htmlText.replaceAll('#open_permit_3000013', '');
        htmlText = htmlText.replaceAll('#open_permit_3000014', '');
      }

      if (offlinePermitData['html']['32_date'].length > 0) {
        htmlText = htmlText.replaceAll(
            '#32_name', offlinePermitData['html']['32_name']);
        htmlText = htmlText.replaceAll(
            '#32_authcode', (offlinePermitData['html']['32_authcode']) ?? '');
        htmlText = htmlText.replaceAll(
            '#32_company', (offlinePermitData['html']['32_company']) ?? '');
        htmlText = htmlText.replaceAll(
            '#32_email', (offlinePermitData['html']['32_email']) ?? '');
        htmlText = htmlText.replaceAll(
            '#32_phone', (offlinePermitData['html']['32_phone']) ?? '');
        htmlText = htmlText.replaceAll(
            '#32_sign', offlinePermitData['html']['32_sign']);
        htmlText = htmlText.replaceAll(
            '#32_time', offlinePermitData['html']['32_time']);
        htmlText = htmlText.replaceAll(
            '#32_date', offlinePermitData['html']['32_date']);
      } else {
        htmlText = htmlText.replaceAll('#32_name', '');
        htmlText = htmlText.replaceAll('#32_authcode', '');
        htmlText = htmlText.replaceAll('#32_company', '');
        htmlText = htmlText.replaceAll('#32_email', '');
        htmlText = htmlText.replaceAll('#32_phone', '');
        htmlText = htmlText.replaceAll('#32_sign', '');
        htmlText = htmlText.replaceAll('#32_time', '');
        htmlText = htmlText.replaceAll('#32_date', '');
      }

      if (offlinePermitData['html']['18_date'].length > 0) {
        htmlText = htmlText.replaceAll(
            '#18_comments', offlinePermitData['html']['18_comments']);
        htmlText = htmlText.replaceAll(
            '#18_name', offlinePermitData['html']['18_name']);
        htmlText = htmlText.replaceAll(
            '#18_email', (offlinePermitData['html']['18_email']) ?? '');
        htmlText = htmlText.replaceAll(
            '#18_phone', (offlinePermitData['html']['18_phone']) ?? '');
        htmlText = htmlText.replaceAll(
            '#18_sign', offlinePermitData['html']['18_sign']);
        htmlText = htmlText.replaceAll(
            '#18_time', offlinePermitData['html']['18_time']);
        htmlText = htmlText.replaceAll(
            '#18_date', offlinePermitData['html']['18_date']);
        htmlText = htmlText.replaceAll(
            '#18_authcode', offlinePermitData['html']['18_authcode']);

        htmlText = htmlText.replaceAll('#clear_permit_4000001',
            offlinePermitData['html']['clear_permit_4000001']);
        htmlText = htmlText.replaceAll('#clear_permit_4000002',
            offlinePermitData['html']['clear_permit_4000002']);
        htmlText = htmlText.replaceAll('#clear_permit_4000003',
            offlinePermitData['html']['clear_permit_4000003']);
        htmlText = htmlText.replaceAll('#clear_permit_4000004',
            offlinePermitData['html']['clear_permit_4000004']);
        htmlText = htmlText.replaceAll('#clear_permit_4000005',
            offlinePermitData['html']['clear_permit_4000005']);
        htmlText = htmlText.replaceAll('#clear_permit_4000006',
            offlinePermitData['html']['clear_permit_4000006']);
        htmlText = htmlText.replaceAll('#clear_permit_4000007',
            offlinePermitData['html']['clear_permit_4000007']);
        htmlText = htmlText.replaceAll('#clear_permit_4000008',
            offlinePermitData['html']['clear_permit_4000008']);
        htmlText = htmlText.replaceAll('#clear_permit_4000010',
            offlinePermitData['html']['clear_permit_4000010']);
        htmlText = htmlText.replaceAll('#clear_permit_4000013',
            offlinePermitData['html']['clear_permit_4000013']);
        htmlText = htmlText.replaceAll('#clear_permit_4000014',
            offlinePermitData['html']['clear_permit_4000014']);
      } else {
        htmlText = htmlText.replaceAll('#18_name', '');
        htmlText = htmlText.replaceAll('#18_email', '');
        htmlText = htmlText.replaceAll('#18_phone', '');
        htmlText = htmlText.replaceAll('#18_authcode', '');
        htmlText = htmlText.replaceAll('#18_sign', '');
        htmlText = htmlText.replaceAll('#18_time', '');
        htmlText = htmlText.replaceAll('#18_date', '');

        htmlText = htmlText.replaceAll('#clear_permit_4000001', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000002', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000003', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000004', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000005', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000006', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000007', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000008', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000010', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000013', '');
        htmlText = htmlText.replaceAll('#clear_permit_4000014', '');
      }

      if (offlinePermitData['html']['3_date'].length > 0) {
        htmlText = htmlText.replaceAll(
            '#3_comments', offlinePermitData['html']['3_comments']);
        htmlText =
            htmlText.replaceAll('#3_name', offlinePermitData['html']['3_name']);
        htmlText =
            htmlText.replaceAll('#3_sign', offlinePermitData['html']['3_sign']);
        htmlText =
            htmlText.replaceAll('#3_time', offlinePermitData['html']['3_time']);
        htmlText =
            htmlText.replaceAll('#3_date', offlinePermitData['html']['3_date']);
      } else {
        htmlText = htmlText.replaceAll('#3_comments', '');
        htmlText = htmlText.replaceAll('#3_name', '');
        htmlText = htmlText.replaceAll('#3_sign', '');
        htmlText = htmlText.replaceAll('#3_time', '');
        htmlText = htmlText.replaceAll('#3_date', '');
      }

      htmlText = htmlText.replaceAll(
          '#ptw_isolation', (offlinePermitData['html']['ptw_isolation'] ?? ''));
      htmlText = htmlText.replaceAll(
          '#ptw_circuit', (offlinePermitData['html']['ptw_circuit'] ?? ''));
      htmlText = htmlText.replaceAll(
          '#2ptw_circuit', (offlinePermitData['html']['ptw_circuit2'] ?? ''));
      htmlText = htmlText.replaceAll(
          '#ptw_safety', (offlinePermitData['html']['ptw_safety'] ?? ''));
      htmlText = htmlText.replaceAll('#ptw_precautions',
          (offlinePermitData['html']['ptw_precautions'] ?? ''));
      htmlText = htmlText.replaceAll('#2ptw_precautions',
          (offlinePermitData['html']['ptw_precautions2'] ?? ''));

      htmlText = htmlText.replaceAll(
          '#st_circuit', (offlinePermitData['html']['st_circuit'] ?? ''));
      htmlText = htmlText.replaceAll('#st_precautions',
          (offlinePermitData['html']['st_precautions'] ?? ''));
      htmlText = htmlText.replaceAll(
          '#st_safety', (offlinePermitData['html']['st_safety'] ?? ''));

      htmlText = htmlText.replaceAll(
          '#lwc_accessto', (offlinePermitData['html']['lwc_accessto'] ?? ''));
      htmlText = htmlText.replaceAll('#lwc_environment',
          (offlinePermitData['html']['lwc_environment'] ?? ''));
      htmlText = htmlText.replaceAll('#lwc_precautions',
          (offlinePermitData['html']['lwc_precautions'] ?? ''));
      int ind = 1;
      for (int sIndex = 0; sIndex < surrenderList.length; sIndex++) {
        htmlText = htmlText.replaceAll(
            "#201202_${ind}_name", surrenderList[sIndex]['npw_name']);
        htmlText = htmlText.replaceAll(
            "#201202_${ind}_authno", surrenderList[sIndex]['npw_auth']);
        htmlText = htmlText.replaceAll(
            "#201202_${ind}_date", surrenderList[sIndex]['date']);
        htmlText = htmlText.replaceAll(
            "#201202_${ind}_time", surrenderList[sIndex]['time']);
        htmlText = htmlText.replaceAll(
            "#201202_${ind}_npwsign", surrenderList[sIndex]['npw_sign']);
        ind = ind + 1;
      }

      for (int sIndex = 1; sIndex <= 4; sIndex++) {
        htmlText = htmlText.replaceAll("#201202_${sIndex}_name", '');
        htmlText = htmlText.replaceAll("#201202_${sIndex}_authno", '');
        htmlText = htmlText.replaceAll("#201202_${sIndex}_date", '');
        htmlText = htmlText.replaceAll("#201202_${sIndex}_time", '');
        htmlText = htmlText.replaceAll("#201202_${sIndex}_npwsign", '');
      }

      int ind2 = 1;
      for (int temp = 0; temp <= receiverList.length - 1; temp++) {
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_name", receiverList[temp]['npw_name']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_authno", receiverList[temp]['npw_auth']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_date", receiverList[temp]['date']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_time", receiverList[temp]['time']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_npwsign", receiverList[temp]['npw_sign']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_username", receiverList[temp]['user_name']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_usersign", receiverList[temp]['user_sign']);
        htmlText = htmlText.replaceAll("#203204_${ind2}_controlusername",
            receiverList[temp]['controlusername']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_company", receiverList[temp]['company']);

        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_date1", receiverList[temp]['date']);
        htmlText = htmlText.replaceAll(
            "#203204_${ind2}_time1", receiverList[temp]['time']);
        ind2 = ind2 + 1;
      }

      for (int rIndex = 1; rIndex <= 4; rIndex++) {
        htmlText = htmlText.replaceAll("#203204_${rIndex}_name", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_authno", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_date", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_time", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_npwsign", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_username", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_usersign", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_controlusername", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_company", '');

        htmlText = htmlText.replaceAll("#203204_${rIndex}_date1", '');
        htmlText = htmlText.replaceAll("#203204_${rIndex}_time1", '');
      }
      emit(OfflinePdfGenerated(htmlContent: htmlText));
    } catch (e) {
      emit(ErrorGeneratingPdfOffline(
          errorMessage: StringConstants.kPDFGenerationError));
    }
  }
}
