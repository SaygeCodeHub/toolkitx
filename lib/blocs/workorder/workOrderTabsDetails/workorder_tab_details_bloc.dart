import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/workorder/fetch_assign_parts_model.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/encrypt_class.dart';
import '../../../data/models/workorder/accpeet_workorder_model.dart';
import '../../../data/models/workorder/assign_workforce_model.dart';
import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/delete_workorder_single_misc_cost_model.dart';
import '../../../data/models/workorder/fetch_assign_workforce_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../data/models/workorder/fetch_workorder_documents_model.dart';
import '../../../data/models/workorder/fetch_workorder_misc_cost_model.dart';
import '../../../data/models/workorder/hold_workorder_model.dart';
import '../../../data/models/workorder/fetch_workorder_single_downtime_model.dart';
import '../../../data/models/workorder/manage_misc_cost_model.dart';
import '../../../data/models/workorder/manage_downtime_model.dart';
import '../../../data/models/workorder/reject_workorder_model.dart';
import '../../../data/models/workorder/save_new_and_similar_workorder_model.dart';
import '../../../data/models/workorder/save_workorder_documents_model.dart';
import '../../../data/models/workorder/start_workorder_model.dart';
import '../../../data/models/workorder/update_workorder_details_model.dart';
import '../../../data/models/workorder/workorder_edit_workforce_model.dart';
import '../../../data/models/workorder/workorder_save_comments_model.dart';
import '../../../screens/workorder/workorder_add_comments_screen.dart';
import '../../../screens/workorder/assign_workforce_screen.dart';
import '../../../screens/workorder/workorder_add_parts_screen.dart';
import '../../../screens/workorder/workorder_add_mis_cost_screen.dart';
import '../../../screens/workorder/workorder_assign_document_screen.dart';
import '../../../screens/workorder/workorder_details_tab_screen.dart';
import '../../../screens/workorder/workorder_add_and_edit_down_time_screen.dart';
import '../../../screens/workorder/workorder_edit_workforce_screen.dart';
import 'workorder_tab_details_events.dart';
import 'workorder_tab_details_states.dart';

