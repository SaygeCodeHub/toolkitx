import 'package:flutter/material.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';

class CustomTabBarView extends StatelessWidget {
  final List<Tab> tabBarViewIcons;
  final List<Widget> tabBarViewWidgets;
  final int lengthOfTabs;
  final int initialIndex;

  const CustomTabBarView(
      {super.key,
      required this.tabBarViewIcons,
      required this.tabBarViewWidgets,
      required this.lengthOfTabs,
      this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        initialIndex: initialIndex,
        length: lengthOfTabs, // Set the number of tabs
        child: Column(
          children: [
            TabBar(
                isScrollable: false,
                indicatorWeight: kDividerThickness,
                tabs: tabBarViewIcons),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(xxTinierSpacing),
                child: TabBarView(children: tabBarViewWidgets),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
