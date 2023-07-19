import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../../../data/cache/cache_keys.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../../../../utils/database_utils.dart';

class SysUserCheckListBloc
    extends Bloc<SysUserFetchCheckListEvent, SysUserCheckListStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String checklistId = '';
  String categoryId = '';
  String filterData = '{}';

  SysUserCheckListStates get initialState => CheckListInitial();

  SysUserCheckListBloc() : super(CheckListInitial()) {
    on<FetchCheckList>(_fetchList);
    on<FetchCheckListMaster>(_fetchCategory);
    on<ChangeCheckListCategory>(_changeCategory);
    on<FilterChecklist>(_filterChecklist);
    on<ClearCheckListFilter>(_clearFilter);
  }

  FutureOr<void> _fetchList(
      FetchCheckList event, Emitter<SysUserCheckListStates> emit) async {
    emit(FetchingCheckList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.isFromHome != true) {
        ChecklistListModel getChecklistModel = await _sysUserCheckListRepository
            .fetchCheckList(event.page, hashCode, filterData);
        emit(CheckListFetched(
            getChecklistModel: getChecklistModel, filterData: filterData));
      } else {
        add(ClearCheckListFilter());
        ChecklistListModel getChecklistModel = await _sysUserCheckListRepository
            .fetchCheckList(event.page, hashCode, '{}');
        emit(CheckListFetched(
            getChecklistModel: getChecklistModel, filterData: '{}'));
      }
    } catch (e) {
      emit(CheckListError(
          errorMessage:
              DatabaseUtil.getText('some_unknown_error_please_try_again')));
    }
  }

  FutureOr<void> _fetchCategory(
      FetchCheckListMaster event, Emitter<SysUserCheckListStates> emit) async {
    emit(FetchingCheckListCategory());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      GetCheckListFilterCategoryModel getFilterCategoryModel =
          await _sysUserCheckListRepository.fetchCheckListCategory(
              hashCode, userId);
      if (getFilterCategoryModel.status == 200 &&
          getFilterCategoryModel.data!.isNotEmpty) {
        add(ChangeCheckListCategory(
            getFilterCategoryData: getFilterCategoryModel.data![0],
            categoryName: '',
            categoryId: ''));
      } else {
        emit(CheckListCategoryNotFetched());
      }
    } catch (e) {
      emit(CheckListCategoryNotFetched());
    }
  }

  FutureOr<void> _changeCategory(ChangeCheckListCategory event,
      Emitter<SysUserCheckListStates> emit) async {
    categoryId = event.categoryId;
    emit(CheckListCategoryFetched(
        categoryName: event.categoryName,
        getFilterCategoryData: event.getFilterCategoryData,
        categoryId: event.categoryId));
  }

  _filterChecklist(
      FilterChecklist event, Emitter<SysUserCheckListStates> emit) {
    emit(SavingFilterData());
    try {
      filterData = jsonEncode(event.filterChecklistMap);
      emit(SavedCheckListFilterData(saveFilterData: event.filterChecklistMap));
    } catch (e) {
      emit(CheckListFilterDataNotSaved(errorMessage: e.toString()));
    }
  }

  _clearFilter(
      ClearCheckListFilter event, Emitter<SysUserCheckListStates> emit) async {
    filterData = '{}';
  }
}
