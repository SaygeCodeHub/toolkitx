import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/location/location_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_locations_model.dart';
import '../../di/app_module.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = getIt<LocationRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List<LocationDatum> locationDatum = [];
  bool locationListReachedMax = false;
  String locationId = '';

  LocationBloc() : super(LocationInitial()) {
    on<FetchLocations>(_fetchLocations);
    on<FetchLocationDetails>(_fetchLocationDetails);
  }

  Future<void> _fetchLocations(
      FetchLocations event, Emitter<LocationState> emit) async {
    emit(FetchingLocations());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationsModel fetchLocationsModel = await _locationRepository
          .fetchLocations(event.pageNo, hashCode, '{}');
      locationListReachedMax = fetchLocationsModel.data.isEmpty;
      locationDatum.addAll(fetchLocationsModel.data);
      emit(LocationsFetched(
          locationDatum: locationDatum,
          locationListReachedMax: locationListReachedMax));
    } catch (e) {
      emit(LocationsCouldNotFetch(locationsNotFetched: e.toString()));
    }
  }

  Future<void> _fetchLocationDetails(
      FetchLocationDetails event, Emitter<LocationState> emit) async {
    emit(FetchingLocationDetails());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      locationId = event.locationId;
      FetchLocationDetailsModel fetchLocationDetailsModel =
          await _locationRepository.fetchLocationDetails(locationId, hashCode);
      if (fetchLocationDetailsModel.status == 200) {
        emit(LocationDetailsFetched(
            fetchLocationDetailsModel: fetchLocationDetailsModel,
            selectedTabIndex: event.selectedTabIndex,
            clientId: clientId));
      } else {
        emit(LocationDetailsNotFetched(
            detailsNotFetched: fetchLocationDetailsModel.message));
      }
    } catch (e) {
      emit(LocationDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }
}
