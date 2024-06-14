import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_passengers_crew_list_model.dart';
import 'package:toolkit/data/models/trips/fetch_trip_special_request_model.dart';
import 'package:toolkit/data/models/trips/fetch_trips_list_model.dart';
import 'package:toolkit/data/models/trips/trip_add_special_request_model.dart';
import 'package:toolkit/data/models/trips/update_trip_special_request_model.dart';
import 'package:toolkit/repositories/trips/trips_repository.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/trips/fetch_trip_details_model.dart';
import '../../di/app_module.dart';
import '../../utils/database_utils.dart';

part 'trip_event.dart';

part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripsRepository _tripsRepository = getIt<TripsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TripState get initialState => TripInitial();

  TripBloc() : super(TripInitial()) {
    on<FetchTripsList>(_fetchTripsList);
    on<FetchTripsDetails>(_fetchTripsDetails);
    on<FetchTripMaster>(_fetchTripMaster);
    on<SelectTripStatusFilter>(_selectTripStatusFilter);
    on<SelectTripVesselFilter>(_selectTripVesselFilter);
    on<ApplyTripFilter>(_applyTripFilter);
    on<ClearTripFilter>(_clearTripFilter);
    on<FetchPassengerCrewList>(_fetchPassengerCrewList);
    on<TripAddSpecialRequest>(_tripAddSpecialRequest);
    on<FetchTripSpecialRequest>(_fetchTripSpecialRequest);
    on<UpdateTripSpecialRequest>(_updateTripSpecialRequest);
  }

  int tripTabIndex = 0;

  bool hasReachedMax = false;
  List<TripDatum> tripDatum = [];
  Map filters = {};
  String vesselName = '';
  List<PassengerCrewDatum> passengerCrewDatum = [];
  List<MasterDatum> masterDatumSecondList = [];

  Future<FutureOr<void>> _fetchTripsList(
      FetchTripsList event, Emitter<TripState> emit) async {
    emit(TripsListFetching());
    try {
      if (event.isFromHome) {
        String? hashCode =
            await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
        String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
        FetchTripsListModel fetchTripsListModel = await _tripsRepository
            .fetchTripsList(event.pageNo, hashCode, "{}", userId);
        tripDatum.addAll((fetchTripsListModel.data));
        hasReachedMax = fetchTripsListModel.data.isEmpty;
        emit(TripsListFetched(
            fetchTripsListModel: fetchTripsListModel,
            tripDatum: tripDatum,
            filterMap: {}));
      } else {
        String? hashCode =
            await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
        String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
        FetchTripsListModel fetchTripsListModel =
            await _tripsRepository.fetchTripsList(
                event.pageNo, hashCode, jsonEncode(filters), userId);
        tripDatum.addAll((fetchTripsListModel.data));
        hasReachedMax = fetchTripsListModel.data.isEmpty;
        emit(TripsListFetched(
            fetchTripsListModel: fetchTripsListModel,
            tripDatum: tripDatum,
            filterMap: filters));
      }
    } catch (e) {
      emit(TripsListNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTripsDetails(
      FetchTripsDetails event, Emitter<TripState> emit) async {
    tripTabIndex = event.tripTabIndex;
    emit(TripDetailsFetching());
    List popUpMenuItemsList = [
      DatabaseUtil.getText('Cancel'),
    ];

    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      String? clientId =
          await _customerCache.getClientId(CacheKeys.clientId) ?? '';

      FetchTripDetailsModel fetchTripDetailsModel = await _tripsRepository
          .fetchTripDetails(event.tripId, hashCode, userId);

      if (fetchTripDetailsModel.data.canaddspecialrequest == '1') {
        popUpMenuItemsList.insert(
          0,
          StringConstants.kAddSpecialRequest,
        );
      }

      if (fetchTripDetailsModel.status == 200) {
        emit(TripDetailsFetched(
            fetchTripDetailsModel: fetchTripDetailsModel,
            clientId: clientId,
            showPopUpMenu: true,
            tripPopUpMenuList: popUpMenuItemsList));
      } else {
        emit(
            TripDetailsNotFetched(errorMessage: fetchTripDetailsModel.message));
      }
    } catch (e) {
      emit(TripDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTripStatusFilter(
      SelectTripStatusFilter event, Emitter<TripState> emit) {
    emit(TripsStatusFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  Future<FutureOr<void>> _fetchTripMaster(
      FetchTripMaster event, Emitter<TripState> emit) async {
    emit(TripsListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTripMasterModel fetchTripMasterModel =
          await _tripsRepository.fetchTripMaster(hashCode);
      if (fetchTripMasterModel.status == 200) {
        masterDatumSecondList = fetchTripMasterModel.data[1];
        emit(TripMasterFetched(fetchTripMasterModel: fetchTripMasterModel));
      } else {
        emit(TripMasterNotFetched(errorMessage: fetchTripMasterModel.message));
      }
    } catch (e) {
      emit(TripMasterNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTripVesselFilter(
      SelectTripVesselFilter event, Emitter<TripState> emit) {
    emit(TripsVesselFilterSelected(selectVessel: event.selectVessel));
  }

  FutureOr<void> _applyTripFilter(
      ApplyTripFilter event, Emitter<TripState> emit) {
    filters = event.tripFilterMap;
  }

  FutureOr<void> _clearTripFilter(
      ClearTripFilter event, Emitter<TripState> emit) {
    filters = {};
  }

  Future<FutureOr<void>> _fetchPassengerCrewList(
      FetchPassengerCrewList event, Emitter<TripState> emit) async {
    emit(PassengerCrewListFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      FetchTripPassengersCrewListModel fetchTripPassengersCrewListModel =
          await _tripsRepository.fetchTripPassengersCrewList(
              hashCode, event.tripId);
      if (fetchTripPassengersCrewListModel.status == 200) {
        passengerCrewDatum = fetchTripPassengersCrewListModel.data;
        emit(PassengerCrewListFetched(
            fetchTripPassengersCrewListModel:
                fetchTripPassengersCrewListModel));
      } else {
        emit(PassengerCrewListNotFetched(
            errorMessage: fetchTripPassengersCrewListModel.message));
      }
    } catch (e) {
      emit(PassengerCrewListNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _tripAddSpecialRequest(
      TripAddSpecialRequest event, Emitter<TripState> emit) async {
    emit(TripSpecialRequestAdding());
    try {
      Map addSpecialRequestMap = {
        "tripid": event.tripId,
        "userid": await _customerCache.getUserId(CacheKeys.userId) ?? '',
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
        "createdfor": event.addSpecialRequestMap['createdfor'],
        "specialrequest": event.addSpecialRequestMap['specialrequest'],
        "specialrequesttype": event.addSpecialRequestMap['specialrequesttype']
      };
      TripAddSpecialRequestModel tripAddSpecialRequestModel =
          await _tripsRepository.tripAddSpecialRequest(addSpecialRequestMap);
      if (tripAddSpecialRequestModel.status == 200) {
        emit(TripSpecialRequestAdded());
      } else {
        emit(TripSpecialRequestNotAdded(
            errorMessage: tripAddSpecialRequestModel.message));
      }
    } catch (e) {
      emit(TripSpecialRequestNotAdded(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTripSpecialRequest(
      FetchTripSpecialRequest event, Emitter<TripState> emit) async {
    emit(TripSpecialRequestFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';

      await _addEventAndWait(
          () => add(FetchPassengerCrewList(tripId: event.tripId)),
          PassengerCrewListFetched,
          stream);
      await _addEventAndWait(
          () => add(FetchTripMaster()), TripMasterFetched, stream);

      if (passengerCrewDatum.isNotEmpty && masterDatumSecondList.isNotEmpty) {
        FetchTripSpecialRequestModel fetchTripSpecialRequestModel =
            await _tripsRepository.fetchTripSpecialRequest(
                hashCode, event.requestId, event.tripId);
        if (fetchTripSpecialRequestModel.status == 200) {
          emit(TripSpecialRequestFetched(
              fetchTripSpecialRequestModel: fetchTripSpecialRequestModel,
              passengerCrewDatum: passengerCrewDatum,
              masterDatum: masterDatumSecondList));
        } else {
          emit(TripSpecialRequestNotFetched(
              errorMessage: fetchTripSpecialRequestModel.message));
        }
      } else {
        emit(TripSpecialRequestNotFetched(
            errorMessage: StringConstants.kSomethingWentWrong));
      }
    } catch (e) {
      emit(TripSpecialRequestNotFetched(errorMessage: e.toString()));
    }
  }

  Future<void> _addEventAndWait<T extends TripState>(
      Function() addEvent, Type stateType, Stream<TripState> stream) async {
    addEvent();
    await for (final state in stream) {
      if (state.runtimeType == stateType) break;
    }
  }

  Future<FutureOr<void>> _updateTripSpecialRequest(
      UpdateTripSpecialRequest event, Emitter<TripState> emit) async {
    emit(TripSpecialRequestUpdating());
    try {
      Map updateSpecialRequestMap = {
        "id": event.requestId,
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode) ?? '',
        "createdfor": event.updateSpecialRequestMap['createdfor'],
        "specialrequest": event.updateSpecialRequestMap['specialrequest']
      };
      UpdateTripSpecialRequestModel updateTripSpecialRequestModel =
          await _tripsRepository
              .updateTripSpecialRequest(updateSpecialRequestMap);
      if (updateTripSpecialRequestModel.status == 200) {
        emit(TripSpecialRequestUpdated());
      } else {
        emit(TripSpecialRequestNotUpdated(
            errorMessage: updateTripSpecialRequestModel.message));
      }
    } catch (e) {
      emit(TripSpecialRequestNotUpdated(errorMessage: e.toString()));
    }
  }
}
