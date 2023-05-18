import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../blocs/wifiConnectivity/wifi_connectivity_events.dart';

class ConnectivityUtil {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        WifiConnectivityBloc().add(NotifyNetworkStatus());
      } else {
        WifiConnectivityBloc().add(NotifyNetworkStatus(isConnected: true));
      }
    });
  }
}
