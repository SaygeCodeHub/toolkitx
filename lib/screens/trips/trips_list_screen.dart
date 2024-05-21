import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/trips/trip_filter_screen.dart';
import 'package:toolkit/screens/trips/widgets/trip_list_body.dart';
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
