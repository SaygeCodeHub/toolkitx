abstract class LocationEvent {}

class FetchLocations extends LocationEvent {
  final int pageNo;
  final bool isFromHome;

  FetchLocations({required this.isFromHome, required this.pageNo});
}

class FetchLocationDetails extends LocationEvent {
  final String locationId;
  final int selectedTabIndex;

  FetchLocationDetails(
      {required this.selectedTabIndex, required this.locationId});
}

class FetchLocationPermits extends LocationEvent {
  final int pageNo;

  FetchLocationPermits({required this.pageNo});
}

class FetchLocationLoTo extends LocationEvent {
  final int pageNo;

  FetchLocationLoTo({required this.pageNo});
}

class FetchLocationWorkOrders extends LocationEvent {
  final int pageNo;

  FetchLocationWorkOrders({required this.pageNo});
}

class FetchCheckListsLocation extends LocationEvent {
  FetchCheckListsLocation();
}

class FetchLocationAssets extends LocationEvent {
  final int pageNo;

  FetchLocationAssets({required this.pageNo});
}

class FetchLocationLogBooks extends LocationEvent {
  final int pageNo;

  FetchLocationLogBooks({required this.pageNo});
}

class ClearLoToListFilter extends LocationEvent {}

class ApplyLoToListFilter extends LocationEvent {
  final Map filterMap;

  ApplyLoToListFilter({required this.filterMap});
}

class ApplyWorkOrderListFilter extends LocationEvent {
  final Map filterMap;

  ApplyWorkOrderListFilter({required this.filterMap});
}

class ApplyLogBookListFilter extends LocationEvent {
  final Map filterMap;

  ApplyLogBookListFilter({required this.filterMap});
}

class ApplyAssetsListFilter extends LocationEvent {
  final Map filterMap;

  ApplyAssetsListFilter({required this.filterMap});
}

class ApplyPermitListFilter extends LocationEvent {
  final Map filterMap;

  ApplyPermitListFilter({required this.filterMap});
}

class ApplyCheckListFilter extends LocationEvent {
  final Map filterMap;

  ApplyCheckListFilter({required this.filterMap});
}

class ApplyLocationFilter extends LocationEvent {
  final Map filterMap;

  ApplyLocationFilter({required this.filterMap});
}

class SelectLocationType extends LocationEvent {
  final Map locationTypeMap;

  SelectLocationType({required this.locationTypeMap});
}
