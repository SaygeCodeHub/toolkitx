import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/trips/trip_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/trip_vessel_filter_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class TripVesselFilter extends StatelessWidget {
  const TripVesselFilter({super.key, required this.tripFilterMap});

  final Map tripFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(
        SelectTripVesselFilter(selectVessel: tripFilterMap['vessel'] ?? ''));
    return BlocBuilder<TripBloc, TripState>(
        buildWhen: (previousState, currentState) =>
            currentState is TripsVesselFilterSelected,
        builder: (context, state) {
          if (state is TripsVesselFilterSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, TripVesselFilterList.routeName,
                        arguments: state.selectVessel);
                  },
                  title: Text(StringConstants.kVessel,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle: (context.read<TripBloc>().vesselName == '')
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: xxxTinierSpacing),
                          child: Text(context.read<TripBloc>().vesselName,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.black)),
                        ),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
            ]);
          } else {
            return const SizedBox();
          }
        });
  }
}
