import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/widgets/trip_details_tab.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/trips_util.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/trips/trip_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/status_tag.dart';

class TripsDetailsScreen extends StatelessWidget {
  const TripsDetailsScreen({super.key, required this.tripId});

  final String tripId;

  static const routeName = 'TripsDetailsScreen';

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(FetchTripsDetails(tripId: tripId, tripTabIndex: 0));
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            if (state is TripDetailsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripDetailsFetched) {
              var data = state.fetchTripDetailsModel.data;
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
                                    Text(data.vesselname),
                                  ])))),
                  const SizedBox(height: xxTinierSpacing),
                  const Divider(
                      height: kDividerHeight, thickness: kDividerWidth),
                  const SizedBox(height: xxTinierSpacing),
                  CustomTabBarView(
                      lengthOfTabs: 4,
                      tabBarViewIcons: TripsUtil().tabBarViewIcons,
                      initialIndex: context.read<TripBloc>().tripTabIndex,
                      tabBarViewWidgets: [
                        TripDetailsTab(tripData: data),
                        Text("Tab2"),
                        Text("Tab3")
                      ])
                ],
              );
            } else if (state is TripDetailsNotFetched) {
              return const Center(child: Text(StringConstants.kNoData));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
