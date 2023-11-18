import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/location/location_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/location/fetch_locations_model.dart';
import '../../di/app_module.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = getIt<LocationRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List<LocationDatum> locationDatum = [];
  bool locationListReachedMax = false;

  LocationBloc() : super(LocationInitial()) {
    on<FetchLocations>(_fetchLocations);
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
}
