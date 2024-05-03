import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/di/app_module.dart';
import 'package:toolkit/screens/chat/all_chats_screen.dart';
import 'package:toolkit/screens/chat/widgets/chat_data_model.dart';

import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_states.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database/database_util.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = 'RootScreen';
  final bool isFromClientList;

  const RootScreen({super.key, required this.isFromClientList});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  static int _selectedIndex = 0;
  final DatabaseHelper databaseHelper = getIt<DatabaseHelper>();

  @override
  void initState() {
    widget.isFromClientList == true ? _selectedIndex = 0 : null;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); // Unregister the observer
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List _widgetOptions = [
    HomeScreen(),
    Text('Index 1: Location'),
    Text('Index 2: Notification'),
    AllChatsScreen(),
    ProfileScreen()
  ];

  Future<String> getEmployeeId() async {
    final String? employeeId = await databaseHelper.getLatestEmployeeId();
    return employeeId ?? "";
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    String? employeeId = await getEmployeeId();
    String employeeIdString = employeeId;
    switch (state) {
      case AppLifecycleState.resumed:
        print('active state ${context.read<ChatBloc>().chatDetailsMap}');
        context
            .read<ChatBloc>()
            .add(RebuildChatMessagingScreen(employeeDetailsMap: {
              "employee_id": employeeIdString,
              'sid': context.read<ChatBloc>().chatDetailsMap['sid'],
              'rid': context.read<ChatBloc>().chatDetailsMap['rid'],
              'isGroup': context.read<ChatBloc>().chatDetailsMap['isGroup']
            }));
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
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar:
            BlocConsumer<WifiConnectivityBloc, WifiConnectivityState>(
                listener: (context, state) {
          if (state is NoNetwork) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const RootScreen(isFromClientList: false)),
                ModalRoute.withName('/'));
          }
        }, builder: (context, state) {
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
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: xxTiniestSpacing),
                      child: Icon(Icons.message)),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: kNotificationBadgePadding),
                      child: StreamBuilder<List<ChatData>>(
                          stream: context.read<ChatBloc>().allChatsStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        height: kNotificationBadgeSize,
                                        width: kNotificationBadgeSize,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.errorRed)),
                                    Text(
                                        (snapshot.data!.isNotEmpty)
                                            ? snapshot.data![0].unreadMsgCount
                                                .toString()
                                            : '0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxxSmall)
                                  ]);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }))
                ],
              ),
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
