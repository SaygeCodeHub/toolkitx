import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/location/location_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/location_tabs_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/location_details_checklists_tab.dart';
import 'widgets/location_details_assets_tab.dart';
import 'widgets/location_details_logbooks_tab.dart';
import 'widgets/location_details_loto_tab.dart';
import 'widgets/location_details_permits_tab.dart';
import 'widgets/location_details_tab_one.dart';
import 'widgets/location_details_workorders_tab.dart';
import 'widgets/location_documents_tab.dart';

class LocationDetailsScreen extends StatelessWidget {
  final String expenseId;
  static const routeName = 'LocationDetailsScreen';

  const LocationDetailsScreen({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    context
        .read<LocationBloc>()
        .add(FetchLocationDetails(locationId: expenseId, selectedTabIndex: 0));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kLocationDetails),
        body: BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingLocationDetails ||
              currentState is LocationDetailsFetched ||
              currentState is LocationDetailsNotFetched,
          builder: (context, state) {
            if (state is FetchingLocationDetails) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationDetailsFetched) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: xxTinierSpacing),
                  child: Column(children: [
                    Card(
                        color: AppColor.white,
                        elevation: kCardElevation,
                        child: ListTile(
                            title: Padding(
                                padding:
                                    const EdgeInsets.only(top: xxTinierSpacing),
                                child: Text(
                                    state.fetchLocationDetailsModel.data.name,
                                    style:
                                        Theme.of(context).textTheme.medium)))),
                    const SizedBox(height: xxTinierSpacing),
                    const Divider(
                        height: kDividerHeight, thickness: kDividerWidth),
                    CustomTabBarView(
                        lengthOfTabs: 8,
                        tabBarViewIcons: LocationTabsUtil().tabBarViewIcons,
                        initialIndex: state.selectedTabIndex,
                        tabBarViewWidgets: [
                          LocationDetailsTabOne(
                              data: state.fetchLocationDetailsModel.data,
                              selectedTabIndex: 0),
                          LocationDocumentsTab(
                              data: state.fetchLocationDetailsModel.data,
                              selectedTabIndex: 1,
                              clientId: state.clientId),
                          LocationDetailsPermitsTab(
                              selectedTabIndex: 2, expenseId: expenseId),
                          LocationDetailsLoToTab(
                              selectedTabIndex: 3, expenseId: expenseId),
                          LocationDetailsWorkOrdersTab(
                              selectedTabIndex: 4, expenseId: expenseId),
                          LocationDetailsLogBooksTab(
                              selectedTabIndex: 5, expenseId: expenseId),
                          LocationDetailsCheckListsTab(
                              selectedTabIndex: 6, expenseId: expenseId),
                          LocationDetailsAssetsTab(
                              selectedTabIndex: 7, expenseId: expenseId)
                        ])
                  ]));
            } else if (state is LocationDetailsNotFetched) {
              return Column(
                children: [
                  GenericReloadButton(
                      onPressed: () {
                        context.read<LocationBloc>().add(FetchLocationDetails(
                            locationId: expenseId, selectedTabIndex: 1));
                      },
                      textValue: StringConstants.kReload),
                  const SizedBox(height: xxTinierSpacing),
                  Text(state.detailsNotFetched,
                      style: Theme.of(context).textTheme.medium)
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
