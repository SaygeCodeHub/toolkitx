import '../../../../data/models/checklist/systemUser/sys_user_change_category_model.dart';

abstract class SysUserFetchCheckListEvent {}

class FetchCheckList extends SysUserFetchCheckListEvent {
  final bool isFromHome;
  final int page;

  FetchCheckList({required this.page, this.isFromHome = false});
}

class FetchCheckListMaster extends SysUserFetchCheckListEvent {}

class ChangeCheckListCategory extends SysUserFetchCheckListEvent {
  final List<GetFilterCategoryData> getFilterCategoryData;
  final String categoryName;
  final String categoryId;

  ChangeCheckListCategory(
      {required this.categoryId,
      required this.getFilterCategoryData,
      required this.categoryName});
}

class FilterChecklist extends SysUserFetchCheckListEvent {
  final Map filterChecklistMap;

  FilterChecklist({required this.filterChecklistMap});
}

class ClearCheckListFilter extends SysUserFetchCheckListEvent {}
