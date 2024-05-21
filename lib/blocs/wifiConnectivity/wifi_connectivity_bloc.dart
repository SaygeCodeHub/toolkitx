import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'package:toolkit/utils/connectivity_util.dart';
import 'package:toolkit/utils/global.dart';

import '../../data/models/currentLocation/current_location.dart';
import '../../di/app_module.dart';
import '../../repositories/root/root_repository.dart';

class WifiConnectivityBloc
    extends Bloc<WifiConnectivityEvent, WifiConnectivityState> {
  bool isLocationPermissionDenied = false;
  bool locationPermissionDeniedForever = false;
  final RootRepository _rootRepository = getIt<RootRepository>();

  WifiConnectivityBloc._() : super(EstablishingNetwork()) {
    on<ObserveNetwork>(_observeNetwork);
    on<NotifyNetworkStatus>(_notifyNetworkStatus);
    on<ObserveUserLocation>(_observeUserLocation);
  }

  static final WifiConnectivityBloc _instance = WifiConnectivityBloc._();

  factory WifiConnectivityBloc() => _instance;

  void _observeNetwork(event, emit) {
    ConnectivityUtil.observeNetwork();
  }

  FutureOr<void> _notifyNetworkStatus(NotifyNetworkStatus event, emit) {
    isNetworkEstablished = event.isConnected;
    event.isConnected ? emit(EstablishedNetwork()) : emit(NoNetwork());
  }

  FutureOr<void> _observeUserLocation(
      ObserveUserLocation event, Emitter<WifiConnectivityState> emit) async {
    try {
      if (isLocationPermissionDenied == false ||
          locationPermissionDeniedForever == false) {
        await _initialiseLocationService();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _initialiseLocationService() async {
    try {
      final position = await _getLocation();
      Future.delayed(const Duration(seconds: 5));
      updateCurrentLocation(position.latitude, position.longitude);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCurrentLocation(latitude, longitude) async {
    CurrentLocationUpdateModel currentLocationUpdateModel =
        await _rootRepository.updateCurrentLocation(latitude, longitude);
    debugPrint(currentLocationUpdateModel.toString());
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        locationPermissionDeniedForever = true;
        throw Exception('Location permissions are permanently denied');
      } else if (permission == LocationPermission.denied) {
        isLocationPermissionDenied = true;
        throw Exception('Location permissions are denied');
      }
    }
    return Geolocator.getCurrentPosition();
  }
}