class WorkOrderTabDetailsBloc
    extends Bloc<WorkOrderTabsDetailsEvent, WorkOrderTabDetailsStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  bool docListReachedMax = false;
  int pageNo = 1;
  String partName = '';
  String workOrderWorkforceName = '';
  String workOrderId = '';
  List<AddPartsDatum> addPartsDatum = [];

  WorkOrderTabDetailsStates get initialState => WorkOrderTabDetailsInitial();

  WorkOrderTabDetailsBloc() : super(WorkOrderTabDetailsInitial()) {
    on<WorkOrderDetails>(_fetchWorkOrderDetails);
    on<WorkOrderToggleSwitchIndex>(_toggleSwitchIndexChanged);
    on<SelectWorkOrderCompanyOptions>(_selectCompanyOptions);
    on<SelectWorkOrderLocationOptions>(_selectLocationOptions);
    on<SelectWorkOrderTypeOptions>(_selectTypeOptions);
    on<WorkOrderItemTabDeleteItem>(_deleteItemTabItem);
    on<WorkOrderDeleteDocument>(_deleteDocument);
    on<SelectWorkOrderPriorityOptions>(_selectPriorityOptions);
    on<SelectWorkOrderCategoryOptions>(_selectCategoryOptions);
    on<SelectWorkOrderOriginationOptions>(_selectOriginationOptions);
    on<SelectWorkOrderCostCenterOptions>(_selectCostCenterOptions);
    on<SaveSimilarAndNewWorkOrder>(_saveNewAndSimilarWorkOrder);
    on<UpdateWorkOrderDetails>(_updateWorkOrderDetails);
    on<SelectSafetyMeasureOptions>(_selectSafetyMeasuresOptions);
    on<SelectSpecialWorkOptions>(_selectSpecialWorkOptions);
    on<ManageWorkOrderDownTime>(_manageDownTime);
    on<WorkOrderSelectVendorOption>(_selectVendorOptions);
    on<WorkOrderSelectCurrencyOption>(_selectCurrencyOptions);
    on<ManageWorkOrderMiscCost>(_manageMiscCost);
    on<AcceptWorkOrder>(_acceptWorkOrder);
    on<HoldWorkOrder>(_holdWorkOrder);
    on<FetchWorkOrderSingleDownTime>(_fetchWorkOrderSingleDownTime);
    on<FetchAssignWorkForceList>(_fetchAssignWorkForce);
    on<FetchAssignPartsList>(_fetchAssignPartsList);
    on<RejectWorkOrder>(_rejectWorkOrder);
    on<StartWorkOrder>(_startWorkOrder);
    on<SearchWorkOrderParts>(_searchWorkOrderParts);
    on<SearchWorkOrderWorkforce>(_searchWorkOrderWorkforce);
    on<FetchWorkOrderDocuments>(_fetchWorkOrderDocuments);
    on<SelectWorkOrderDocument>(_selectWorkOrderDocuments);
    on<SelectWorkOrderDocumentType>(_selectWorkOrderDocumentType);
    on<SelectWorkOrderDocumentStatusOption>(_selectWorkOrderDocumentStatus);
    on<ApplyWorkOrderDocumentFilter>(_applyWorkOrderDocumentFilter);
    on<ClearWorkOrderDocumentFilter>(_clearWorkOrderDocumentFilter);
    on<FetchWorkOrderSingleMiscCost>(_fetchSingleMiscCost);
    on<DeleteWorkOrderSingleMiscCost>(_deleteSingleMiscCost);
    on<AssignWorkForce>(_assignWorkForce);
    on<EditWorkOrderWorkForce>(_editWorkForce);
    on<SaveWorkOrderComments>(_saveDocuments);
    on<SaveWorkOrderDocuments>(_saveWorkOrderDocuments);
  }

  int tabIndex = 0;
  int toggleSwitchIndex = 0;
  String clientId = '';
  static List popUpMenuItemsList = [];
  Map workOrderDetailsMap = {};
  bool assignWorkForceListReachedMax = false;
  List<AssignWorkForceDatum> assignWorkForceDatum = [];
  String docTypeId = '';
  List documentList = [];
  String currencyName = '';
  String vendorName = '';
  String misCostId = '';

  FutureOr _fetchWorkOrderDetails(
      WorkOrderDetails event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderTabDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? getClientId =
          await _customerCache.getClientId(CacheKeys.clientId);
      clientId = getClientId!;
      popUpMenuItemsList = [
        DatabaseUtil.getText('Edit'),
        DatabaseUtil.getText('CreateSimillar'),
        DatabaseUtil.getText('AddParts'),
        DatabaseUtil.getText('AddDocuments'),
        DatabaseUtil.getText('AddMiscCost'),
        DatabaseUtil.getText('AddDowntime'),
        DatabaseUtil.getText('AddComment')
      ];
      FetchWorkOrderTabDetailsModel fetchWorkOrderDetailsModel =
          await _workOrderRepository.fetchWorkOrderDetails(
              hashCode!, event.workOrderId);
      tabIndex = event.initialTabIndex;
      if (fetchWorkOrderDetailsModel.data.isassignedwf == '1') {
        popUpMenuItemsList.insert(2, DatabaseUtil.getText('assign_workforce'));
      }
      if (fetchWorkOrderDetailsModel.data.isstarttender == '1') {
        popUpMenuItemsList.insert(7, DatabaseUtil.getText('StartTender'));
      }
      if (fetchWorkOrderDetailsModel.data.isacceptreject == '1') {
        popUpMenuItemsList.insert(8, DatabaseUtil.getText('Accept'));
      }
      if (fetchWorkOrderDetailsModel.data.isacceptreject == '1') {
        popUpMenuItemsList.insert(9, DatabaseUtil.getText('Reject'));
      }
      if (fetchWorkOrderDetailsModel.data.isstart == '1') {
        popUpMenuItemsList.insert(8, DatabaseUtil.getText('Start'));
      }
      if (fetchWorkOrderDetailsModel.data.ishold == '1') {
        popUpMenuItemsList.insert(8, DatabaseUtil.getText('Hold'));
      }
      List customFieldList = [];
      for (int i = 0;
          i < fetchWorkOrderDetailsModel.data.customfields.length;
          i++) {
        customFieldList.add({
          'id': fetchWorkOrderDetailsModel.data.customfields[i].fieldid,
          'value': fetchWorkOrderDetailsModel.data.customfields[i].fieldvalue
        });
      }
      workOrderDetailsMap = {
        'companyid': fetchWorkOrderDetailsModel.data.companyid,
        'locationid': fetchWorkOrderDetailsModel.data.locationid,
        'locationnames': fetchWorkOrderDetailsModel.data.locationnames,
        'contractorname': fetchWorkOrderDetailsModel.data.contractorname,
        'type': fetchWorkOrderDetailsModel.data.type,
        'workordertype': fetchWorkOrderDetailsModel.data.workordertype,
        'priorityid': fetchWorkOrderDetailsModel.data.priorityid,
        'category': fetchWorkOrderDetailsModel.data.category,
        'categoryid': fetchWorkOrderDetailsModel.data.categoryid,
        'origination': fetchWorkOrderDetailsModel.data.origination,
        'originationid': fetchWorkOrderDetailsModel.data.originationid,
        'costcenterid': fetchWorkOrderDetailsModel.data.costcenterid,
        'costcenter': fetchWorkOrderDetailsModel.data.costcenter,
        'subject': fetchWorkOrderDetailsModel.data.subject,
        'description': fetchWorkOrderDetailsModel.data.description,
        'workorderId': fetchWorkOrderDetailsModel.data.id,
        'customfields': customFieldList,
        "plannedstartdate": fetchWorkOrderDetailsModel.data.plannedstartdate,
        "plannedstarttime": fetchWorkOrderDetailsModel.data.plannedstarttime,
        "plannedfinishdate": fetchWorkOrderDetailsModel.data.plannedfinishdate,
        "plannedfinishtime": fetchWorkOrderDetailsModel.data.plannedfinishtime,
        "measure": fetchWorkOrderDetailsModel.data.safetymeasure,
        "specialwork": fetchWorkOrderDetailsModel.data.specialwork,
        "specialworknames": fetchWorkOrderDetailsModel.data.specialworknames,
        "measurenames": fetchWorkOrderDetailsModel.data.safetymeasurenames,
        "service": fetchWorkOrderDetailsModel.data.service,
        "vendor": fetchWorkOrderDetailsModel.data.vendorname,
        "quan": fetchWorkOrderDetailsModel.data.quan.toString(),
      };
      emit(WorkOrderTabDetailsFetched(
          fetchWorkOrderDetailsModel: fetchWorkOrderDetailsModel,
          tabInitialIndex: tabIndex,
          clientId: clientId,
          popUpMenuList: popUpMenuItemsList,
          workOrderDetailsMap: workOrderDetailsMap));
      add(WorkOrderToggleSwitchIndex(
          fetchWorkOrderDetailsModel: fetchWorkOrderDetailsModel,
          tabInitialIndex: tabIndex,
          toggleIndex: 0));
    } catch (e) {
      emit(WorkOrderTabDetailsNotFetched(tabDetailsNotFetched: e.toString()));
    }
  }

  _toggleSwitchIndexChanged(WorkOrderToggleSwitchIndex event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    toggleSwitchIndex = event.toggleIndex;
    emit(WorkOrderTabDetailsFetched(
        tabInitialIndex: event.tabInitialIndex,
        fetchWorkOrderDetailsModel: event.fetchWorkOrderDetailsModel,
        clientId: clientId,
        popUpMenuList: popUpMenuItemsList,
        workOrderDetailsMap: workOrderDetailsMap));
  }

  _selectCompanyOptions(SelectWorkOrderCompanyOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCompanyOptionSelected(
        companyId: event.companyId, companyName: event.companyName));
  }

  _selectLocationOptions(SelectWorkOrderLocationOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderLocationOptionSelected(
        locationId: event.locationId, locationName: event.locationName));
  }

  _selectTypeOptions(SelectWorkOrderTypeOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderTypeOptionSelected(
        typeId: event.typeId, typeName: event.typeName));
  }

  FutureOr _deleteItemTabItem(WorkOrderItemTabDeleteItem event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(DeletingItemTabItem());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map deleteItemTabItemMap = {
        'woitemid': event.itemId,
        'userid': userId,
        'hashcode': hashCode
      };
      DeleteItemTabItemModel deleteItemTabItemModel =
          await _workOrderRepository.deleteItemTabItem(deleteItemTabItemMap);
      if (deleteItemTabItemModel.status == 200) {
        emit(
            ItemTabItemDeleted(deleteItemTabItemModel: deleteItemTabItemModel));
      } else {
        emit(ItemTabItemNotDeleted(
            cannotDeleteItem: deleteItemTabItemModel.message));
      }
    } catch (e) {
      emit(ItemTabItemNotDeleted(cannotDeleteItem: e.toString()));
    }
  }

  FutureOr _deleteDocument(WorkOrderDeleteDocument event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(DeletingDocument());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map deleteDocumentMap = {
        'wodocid': event.docId,
        'userid': userId,
        'hashcode': hashCode
      };
      DeleteDocumentModel deleteDocumentModel =
          await _workOrderRepository.deleteDocument(deleteDocumentMap);
      if (deleteDocumentModel.status == 200) {
        emit(DocumentDeleted(deleteDocumentModel: deleteDocumentModel));
      } else {
        emit(DocumentNotDeleted(
            documentNotDeleted: deleteDocumentModel.message));
      }
    } catch (e) {
      emit(DocumentNotDeleted(documentNotDeleted: e.toString()));
    }
  }

  _selectPriorityOptions(SelectWorkOrderPriorityOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderPriorityOptionSelected(
        priorityId: event.priorityId, priorityValue: event.priorityValue));
  }

  _selectCategoryOptions(SelectWorkOrderCategoryOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCategoryOptionSelected(
        categoryId: event.categoryId, categoryName: event.categoryName));
  }

  _selectOriginationOptions(SelectWorkOrderOriginationOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCategoryOriginationSelected(
        originationId: event.originationId,
        originationName: event.originationName));
  }

  _selectCostCenterOptions(SelectWorkOrderCostCenterOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCategoryCostCenterSelected(
        costCenterId: event.costCenterId,
        costCenterValue: event.costCenterValue));
  }

  FutureOr _saveNewAndSimilarWorkOrder(SaveSimilarAndNewWorkOrder event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(SavingNewAndSimilarWorkOrder());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveNewAndSimilarWorkOrderMap = {
        "companyid": event.workOrderDetailsMap['companyid'] ?? '',
        "locationid": event.workOrderDetailsMap['locationid'] ?? '',
        "priorityid": event.workOrderDetailsMap['priorityid'] ?? '',
        "categoryid": event.workOrderDetailsMap['categoryid'] ?? '',
        "type": event.workOrderDetailsMap['type'] ?? '',
        "subject": event.workOrderDetailsMap['subject'] ?? '',
        "description": event.workOrderDetailsMap['description'] ?? '',
        "specialtyid": event.workOrderDetailsMap['specialtyid'] ?? '',
        "plannedstartdate": event.workOrderDetailsMap['plannedstartdate'] ?? '',
        "plannedstarttime": event.workOrderDetailsMap['plannedstarttime'] ?? '',
        "plannedfinishdate":
            event.workOrderDetailsMap['plannedfinishdate'] ?? '',
        "plannedfinishtime":
            event.workOrderDetailsMap['plannedfinishtime'] ?? '',
        "otherlocation": event.workOrderDetailsMap['otherlocation'] ?? '',
        "customfields": event.workOrderDetailsMap['customfields'] ?? '',
        "originationid": event.workOrderDetailsMap['originationid'] ?? '',
        "costcenterid": event.workOrderDetailsMap['costcenterid'] ?? '',
        "oldworkorderid": event.workOrderDetailsMap['workorderId'] ?? '',
        "userid": userId,
        "hashcode": hashCode
      };
      SaveNewAndSimilarWorkOrderModel saveNewAndSimilarWorkOrderModel =
          await _workOrderRepository
              .saveNewAndSimilarWorkOrder(saveNewAndSimilarWorkOrderMap);
      if (saveNewAndSimilarWorkOrderModel.status == 200) {
        emit(NewAndSimilarWorkOrderSaved(
            saveNewAndSimilarWorkOrderModel: saveNewAndSimilarWorkOrderModel));
      } else {
        emit(NewAndSimilarWorkOrderNotSaved(
            workOrderNotSaved:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(NewAndSimilarWorkOrderNotSaved(workOrderNotSaved: e.toString()));
    }
  }

  FutureOr _updateWorkOrderDetails(UpdateWorkOrderDetails event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(UpdatingWorkOrderDetails());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map updateWorkOrderDetailsMap = {
        "idm": '',
        "id": event.updateWorkOrderDetailsMap['workorderId'] ?? '',
        "companyid": event.updateWorkOrderDetailsMap['companyid'] ?? '',
        "locationid": event.updateWorkOrderDetailsMap['locationid'] ?? '',
        "priorityid": event.updateWorkOrderDetailsMap['priorityid'] ?? '',
        "categoryid": event.updateWorkOrderDetailsMap['categoryid'] ?? '',
        "type": event.updateWorkOrderDetailsMap['type'] ?? '',
        "subject": event.updateWorkOrderDetailsMap['subject'] ?? '',
        "description": event.updateWorkOrderDetailsMap['description'] ?? '',
        "specialtyid": event.updateWorkOrderDetailsMap['specialtyid'] ?? '',
        "plannedstartdate":
            event.updateWorkOrderDetailsMap['plannedstartdate'] ?? '',
        "plannedstarttime":
            event.updateWorkOrderDetailsMap['plannedstarttime'] ?? '',
        "plannedfinishdate":
            event.updateWorkOrderDetailsMap['plannedfinishdate'] ?? '',
        "plannedfinishtime":
            event.updateWorkOrderDetailsMap['plannedfinishtime'] ?? '',
        "otherlocation": event.updateWorkOrderDetailsMap['otherlocation'] ?? '',
        "customfields": event.updateWorkOrderDetailsMap['customfields'] ?? '',
        "originationid": event.updateWorkOrderDetailsMap['originationid'] ?? '',
        "costcenterid": event.updateWorkOrderDetailsMap['costcenterid'] ?? '',
        "steps": event.updateWorkOrderDetailsMap['steps'] ?? '',
        "measure": event.updateWorkOrderDetailsMap['measure'] ?? '',
        "specialwork": event.updateWorkOrderDetailsMap['specialwork'] ?? '',
        "userid": userId,
        "hashcode": hashCode
      };
      UpdateWorkOrderDetailsModel updateWorkOrderDetailsModel =
          await _workOrderRepository
              .updateWorkOrderDetails(updateWorkOrderDetailsMap);
      if (updateWorkOrderDetailsModel.status == 200) {
        emit(WorkOrderDetailsUpdated(
            updateWorkOrderDetailsModel: updateWorkOrderDetailsModel));
      } else {
        emit(WorkOrderDetailsCouldNotUpdate(
            detailsNotFetched:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkOrderDetailsCouldNotUpdate(detailsNotFetched: e.toString()));
    }
  }

  _selectSafetyMeasuresOptions(SelectSafetyMeasureOptions event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    List idsList = List.from(event.safetyMeasureIdList);
    List namesList = List.from(event.safetyMeasureNameList);
    if (event.safetyMeasureId.isNotEmpty) {
      if (event.safetyMeasureIdList.contains(event.safetyMeasureId)) {
        idsList.remove(event.safetyMeasureId);
        namesList.remove(event.safetyMeasureName);
      } else {
        idsList.add(event.safetyMeasureId);
        namesList.add(event.safetyMeasureName);
      }
    }
    emit(SafetyMeasuresOptionsSelected(
        safetyMeasureIdList: idsList, safetyMeasureNameList: namesList));
  }

  _selectSpecialWorkOptions(
      SelectSpecialWorkOptions event, Emitter<WorkOrderTabDetailsStates> emit) {
    List idsList = List.from(event.specialWorkIdList);
    List namesList = List.from(event.specialWorkNameList);
    if (event.specialWorkId.isNotEmpty) {
      if (event.specialWorkIdList.contains(event.specialWorkId)) {
        idsList.remove(event.specialWorkId);
        namesList.remove(event.specialWorkName);
      } else {
        idsList.add(event.specialWorkId);
        namesList.add(event.specialWorkName);
      }
    }
    emit(SpecialWorkOptionsSelected(
        specialWorkIdList: idsList, specialWorkNameList: namesList));
  }

  FutureOr _manageDownTime(ManageWorkOrderDownTime event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(ManagingWorkOrderDownTime());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.manageDownTimeMap['startdate'] == null ||
          event.manageDownTimeMap['enddate'] == null) {
        emit(WorkOrderDownTimeCannotManage(
            downTimeCannotManage: DatabaseUtil.getText('TimeDateValidate')));
      } else if (DateFormat('dd.MM.yyyy')
              .parse(event.manageDownTimeMap['startdate'])
              .compareTo(DateFormat('dd.MM.yyyy')
                  .parse(event.manageDownTimeMap['enddate'])) >
          0) {
        emit(WorkOrderDownTimeCannotManage(
            downTimeCannotManage: DatabaseUtil.getText('shouldbegreater')));
      } else {
        Map manageDownTimeMap = {
          "startdate": event.manageDownTimeMap['startdate'] ?? '',
          "starttime": event.manageDownTimeMap['starttime'] ?? '',
          "enddate": event.manageDownTimeMap['enddate'] ?? '',
          "endtime": event.manageDownTimeMap['endtime'] ?? '',
          "notes": event.manageDownTimeMap['notes'] ?? '',
          "hashcode": hashCode,
          "woid": event.manageDownTimeMap['workorderId'] ?? '',
          "id": event.manageDownTimeMap['downTimeId'] ?? ''
        };
        ManageWorkOrderDownTimeModel manageWorkOrderDownTimeModel =
            await _workOrderRepository.manageDownTime(manageDownTimeMap);
        if (manageWorkOrderDownTimeModel.status == 200) {
          emit(WorkOrderDownTimeManaged(
              manageWorkOrderDownTimeModel: manageWorkOrderDownTimeModel));
        } else {
          emit(WorkOrderDownTimeCannotManage(
              downTimeCannotManage:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(WorkOrderDownTimeCannotManage(downTimeCannotManage: e.toString()));
    }
  }

  _selectVendorOptions(WorkOrderSelectVendorOption event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    if (WorkOrderAddMisCostScreen.workOrderDetailsMap['vendor'] == null &&
        WorkOrderAddMisCostScreen.isFromEdit == true) {
      for (int i = 0;
          i < WorkOrderAddMisCostScreen.workOrderMasterDatum[8].length;
          i++) {
        if (WorkOrderAddMisCostScreen.workOrderMasterDatum[8][i].id
            .toString()
            .contains(
                WorkOrderAddMisCostScreen.singleMiscCostDatum[0].vendor)) {
          vendorName =
              WorkOrderAddMisCostScreen.workOrderMasterDatum[8][i].name;
        }
      }
    } else {
      vendorName = event.vendorName;
    }
    emit(WorkOrderVendorOptionSelected(vendorName: vendorName));
  }

  _selectCurrencyOptions(WorkOrderSelectCurrencyOption event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    if (WorkOrderAddMisCostScreen.workOrderDetailsMap['currency'] == null &&
        WorkOrderAddMisCostScreen.isFromEdit == true) {
      for (int i = 0;
          i < WorkOrderAddMisCostScreen.workOrderMasterDatum[7].length;
          i++) {
        if (WorkOrderAddMisCostScreen.workOrderMasterDatum[7][i].id
            .toString()
            .contains(
                WorkOrderAddMisCostScreen.singleMiscCostDatum[0].currency)) {
          currencyName =
              WorkOrderAddMisCostScreen.workOrderMasterDatum[7][i].currency;
        }
      }
    } else {
      currencyName = event.currencyName;
    }
    emit(WorkOrderCurrencyOptionSelected(currencyName: currencyName));
  }

  FutureOr _manageMiscCost(ManageWorkOrderMiscCost event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(ManagingWorkOrderMisCost());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.manageMisCostMap['service'] == null ||
          WorkOrderAddMisCostScreen.singleMiscCostDatum[0].vendor == '' ||
          event.manageMisCostMap['quan'] == null ||
          WorkOrderAddMisCostScreen.singleMiscCostDatum[0].currency == '' ||
          event.manageMisCostMap['amount'] == null) {
        emit(WorkOrderMisCostCannotManage(
            cannotManageMiscCost: StringConstants.kMiscCostValidation));
      } else {
        Map manageMiscCostMap = {
          "service": event.manageMisCostMap['service'] ?? '',
          "vendor": event.manageMisCostMap['vendor'] ??
              WorkOrderAddMisCostScreen.singleMiscCostDatum[0].vendor,
          "quan": event.manageMisCostMap['quan'] ?? '',
          "currency": event.manageMisCostMap['currency'] ??
              WorkOrderAddMisCostScreen.singleMiscCostDatum[0].currency,
          "amount": event.manageMisCostMap['amount'] ?? '',
          "hashcode": hashCode,
          "woid": event.manageMisCostMap['workorderId'] ?? '',
          "id": WorkOrderAddMisCostScreen.workOrderDetailsMap['misCostId'] ?? ''
        };
        ManageWorkOrderMiscCostModel manageWorkOrderMiscCostModel =
            await _workOrderRepository.manageMiscCost(manageMiscCostMap);
        if (manageWorkOrderMiscCostModel.status == 200) {
          emit(WorkOrderMisCostManaged(
              manageWorkOrderMiscCostModel: manageWorkOrderMiscCostModel));
        } else {
          emit(WorkOrderMisCostCannotManage(
              cannotManageMiscCost:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(WorkOrderMisCostCannotManage(cannotManageMiscCost: e.toString()));
    }
  }

  FutureOr _acceptWorkOrder(
      AcceptWorkOrder event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(AcceptingWorkOrder());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map acceptWorkOrderMap = {
        "woid": event.workOrderId,
        "userid": userId,
        "hashcode": hashCode
      };
      AcceptWorkOrderModel acceptWorkOrderModel =
          await _workOrderRepository.acceptWorkOrder(acceptWorkOrderMap);
      if (acceptWorkOrderModel.status == 200) {
        emit(WorkOrderAccepted(acceptWorkOrderModel: acceptWorkOrderModel));
      } else {
        emit(WorkOrderNotAccepted(
            workOrderNotAccepted:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkOrderNotAccepted(workOrderNotAccepted: e.toString()));
    }
  }

  FutureOr _holdWorkOrder(
      HoldWorkOrder event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(WorkOrderGettingOnHold());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map holdWorkOrderMap = {
        "woid": event.workOrderId,
        "userid": userId,
        "hashcode": hashCode
      };
      HoldWorkOrderModel holdWorkOrderModel =
          await _workOrderRepository.holdWorkOrder(holdWorkOrderMap);
      if (holdWorkOrderModel.status == 200) {
        emit(WorkOrderGotOnHold(holdWorkOrderModel: holdWorkOrderModel));
      } else {
        emit(WorkOrderCannotHold(
            workOrderCannotHold:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkOrderCannotHold(workOrderCannotHold: e.toString()));
    }
  }

  FutureOr _fetchWorkOrderSingleDownTime(FetchWorkOrderSingleDownTime event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderSingleDownTime());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchWorkOrderSingleDownTimeModel fetchWorkOrderSingleDownTimeModel =
          await _workOrderRepository.fetchWorkOrderSingleDownTime(
              hashCode!, event.downTimeId);
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['startdate'] =
          fetchWorkOrderSingleDownTimeModel.data.startdate;
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['starttime'] =
          fetchWorkOrderSingleDownTimeModel.data.starttime;
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['enddate'] =
          fetchWorkOrderSingleDownTimeModel.data.enddate;
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['endtime'] =
          fetchWorkOrderSingleDownTimeModel.data.endtime;
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['notes'] =
          fetchWorkOrderSingleDownTimeModel.data.notes;
      WorkOrderAddAndEditDownTimeScreen.addAndEditDownTimeMap['downTimeId'] =
          fetchWorkOrderSingleDownTimeModel.data.id;
      emit(WorkOrderSingleDownTimeFetched());
    } catch (e) {
      emit(WorkOrderTabDetailsNotFetched(tabDetailsNotFetched: e.toString()));
    }
  }

  FutureOr _fetchAssignWorkForce(FetchAssignWorkForceList event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingAssignWorkOrder());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (!assignWorkForceListReachedMax) {
        FetchAssignWorkForceModel fetchAssignWorkForceModel =
            await _workOrderRepository.fetchAssignWorkForce(
                event.pageNo,
                hashCode!,
                WorkOrderDetailsTabScreen.workOrderMap['workOrderId'],
                event.workOrderWorkforceName);
        pageNo = event.pageNo;
        workOrderWorkforceName = event.workOrderWorkforceName;
        assignWorkForceDatum.addAll(fetchAssignWorkForceModel.data);
        assignWorkForceListReachedMax = fetchAssignWorkForceModel.data.isEmpty;
        emit(AssignWorkOrderFetched(
            fetchAssignWorkForceModel: fetchAssignWorkForceModel));
      }
    } catch (e) {
      emit(AssignWorkOrderNotFetched(workOrderNotAssigned: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchAssignPartsList(FetchAssignPartsList event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingAssignParts());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (!docListReachedMax) {
        FetchAssignPartsModel fetchAssignPartsModel =
            await _workOrderRepository.fetchAssignPartsModel(
                event.pageNo, hashCode!, event.workOrderId, event.partName);
        pageNo = event.pageNo;
        workOrderId = event.workOrderId;
        partName = event.partName;
        addPartsDatum.addAll(fetchAssignPartsModel.data);
        docListReachedMax = fetchAssignPartsModel.data.isEmpty;
        emit(AssignPartsFetched(fetchAssignPartsModel: fetchAssignPartsModel));
      }
    } catch (e) {
      emit(AssignPartsNotFetched(partsNotAssigned: e.toString()));
    }
  }

  FutureOr _rejectWorkOrder(
      RejectWorkOrder event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(RejectingWorkOrder());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map rejectWorkOrderMap = {
        "woid": event.workOrderId,
        "userid": userId,
        "hashcode": hashCode
      };
      RejectWorkOrderModel rejectWorkOrderModel =
          await _workOrderRepository.rejectWorkOrder(rejectWorkOrderMap);
      if (rejectWorkOrderModel.status == 200) {
        emit(WorkOrderRejected(rejectWorkOrderModel: rejectWorkOrderModel));
      } else {
        emit(WorkOrderNotRejected(
            workOrderNotRejected:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkOrderNotRejected(workOrderNotRejected: e.toString()));
    }
  }

  Future<FutureOr<void>> _assignWorkForce(
      AssignWorkForce event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(AssigningWorkForce());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map assignWorkForceMap = {
        "hashcode": hashCode,
        "woid": event.assignWorkOrderMap['workorderId'] ?? '',
        "peopleid": event.assignWorkOrderMap['peopleid'] ?? '',
        "userid": userId,
        "hrs": event.assignWorkOrderMap['hrs'] ?? '',
        "showswwarning": event.showWarningCount
      };
      AssignWorkOrderModel assignWorkOrderModel =
          await _workOrderRepository.assignWorkForce(assignWorkForceMap);
      if (assignWorkOrderModel.status == 200) {
        emit(WorkForceAssigned(assignWorkOrderModel: assignWorkOrderModel));
      } else if (assignWorkOrderModel.status == 300) {
        emit(WorkForceNotAssigned(
            workForceNotFetched: assignWorkOrderModel.message));
      } else {
        emit(WorkForceNotAssigned(
            workForceNotFetched:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(WorkForceNotAssigned(workForceNotFetched: e.toString()));
    }
  }

  FutureOr _startWorkOrder(
      StartWorkOrder event, Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(StartingWorkOder());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (event.startWorkOrderMap['date'] == null ||
          event.startWorkOrderMap['time'] == null) {
        emit(WorkOderNotStarted(
            workOrderNotStarted: DatabaseUtil.getText('InsertDateTime')));
      } else {
        Map startWorkOrderMap = {
          "woid": event.startWorkOrderMap['workorderId'],
          "userid": userId,
          "date": event.startWorkOrderMap['date'],
          "time": event.startWorkOrderMap['time'],
          "comments": event.startWorkOrderMap['comments'],
          "hashcode": hashCode
        };
        StartWorkOrderModel startWorkOrderModel =
            await _workOrderRepository.startWorkOrder(startWorkOrderMap);
        if (startWorkOrderModel.status == 200) {
          emit(WorkOderStarted(startWorkOrderModel: startWorkOrderModel));
        } else {
          emit(WorkOderNotStarted(
              workOrderNotStarted:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(WorkOderNotStarted(workOrderNotStarted: e.toString()));
    }
  }

  FutureOr<void> _searchWorkOrderParts(
      SearchWorkOrderParts event, Emitter<WorkOrderTabDetailsStates> emit) {
    if (event.isSearched == true) {
      emit(WorkOrderAddPartsListSearched(isSearched: event.isSearched));
      add(FetchAssignPartsList(
          pageNo: 1, partName: partName, workOrderId: workOrderId));
    } else {
      emit(WorkOrderAddPartsListSearched(isSearched: event.isSearched));
      WorkOrderAddPartsScreen.nameController.clear();
      add(FetchAssignPartsList(
          pageNo: 1, partName: '', workOrderId: workOrderId));
    }
  }

  FutureOr<void> _searchWorkOrderWorkforce(
      SearchWorkOrderWorkforce event, Emitter<WorkOrderTabDetailsStates> emit) {
    if (event.isWorkforceSearched == true) {
      emit(WorkOrderAssignWorkforceSearched(
          isWorkforceSearched: event.isWorkforceSearched));
      add(FetchAssignWorkForceList(
        pageNo: 1,
        workOrderWorkforceName: workOrderWorkforceName,
        workOrderId: workOrderId,
      ));
    } else {
      emit(WorkOrderAssignWorkforceSearched(
          isWorkforceSearched: event.isWorkforceSearched));
      AssignWorkForceScreen.workforceNameController.clear();
      assignWorkForceListReachedMax = false;
      add(FetchAssignWorkForceList(
          pageNo: 1, workOrderWorkforceName: '', workOrderId: workOrderId));
    }
  }

  FutureOr _fetchWorkOrderDocuments(FetchWorkOrderDocuments event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderDocuments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchWorkOrderDocumentsModel fetchWorkOrderDocumentsModel =
          await _workOrderRepository.fetchWorkOrderDocuments(
              1,
              hashCode!,
              WorkOrderDetailsTabScreen.workOrderMap['workOrderId'],
              '',
              jsonEncode(WorkOrderAssignDocumentScreen.documentFilterMap));
      emit(WorkOrderDocumentsFetched(
          fetchWorkOrderDocumentsModel: fetchWorkOrderDocumentsModel,
          documentList: [],
          filterMap: WorkOrderAssignDocumentScreen.documentFilterMap));
      add(SelectWorkOrderDocument(
          fetchWorkOrderDocumentsModel: fetchWorkOrderDocumentsModel,
          docId: '',
          documentList: []));
    } catch (e) {
      emit(WorkOderNotStarted(workOrderNotStarted: e.toString()));
    }
  }

  _selectWorkOrderDocuments(
      SelectWorkOrderDocument event, Emitter<WorkOrderTabDetailsStates> emit) {
    List selectedDocumentList = List.from(event.documentList);
    if (event.docId != '') {
      if (event.documentList.contains(event.docId) != true) {
        selectedDocumentList.add(event.docId);
      } else {
        selectedDocumentList.remove(event.docId);
      }
    }
    documentList = selectedDocumentList;
    emit(WorkOrderDocumentsFetched(
        documentList: documentList,
        fetchWorkOrderDocumentsModel: event.fetchWorkOrderDocumentsModel,
        filterMap: WorkOrderAssignDocumentScreen.documentFilterMap));
  }

  _selectWorkOrderDocumentType(SelectWorkOrderDocumentType event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    docTypeId = event.docTypeId;
    emit(WorkOrderDocumentTypeSelected(
        docTypeId: event.docTypeId, docTypeName: event.docTypeName));
  }

  _selectWorkOrderDocumentStatus(SelectWorkOrderDocumentStatusOption event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderDocumentStatusSelected(
        statusId: event.statusId, statusOption: event.statusOption));
  }

  _applyWorkOrderDocumentFilter(ApplyWorkOrderDocumentFilter event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderDocumentFilterApplied());
  }

  _clearWorkOrderDocumentFilter(ClearWorkOrderDocumentFilter event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    WorkOrderAssignDocumentScreen.documentFilterMap.clear();
  }

  FutureOr _saveWorkOrderDocuments(SaveWorkOrderDocuments event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(SavingWorkOrderDocuments());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    Map saveDocumentsMap = {
      "hashcode": hashCode,
      "woid": WorkOrderDetailsTabScreen.workOrderMap['workOrderId'],
      "documents":
          WorkOrderAssignDocumentScreen.workOrderDocumentMap['documents'] ?? '',
      "userid": userId
    };
    SaveWorkOrderDocumentsModel saveWorkOrderDocumentsModel =
        await _workOrderRepository.saveDocuments(saveDocumentsMap);
    if (saveWorkOrderDocumentsModel.status == 200) {
      emit(WorkOrderDocumentsSaved(
          saveWorkOrderDocuments: saveWorkOrderDocumentsModel));
    } else {
      emit(WorkOrderDocumentsNotSaved(
          documentsNotSaved:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr _fetchSingleMiscCost(FetchWorkOrderSingleMiscCost event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(FetchingWorkOrderSingleMiscCost());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchWorkOrderSingleMiscCostModel fetchWorkOrderSingleMiscCostModel =
          await _workOrderRepository.fetchWorkOrderSingleMiscCost(hashCode!,
              WorkOrderAddMisCostScreen.workOrderDetailsMap['misCostId']);
      WorkOrderAddMisCostScreen.workOrderDetailsMap['misCostId'] =
          fetchWorkOrderSingleMiscCostModel.data.id;
      WorkOrderAddMisCostScreen.workOrderDetailsMap['service'] =
          fetchWorkOrderSingleMiscCostModel.data.service;
      WorkOrderAddMisCostScreen.workOrderDetailsMap['amount'] =
          fetchWorkOrderSingleMiscCostModel.data.amount;
      WorkOrderAddMisCostScreen.workOrderDetailsMap['quan'] =
          fetchWorkOrderSingleMiscCostModel.data.quan;
      emit(SingleWorkOrderMiscCostFetched(
          fetchWorkOrderSingleMiscCostModel:
              fetchWorkOrderSingleMiscCostModel));
    } catch (e) {
      emit(SingleWorkOrderMiscCostNotFetched(miscCostNotFetched: e.toString()));
    }
  }

  FutureOr<void> _saveDocuments(SaveWorkOrderComments event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(SavingWorkOrderComments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (WorkOrderAddCommentsScreen.addCommentsMap['comments'] == null) {
        emit(WorkOrderCommentsNotSaved(
            commentsNotSaved: DatabaseUtil.getText('ValidComments')));
      } else {
        Map saveWorkOrderCommentsMap = {
          "userid": userId,
          "workorderid":
              WorkOrderAddCommentsScreen.addCommentsMap['workorderId'] ?? '',
          "hashcode": hashCode,
          "comments":
              WorkOrderAddCommentsScreen.addCommentsMap['comments'] ?? ''
        };
        SaveWorkOrderCommentsModel saveWorkOrderCommentsModel =
            await _workOrderRepository
                .saveWorkOrderComments(saveWorkOrderCommentsMap);
        if (saveWorkOrderCommentsModel.status == 200) {
          emit(WorkOrderCommentsSaved(
              saveWorkOrderCommentsModel: saveWorkOrderCommentsModel));
        } else {
          emit(WorkOrderCommentsNotSaved(
              commentsNotSaved:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(WorkOrderCommentsNotSaved(commentsNotSaved: e.toString()));
    }
  }

  FutureOr _deleteSingleMiscCost(DeleteWorkOrderSingleMiscCost event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(DeletingWorkOrderSingleMiscCost());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map deleteSingleMiscCostMap = {
        "misccostid": misCostId,
        "userid": userId,
        "hashcode": hashCode
      };
      DeleteWorkOrderSingleMiscCostModel deleteWorkOrderSingleMiscCostModel =
          await _workOrderRepository
              .deleteWorkOrderSingleMiscCost(deleteSingleMiscCostMap);
      if (deleteWorkOrderSingleMiscCostModel.status == 200) {
        emit(WorkOrderSingleMiscCostDeleted(
            deleteWorkOrderSingleMiscCostModel:
                deleteWorkOrderSingleMiscCostModel));
      } else {
        emit(WorkOrderSingleMiscCostNotDeleted(
            miscCostNotDeleted: deleteWorkOrderSingleMiscCostModel.message));
      }
    } catch (e) {
      emit(ItemTabItemNotDeleted(cannotDeleteItem: e.toString()));
    }
  }

  FutureOr _editWorkForce(EditWorkOrderWorkForce event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(EditingWorkOrderWorkForce());
    String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
    String? userId = await _customerCache.getUserId(CacheKeys.userId);
    String? apiKey = await _customerCache.getApiKey(CacheKeys.apiKey);
    try {
      if (WorkOrderEditWorkForceScreen
                  .editWorkOrderWorkForceMap['plannedhrs'] ==
              null ||
          WorkOrderEditWorkForceScreen
                  .editWorkOrderWorkForceMap['plannedhrs'].isEmpty &&
              WorkOrderEditWorkForceScreen
                      .editWorkOrderWorkForceMap['actualhrs'] ==
                  null) {
        emit(WorkOrderWorkForceNotEdited(
            workForceNotEdited:
                DatabaseUtil.getText('ValidPlannedActualHours')));
      } else {
        String decryptedWorkForceId = EncryptData.decryptAESPrivateKey(
            WorkOrderEditWorkForceScreen
                .editWorkOrderWorkForceMap['workForceId'],
            apiKey);
        Map editWorkForceMap = {
          "workorderid": WorkOrderEditWorkForceScreen
                  .editWorkOrderWorkForceMap['workorderId'] ??
              '',
          "workforceid": decryptedWorkForceId,
          "plannedhrs": WorkOrderEditWorkForceScreen
                  .editWorkOrderWorkForceMap['plannedhrs'] ??
              '',
          "actualhrs": WorkOrderEditWorkForceScreen
                  .editWorkOrderWorkForceMap['actualhrs'] ??
              '',
          "userid": userId,
          "hashcode": hashCode
        };
        EditWorkOrderWorkForceModel editWorkOrderWorkForceModel =
            await _workOrderRepository.editWorkForce(editWorkForceMap);
        if (editWorkOrderWorkForceModel.status == 200) {
          emit(WorkOrderWorkForceEdited(
              editWorkOrderWorkForceModel: editWorkOrderWorkForceModel));
        } else {
          emit(WorkOrderWorkForceNotEdited(
              workForceNotEdited:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(WorkOrderWorkForceNotEdited(workForceNotEdited: e.toString()));
    }
  }
}
