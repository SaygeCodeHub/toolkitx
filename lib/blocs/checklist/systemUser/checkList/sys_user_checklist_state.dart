import 'package:equatable/equatable.dart';

import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';

abstract class SysUserCheckListStates extends Equatable {}

class CheckListInitial extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class FetchingCheckList extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class CheckListFetched extends SysUserCheckListStates {
  final ChecklistListModel getChecklistModel;
  final String filterData;

  CheckListFetched({required this.filterData, required this.getChecklistModel});

  @override
  List<Object?> get props => [];
}

class CheckListError extends SysUserCheckListStates {
  final String errorMessage;

  CheckListError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FetchingCheckListCategory extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class CheckListCategoryFetched extends SysUserCheckListStates {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  CheckListCategoryFetched(
      {required this.categoryId,
      required this.categoryName,
      required this.getFilterCategoryData});

  @override
  List<Object?> get props => [getFilterCategoryData, categoryName, categoryId];
}

class CheckListCategoryNotFetched extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class SavingFilterData extends SysUserCheckListStates {
  @override
  List<Object?> get props => [];
}

class SavedCheckListFilterData extends SysUserCheckListStates {
  final Map saveFilterData;

  SavedCheckListFilterData({required this.saveFilterData});

  @override
  List<Object?> get props => [saveFilterData];
}

class CheckListFilterDataNotSaved extends SysUserCheckListStates {
  final String errorMessage;

  CheckListFilterDataNotSaved({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FilterDataCleared extends SysUserCheckListStates {
  final String filterCleared;

  FilterDataCleared({required this.filterCleared});

  @override
  List<Object?> get props => [filterCleared];
}
