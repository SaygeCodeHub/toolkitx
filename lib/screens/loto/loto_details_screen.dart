import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/loto/widgets/loto_details.dart';
import 'package:toolkit/screens/loto/widgets/loto_pop_up_menu_button.dart';
import 'package:toolkit/utils/loto_util.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_spacing.dart';

class LotoDetailsScreen extends StatelessWidget {
  static const routeName = 'LotoDetailsScreen';
  const LotoDetailsScreen({super.key, required this.lotoDetailsMap});
  final Map lotoDetailsMap;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoDetailsBloc>()
        .add(FetchLotoDetails(lotoId: lotoDetailsMap["id"]));
    return Scaffold(
      appBar: GenericAppBar(
        title: lotoDetailsMap["name"],
        actions: [
          BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
              buildWhen: (previousState, currentState) =>
                  currentState is LotoDetailsFetching ||
                  currentState is LotoDetailsFetched,
              builder: (context, state) {
                if (state is LotoDetailsFetched) {
                  if (state.showPopUpMenu == true) {
                    return LotoPopupMenuButton(
                      popUpMenuItems: state.lotoPopUpMenu,
                      fetchLotoDetailsModel: state.fetchLotoDetailsModel,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ],
      ),
      body: BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
        builder: (context, state) {
          if (state is LotoDetailsFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LotoDetailsFetched) {
            return Padding(
              padding: const EdgeInsets.only(
                top: xxTinierSpacing,
              ),
              child: Column(
                children: [
                  CustomTabBarView(
                    lengthOfTabs: 6,
                    tabBarViewIcons: LotoUtil().tabBarViewIcons,
                    initialIndex: 0,
                    tabBarViewWidgets: [
                      LotoDetails(
                        fetchLotoDetailsModel: state.fetchLotoDetailsModel,
                      ),
                      const Text("Tab 2"),
                      const Text("Tab 3"),
                      const Text("Tab 4"),
                      const Text("Tab 5"),
                      const Text("Tab 6"),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
