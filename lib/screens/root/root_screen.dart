import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/all_chats_screen.dart';

import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_states.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import '../../blocs/wifiConnectivity/wifi_connectivity_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = 'RootScreen';
  final bool isFromClientList;

  const RootScreen({super.key, required this.isFromClientList});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isFromClientList) {
      _selectedIndex = 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _onlineWidgetOptions = [
    const HomeScreen(),
    const Text('Index 2: Location'),
    const Text('Index 2: Notification'),
    const AllChatsScreen(),
    const ProfileScreen(),
  ];

  final List<Widget> _offlineWidgetOptions = [
    const HomeScreen(),
    const AllChatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WifiConnectivityBloc, WifiConnectivityState>(
      listener: (context, state) {
        if (state is NoNetwork) {
          print('no network established');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RootScreen(isFromClientList: false)),
              ModalRoute.withName('/'));
        } else {
          print('network established');
          context.read<ChatBloc>().add(FetchChatMessage());
        }
      },
      builder: (context, state) {
        final bool hasNetwork = state is! NoNetwork;
        final List<Widget> currentWidgetOptions =
            hasNetwork ? _onlineWidgetOptions : _offlineWidgetOptions;
        final BottomNavigationBar bottomNavigationBar = hasNetwork
            ? _buildOnlineBottomNavigationBar()
            : _buildOfflineBottomNavigationBar();

        return Scaffold(
          body: Center(child: currentWidgetOptions[_selectedIndex]),
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
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
        _buildBottomNavigationBarItem(Icons.person, ''),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColor.deepBlue,
      unselectedItemColor: AppColor.grey,
      onTap: _onItemTapped,
    );
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
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: xxTiniestSpacing),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  BottomNavigationBarItem _buildNotificationBarItem() {
    return BottomNavigationBarItem(
      icon: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: xxTiniestSpacing),
              child: Icon(Icons.notifications_sharp),
            ),
            BlocBuilder<ClientBloc, ClientStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is HomeScreenFetched,
              builder: (context, state) {
                if (state is HomeScreenFetched &&
                    state.homeScreenModel.data?.badges?.isNotEmpty == true) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: kNotificationBadgePadding),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: kNotificationBadgeSize,
                          width: kNotificationBadgeSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.errorRed,
                          ),
                        ),
                        Text(
                          state.badgeCount.toString(),
                          style: Theme.of(context).textTheme.xxxSmall,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
