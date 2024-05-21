import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../blocs/wifiConnectivity/wifi_connectivity_events.dart';

class ConnectivityUtil {
  static WifiConnectivityBloc? _wifiBloc;

  static void initialize() {
    _wifiBloc = WifiConnectivityBloc();
    observeNetwork();
  }

  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      // Iterate through each result in the list
      for (var result in results) {
        if (result == ConnectivityResult.none) {
          WifiConnectivityBloc().add(NotifyNetworkStatus());
        } else {
          WifiConnectivityBloc().add(NotifyNetworkStatus(isConnected: true));
        }
      }
    });
  }

  static void dispose() {
    _wifiBloc?.close();
    _wifiBloc = null;
  }
}
