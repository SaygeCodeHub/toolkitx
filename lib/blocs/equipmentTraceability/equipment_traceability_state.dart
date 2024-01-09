part of 'equipment_traceability_bloc.dart';

abstract class EquipmentTraceabilityState {}

class EquipmentTraceabilityInitial extends EquipmentTraceabilityState {}

class SearchEquipmentListFetching extends EquipmentTraceabilityState {}

class SearchEquipmentListFetched extends EquipmentTraceabilityState {
  final List<SearchEquipmentDatum> data;
  final Map filtersMap;

  SearchEquipmentListFetched({required this.data, required this.filtersMap});
}

class SearchEquipmentListNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  SearchEquipmentListNotFetched({required this.errorMessage});
}

class EquipmentSetParameterFetching extends EquipmentTraceabilityState {}

class EquipmentSetParameterFetched extends EquipmentTraceabilityState {
  final FetchEquipmentSetParameterModel fetchEquipmentSetParameterModel;

  EquipmentSetParameterFetched({required this.fetchEquipmentSetParameterModel});
}

class EquipmentSetParameterNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentSetParameterNotFetched({required this.errorMessage});
}

class SearchEquipmentDetailsFetching extends EquipmentTraceabilityState {}

class SearchEquipmentDetailsFetched extends EquipmentTraceabilityState {
  final FetchSearchEquipmentDetailsModel fetchSearchEquipmentDetailsModel;
  final List popUpMenuItems;
  final bool showPopMenu;
  final String clientId;

  SearchEquipmentDetailsFetched(
      {required this.popUpMenuItems,
      required this.showPopMenu,
      required this.fetchSearchEquipmentDetailsModel,
      required this.clientId});
}

class SearchEquipmentDetailsNotFetched extends EquipmentTraceabilityState {
  final String errorMessage;

  SearchEquipmentDetailsNotFetched({required this.errorMessage});
}

class EquipmentImageSaving extends EquipmentTraceabilityState {}

class EquipmentImageSaved extends EquipmentTraceabilityState {
  final SaveEquipmentImagesModel saveEquipmentImagesModel;

  EquipmentImageSaved({required this.saveEquipmentImagesModel});
}

class EquipmentImageNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentImageNotSaved({required this.errorMessage});
}

class CustomParameterSaving extends EquipmentTraceabilityState {}

class CustomParameterSaved extends EquipmentTraceabilityState {}

class CustomParameterNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  CustomParameterNotSaved({required this.errorMessage});
}

class EquipmentLocationSaving extends EquipmentTraceabilityState {}

class EquipmentLocationSaved extends EquipmentTraceabilityState {}

class EquipmentLocationNotSaved extends EquipmentTraceabilityState {
  final String errorMessage;

  EquipmentLocationNotSaved({required this.errorMessage});
}
