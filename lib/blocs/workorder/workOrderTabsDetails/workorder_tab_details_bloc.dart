import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/workorder/workorder_reposiotry.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/workorder/delete_document_model.dart';
import '../../../data/models/workorder/delete_item_tab_item_model.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../data/models/workorder/manage_misc_cost_model.dart';
import '../../../data/models/workorder/save_new_and_similar_workorder_model.dart';
import '../../../data/models/workorder/update_workorder_details_model.dart';
import 'workorder_tab_details_events.dart';
import 'workorder_tab_details_states.dart';

class WorkOrderTabDetailsBloc
    extends Bloc<WorkOrderTabsDetailsEvent, WorkOrderTabDetailsStates> {
  final WorkOrderRepository _workOrderRepository = getIt<WorkOrderRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

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
    on<WorkOrderSelectVendorOption>(_selectVendorOptions);
    on<WorkOrderSelectCurrencyOption>(_selectCurrencyOptions);
    on<ManageWorkOrderMiscCost>(_manageMiscCost);
  }

  int tabIndex = 0;
  int toggleSwitchIndex = 0;
  String clientId = '';
  static List popUpMenuItemsList = [];
  Map workOrderDetailsMap = {};

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
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('ShowRouts')
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

  _selectVendorOptions(WorkOrderSelectVendorOption event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderVendorOptionSelected(vendorName: event.vendorName));
  }

  _selectCurrencyOptions(WorkOrderSelectCurrencyOption event,
      Emitter<WorkOrderTabDetailsStates> emit) {
    emit(WorkOrderCurrencyOptionSelected(currencyName: event.currencyName));
  }

  FutureOr _manageMiscCost(ManageWorkOrderMiscCost event,
      Emitter<WorkOrderTabDetailsStates> emit) async {
    emit(ManagingWorkOrderMisCost());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.manageMisCostMap['service'] == null ||
          event.manageMisCostMap['vendor'] == null ||
          event.manageMisCostMap['quan'] == null ||
          event.manageMisCostMap['currency'] == null ||
          event.manageMisCostMap['amount'] == null) {
        emit(WorkOrderMisCostCannotManage(
            cannotManageMiscCost: StringConstants.kMiscCostValidation));
      } else {
        Map manageMiscCostMap = {
          "service": event.manageMisCostMap['service'] ?? '',
          "vendor": event.manageMisCostMap['vendor'] ?? '',
          "quan": event.manageMisCostMap['quan'] ?? '',
          "currency": event.manageMisCostMap['currency'] ?? '',
          "amount": event.manageMisCostMap['amount'] ?? '',
          "hashcode": hashCode,
          "woid": event.manageMisCostMap['workorderId'] ?? '',
          "id": ""
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
}
