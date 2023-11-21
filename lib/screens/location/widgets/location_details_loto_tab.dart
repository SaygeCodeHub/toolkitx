import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import 'location_details_loto_body.dart';

class LocationDetailsLoToTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;

  const LocationDetailsLoToTab({Key? key, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationLoTo(pageNo: pageNo));
    context.read<LocationBloc>().locationLoTos.clear();
    context.read<LocationBloc>().locationLoToListReachedMax = false;
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
              (currentState is FetchingLocationLoTo && pageNo == 1) ||
              currentState is LocationLoToFetched ||
              currentState is LocationLoToNotFetched,
          listener: (context, state) {
            if (state is LocationLoToFetched &&
                state.locationLoToListReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingLocationLoTo) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationLoToFetched) {
              return LocationDetailsLoToBody(
                  locationLoTos: state.locationLoTos,
                  locationLoToListReachedMax: state.locationLoToListReachedMax);
            } else if (state is LocationLoToNotFetched) {
              return NoRecordsText(
                  text: state.loToNotFetched,
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
