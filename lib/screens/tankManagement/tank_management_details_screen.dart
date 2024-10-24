import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_management_basic_details.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_management_checklist_tab.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_management_icss_details.dart';
import 'package:toolkit/utils/tank_management_tab_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_tabbar_view.dart';

class TankManagementDetailsScreen extends StatelessWidget {
  const TankManagementDetailsScreen({super.key, required this.nominationId});

  final String nominationId;

  static const routeName = 'TankManagementDetailsScreen';

  @override
  Widget build(BuildContext context) {
    context
        .read<TankManagementBloc>()
        .add(FetchTankManagementDetails(nominationId: nominationId));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<TankManagementBloc, TankManagementState>(
          buildWhen: (previousState, currentState) =>
              currentState is TankManagementDetailsFetching ||
              currentState is TankManagementDetailsFetched ||
              currentState is TankManagementDetailsNotFetched,
          builder: (context, state) {
            if (state is TankManagementDetailsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TankManagementDetailsFetched) {
              var data = state.fetchTankManagementDetailsModel.data;
              return Column(
                children: [
                  Card(
                      color: AppColor.white,
                      elevation: kCardElevation,
                      child: ListTile(
                          title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: xxTinierSpacing),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.nominationo),
                                  ])))),
                  const SizedBox(height: xxTinierSpacing),
                  const Divider(
                      height: kDividerHeight, thickness: kDividerWidth),
                  const SizedBox(height: xxTinierSpacing),
                  CustomTabBarView(
                      lengthOfTabs: 3,
                      tabBarViewIcons: TankManagementTabsUtil().tabBarViewIcons,
                      initialIndex: context.read<TankManagementBloc>().tabIndex,
                      tabBarViewWidgets: [
                        TankManagementBasicDetails(
                            fetchTankManagementDetailsModel:
                                state.fetchTankManagementDetailsModel),
                        TankManagementChecklistTab(nominationId: data.id),
                        TankManagementICSSDetails(
                            fetchTankManagementDetailsModel:
                                state.fetchTankManagementDetailsModel,
                            nominationId: nominationId)
                      ])
                ],
              );
            } else if (state is TankManagementDetailsNotFetched) {
              return const Center(child: Text(StringConstants.kNoData));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
