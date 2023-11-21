import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/repositories/location/location_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/location/fetch_location_details_model.dart';
import '../../data/models/location/fetch_location_logbooks_model.dart';
import '../../data/models/location/fetch_location_loto_model.dart';
import '../../data/models/location/fetch_location_permits_model.dart';
import '../../data/models/location/fetch_locations_model.dart';
import '../../di/app_module.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = getIt<LocationRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List<LocationDatum> locationDatum = [];
  bool locationListReachedMax = false;
  List<LocationPermitsDatum> locationPermits = [];
  bool locationPermitListReachedMax = false;
  List<LocationLotoDatum> locationLoTos = [];
  bool locationLoToListReachedMax = false;
  List<LocationLogBooksDatum> locationLogBooks = [];
  bool locationLogBooksListReachedMax = false;
  String locationId = '';

  LocationBloc() : super(LocationInitial()) {
    on<FetchLocations>(_fetchLocations);
    on<FetchLocationDetails>(_fetchLocationDetails);
    on<FetchLocationPermits>(_fetchLocationPermits);
    on<FetchLocationLoTo>(_fetchLocationLoTo);
    on<FetchLocationLogBooks>(_fetchLocationLogBooks);
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

  Future<void> _fetchLocationPermits(
      FetchLocationPermits event, Emitter<LocationState> emit) async {
    emit(FetchingLocationPermits());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchLocationPermitsModel fetchLocationPermitsModel =
          await _locationRepository.fetchLocationPermits(
              event.pageNo, hashCode, '{}', locationId);
      locationPermitListReachedMax = fetchLocationPermitsModel.data.isEmpty;
      locationPermits.addAll(fetchLocationPermitsModel.data);
      if (locationPermits.isNotEmpty) {
        emit(LocationPermitsFetched(
            locationPermits: locationPermits,
            locationPermitListReachedMax: locationPermitListReachedMax));
      } else {
        emit(LocationPermitsNotFetched(
            permitsNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(LocationPermitsNotFetched(permitsNotFetched: e.toString()));
    }
  }

  Future<void> _fetchLocationLoTo(
      FetchLocationLoTo event, Emitter<LocationState> emit) async {
    emit(FetchingLocationLoTo());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchLocationLoToModel fetchLocationLoToModel = await _locationRepository
          .fetchLocationLoTo(event.pageNo, hashCode, userId, '{}', locationId);
      locationLoToListReachedMax = fetchLocationLoToModel.data.isEmpty;
      locationLoTos.addAll(fetchLocationLoToModel.data);
      if (locationPermits.isNotEmpty) {
        emit(LocationLoToFetched(
            locationLoTos: locationLoTos,
            locationLoToListReachedMax: locationPermitListReachedMax));
      } else {
        emit(LocationLoToNotFetched(
            loToNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(LocationLoToNotFetched(loToNotFetched: e.toString()));
    }
  }

  Future<void> _fetchLocationLogBooks(
      FetchLocationLogBooks event, Emitter<LocationState> emit) async {
    emit(FetchingLocationLogBooks());
    try {
      String hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchLocationLogBookModel fetchLocationLogBookModel =
          await _locationRepository.fetchLocationLogBooks(
              event.pageNo, hashCode, userId, '{}', locationId);
      locationLogBooksListReachedMax = fetchLocationLogBookModel.data.isEmpty;
      locationLogBooks.addAll(fetchLocationLogBookModel.data);
      if (locationLogBooks.isNotEmpty) {
        emit(LocationLogBooksFetched(
            locationLogBooksListReachedMax: locationLogBooksListReachedMax,
            locationLogBooks: locationLogBooks));
      } else {
        emit(LocationLogBooksNotFetched(
            logBooksNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(LocationLogBooksNotFetched(logBooksNotFetched: e.toString()));
    }
  }
}
