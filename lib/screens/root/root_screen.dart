import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/all_chats_screen.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/screens/notification/notification_screen.dart';

import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_states.dart';
import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../di/app_module.dart';
import '../../utils/database/database_util.dart';
import '../../utils/global.dart';
import '../home/home_screen.dart';
import '../location/current_location_screen.dart';
import '../profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = 'RootScreen';
  final bool isFromClientList;
  static bool onceCall = true;

  const RootScreen({super.key, required this.isFromClientList});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();

  @override
  void initState() {
    widget.isFromClientList == true ? _selectedIndex = 0 : null;
    _getCurrentUserLocation();
    // widget.isFromClientList == true ? _selectedIndex = 0 : null;
    super.initState();
    if (widget.isFromClientList) {
      _selectedIndex = 0;
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); // Unregister the observer
  }

  void _getCurrentUserLocation() {
    if (!context.read<WifiConnectivityBloc>().isLocationPermissionDenied ||
        !context.read<WifiConnectivityBloc>().locationPermissionDeniedForever) {
      Timer.periodic(const Duration(minutes: 5), (Timer timer) {
        context.read<WifiConnectivityBloc>().add(ObserveUserLocation());
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      chatScreenName = AllChatsScreen.routeName;
      _selectedIndex = index;
    });
  }

  final List<Widget> _onlineWidgetOptions = [
    const HomeScreen(),
    const CurrentLocationScreen(),
    const NotificationScreen(),
    const AllChatsScreen(),
    const ProfileScreen()
  ];
  final List<Widget> _offlineWidgetOptions = [
    const HomeScreen(),
    const AllChatsScreen(),
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (chatScreenName == ChatMessagingScreen.routeName) {
          context
              .read<ChatBloc>()
              .add(RebuildChatMessagingScreen(employeeDetailsMap: {
                'rid': ChatBloc().chatDetailsMap['rid'] ?? '',
                'rtype': ChatBloc().chatDetailsMap['rtype'] ?? ''
              }));
        } else {
          context.read<ChatBloc>().add(FetchChatsList());
        }

        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WifiConnectivityBloc, WifiConnectivityState>(
        listener: (context, state) {
      if (state is NoNetwork) {
        RootScreen.onceCall = true;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const RootScreen(isFromClientList: false)),
            ModalRoute.withName('/'));
      } else {
        context.read<ChatBloc>().add(FetchChatMessage());
        if (RootScreen.onceCall == true) {
          context.read<PermitBloc>().add(PermitInternetActions());
        }
        RootScreen.onceCall = false;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const RootScreen(isFromClientList: false)),
            ModalRoute.withName('/'));
      }
    }, builder: (context, state) {
      final bool hasNetwork = state is! NoNetwork;
      final List<Widget> currentWidgetOptions =
          hasNetwork ? _onlineWidgetOptions : _offlineWidgetOptions;
      if (_selectedIndex >= currentWidgetOptions.length) {
        _selectedIndex = 0;
      }
      final BottomNavigationBar bottomNavigationBar = hasNetwork
          ? _buildOnlineBottomNavigationBar()
          : _buildOfflineBottomNavigationBar();
      return Scaffold(
          body: Center(child: currentWidgetOptions[_selectedIndex]),
          bottomNavigationBar: bottomNavigationBar);
    });
  }

  BottomNavigationBar _buildOnlineBottomNavigationBar() {
    return BottomNavigationBar(
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem(Icons.home, ''),
          _buildBottomNavigationBarItem(Icons.location_on, ''),
          _buildNotificationBarItem(),
          _buildBottomNavigationBarItem(Icons.message, ''),
          _buildBottomNavigationBarItem(Icons.person, '')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.deepBlue,
        unselectedItemColor: AppColor.grey,
        onTap: _onItemTapped);
  }

  BottomNavigationBar _buildOfflineBottomNavigationBar() {
    return BottomNavigationBar(
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem(Icons.home, ''),
          _buildBottomNavigationBarItem(Icons.message, ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.deepBlue,
        unselectedItemColor: AppColor.grey,
        onTap: _onItemTapped);
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
            padding: const EdgeInsets.only(top: xxTiniestSpacing),
            child: Icon(icon)),
        label: label);
  }

  BottomNavigationBarItem _buildNotificationBarItem() {
    return BottomNavigationBarItem(
        icon: Center(
            child: Stack(alignment: Alignment.topCenter, children: [
          const Padding(
              padding: EdgeInsets.only(top: xxTiniestSpacing),
              child: Icon(Icons.notifications_sharp)),
          BlocBuilder<ClientBloc, ClientStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is HomeScreenFetched,
              builder: (context, state) {
                if (state is HomeScreenFetched &&
                    state.homeScreenModel.data?.badges?.isNotEmpty == true) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: kNotificationBadgePadding),
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                            height: kNotificationBadgeSize,
                            width: kNotificationBadgeSize,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.errorRed)),
                        Text(state.badgeCount.toString(),
                            style: Theme.of(context).textTheme.xxxSmall)
                      ]));
                }
                return const SizedBox();
              })
        ])),
        label: '');
  }
}
