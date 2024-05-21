import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/trip_details_screen.dart';
import 'package:toolkit/screens/trips/trip_filter_screen.dart';
import 'package:toolkit/screens/trips/trip_list_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/trips/trip_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';

class TripsListScreen extends StatelessWidget {
  const TripsListScreen({super.key, required this.isFromHome});

  static int pageNo = 1;
  final bool isFromHome;

  static const routeName = 'TripsListScreen';

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<TripBloc>().hasReachedMax = false;
    context.read<TripBloc>().tripDatum = [];
    context
        .read<TripBloc>()
        .add(FetchTripsList(pageNo: 1, isFromHome: isFromHome));
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
            BlocBuilder<TripBloc, TripState>(
                buildWhen: (previousState, currentState) {
              if (currentState is TripsListFetching &&
                  pageNo == 1 &&
                  isFromHome == true) {
                return true;
              } else if (currentState is TripsListFetched) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              if (state is TripsListFetched) {
                return CustomIconButtonRow(
                    primaryOnPress: () {
                      Navigator.pushNamed(context, TripsFilterScreen.routeName);
                    },
                    secondaryOnPress: () {},
                    secondaryVisible: false,
                    clearVisible:
                        state.filterMap.isNotEmpty && isFromHome != true,
                    clearOnPress: () {
                      pageNo = 1;
                      context.read<TripBloc>().hasReachedMax = false;
                      context.read<TripBloc>().filters.clear();
                      context.read<TripBloc>().tripDatum.clear();
                      context.read<TripBloc>().vesselName = '';
                      context.read<TripBloc>().add(ClearTripFilter());
                      context.read<TripBloc>().add(
                          FetchTripsList(pageNo: 1, isFromHome: isFromHome));
                    });
              } else {
                return const SizedBox.shrink();
              }
            }),
            Expanded(
              child: BlocConsumer<TripBloc, TripState>(
                buildWhen: (previousState, currentState) =>
                    (currentState is TripsListFetching && pageNo == 1) ||
                    (currentState is TripsListFetched),
                listener: (context, state) {
                  if (state is TripsListFetched &&
                      context.read<TripBloc>().hasReachedMax) {
                    showCustomSnackBar(
                        context, StringConstants.kAllDataLoaded, '');
                  }
                },
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
                    return TripListBody(tripListDatum: state.tripDatum);
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
