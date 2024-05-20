import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/trip_details_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/trips/trip_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';

class TripsListScreen extends StatelessWidget {
  const TripsListScreen({super.key});

  static const routeName = 'TripsListScreen';

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(FetchTripsList(pageNo: 1));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('TripOverview')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: Column(
          children: [
            CustomIconButtonRow(
              primaryOnPress: () {},
              secondaryOnPress: () {},
              secondaryVisible: false,
              clearVisible: false,
              clearOnPress: () {},
            ),
            Expanded(
              child: BlocBuilder<TripBloc, TripState>(
                builder: (context, state) {
                  if (state is TripsListFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TripsListFetched) {
                    return ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: xxTinierSpacing),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    TripsDetailsScreen.routeName,
                                    arguments: state
                                        .fetchTripsListModel.data[index].id);
                              },
                              title: Text(
                                  state.fetchTripsListModel.data[index].vessel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.black)),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: tinierSpacing),
                                    Text(
                                        '${state.fetchTripsListModel.data[index].departuredatetime} - ${state.fetchTripsListModel.data[index].arrivaldatetime}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.grey)),
                                    const SizedBox(height: tiniestSpacing),
                                    Text(
                                        '${state.fetchTripsListModel.data[index].deplocname} - ${state.fetchTripsListModel.data[index].arrlocname}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.grey)),
                                  ]),
                              trailing: Text(
                                  state.fetchTripsListModel.data[index].status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.deepBlue)),
                            ),
                          ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: xxTinierSpacing);
                        });
                  } else if (state is TripsListNotFetched) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
