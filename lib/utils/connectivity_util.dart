import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../blocs/wifiConnectivity/wifi_connectivity_events.dart';

class ConnectivityUtil {
  static final Connectivity _connectivity = Connectivity();
  static WifiConnectivityBloc? _wifiBloc;

  static void initialize() {
    _wifiBloc = WifiConnectivityBloc();
    observeNetwork();
  }

  static void observeNetwork() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final result =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        WifiConnectivityBloc().add(NotifyNetworkStatus(isConnected: false));
      } else {
        WifiConnectivityBloc().add(NotifyNetworkStatus(isConnected: true));
      }
    });
  }

  static void dispose() {
    _wifiBloc?.close();
    _wifiBloc = null;
  }
}
