import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'package:toolkit/utils/connectivity_util.dart';

class WifiConnectivityBloc
    extends Bloc<WifiConnectivityEvent, WifiConnectivityState> {
  WifiConnectivityBloc._() : super(EstablishingNetwork()) {
    on<ObserveNetwork>(_observeNetwork);
    on<NotifyNetworkStatus>(_notifyNetworkStatus);
    on<ObserveUserLocation>(_observeUserLocation);
  }

  late StreamSubscription _positionStreamSubscription;
  static final WifiConnectivityBloc _instance = WifiConnectivityBloc._();

  factory WifiConnectivityBloc() => _instance;

  void _observeNetwork(event, emit) {
    ConnectivityUtil.observeNetwork();
  }

  void _notifyNetworkStatus(NotifyNetworkStatus event, emit) {
    event.isConnected ? emit(EstablishedNetwork()) : emit(NoNetwork());
  }

  void _initLocationService() {
    _getLocation().then((position) {
      // Do something with the position data
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    });

    // Repeat fetching location every 5 minutes
    const duration = Duration(minutes: 5);
    _positionStreamSubscription =
        Stream.periodic(duration).listen((_) => _getLocation());
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location service is not enabled, handle accordingly
      return Future.error('Location service disabled');
    }

    // Request permission to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get current position
    return Geolocator.getCurrentPosition();
  }

  // Fetch location
  void fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      print(
          'Background Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  FutureOr<void> _observeUserLocation(
      ObserveUserLocation event, Emitter<WifiConnectivityState> emit) async {
    try {
      BackgroundFetch.configure(
          BackgroundFetchConfig(
              minimumFetchInterval: 5,
              // Fetch interval in minutes
              stopOnTerminate: false,
              enableHeadless: true,
              startOnBoot: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false), (String taskId) async {
        // This is the fetch callback
        print("[BackgroundFetch] TaskId: $taskId");
        fetchLocation();
        BackgroundFetch.finish(taskId);
      }).then((int status) {
        print('[BackgroundFetch] configure success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] configure ERROR: $e');
      });

      // Start background fetch
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });

      // Start foreground location updates
      _initLocationService();
    } catch (e) {
      print('location error $e');
      rethrow;
    }
  }
}
