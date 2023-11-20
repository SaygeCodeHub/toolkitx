import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import 'location_details_permits_body.dart';

class LocationDetailsPermitsTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;

  const LocationDetailsPermitsTab({Key? key, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationPermits(pageNo: 1));
    context.read<LocationBloc>().locationPermits.clear();
    context.read<LocationBloc>().locationPermitListReachedMax = false;
    return Column(
      children: [
        CustomIconButtonRow(
          primaryOnPress: () {},
          secondaryOnPress: () {},
          secondaryVisible: false,
          clearOnPress: () {},
        ),
        const SizedBox(height: xxTinierSpacing),
        BlocConsumer<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              (currentState is FetchingLocationPermits && pageNo == 1) ||
              currentState is LocationPermitsFetched ||
              currentState is LocationPermitsNotFetched,
          listener: (context, state) {
            if (state is LocationPermitsFetched &&
                state.locationPermitListReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingLocationPermits) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationPermitsFetched) {
              return LocationDetailsPermitsBody(
                  locationPermits: state.locationPermits,
                  locationPermitListReachedMax:
                      state.locationPermitListReachedMax);
            } else if (state is LocationPermitsNotFetched) {
              return NoRecordsText(
                  text: state.permitsNotFetched,
                  style: Theme.of(context).textTheme.medium);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
