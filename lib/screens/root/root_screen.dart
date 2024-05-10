import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_states.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../home/home_screen.dart';
import '../location/current_location_screen.dart';
import '../profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = 'RootScreen';
  final bool isFromClientList;

  const RootScreen({super.key, required this.isFromClientList});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static int _selectedIndex = 0;

  @override
  void initState() {
    widget.isFromClientList == true ? _selectedIndex = 0 : null;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _widgetOptions = [
    HomeScreen(),
    CurrentLocationScreen(),
    Text('Index 2: Notification'),
    Text('Index 3: Chat'),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar:
            BlocBuilder<WifiConnectivityBloc, WifiConnectivityState>(
                builder: (context, state) {
          if (state is NoNetwork) {
            return _bottomNavigationBar(true);
          } else {
            return _bottomNavigationBar(false);
          }
        }));
  }

  BottomNavigationBar _bottomNavigationBar(bool isDisabled) {
    return BottomNavigationBar(
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(top: xxTiniestSpacing),
                  child: Icon(Icons.home)),
              label: ''),
          const BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(top: xxTiniestSpacing),
                  child: Icon(Icons.location_on)),
              label: ''),
          BottomNavigationBarItem(
              icon: Center(
                child: Stack(alignment: Alignment.topCenter, children: [
                  const Padding(
                      padding: EdgeInsets.only(top: xxTiniestSpacing),
                      child: Icon(Icons.notifications_sharp)),
                  BlocBuilder<ClientBloc, ClientStates>(
                      buildWhen: (previousState, currentState) =>
                          currentState is HomeScreenFetched,
                      builder: (context, state) {
                        if (state is HomeScreenFetched) {
                          if (state.homeScreenModel.data!.badges!.isNotEmpty) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: kNotificationBadgePadding),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                          height: kNotificationBadgeSize,
                                          width: kNotificationBadgeSize,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.errorRed)),
                                      Text(state.badgeCount.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .xxxSmall)
                                    ]));
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return const SizedBox();
                        }
                      }),
                ]),
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(top: xxTiniestSpacing),
                  child: Icon(Icons.message)),
              label: ''),
          const BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(top: xxTiniestSpacing),
                  child: Icon(Icons.person)),
              label: '')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.deepBlue,
        unselectedItemColor:
            (isDisabled) ? AppColor.lightestGrey : AppColor.grey,
        onTap: (isDisabled) ? null : _onItemTapped);
  }
}
