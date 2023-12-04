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
import 'location_details_workorders_body.dart';

class LocationDetailsWorkOrdersTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;

  const LocationDetailsWorkOrdersTab({Key? key, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationWorkOrders(pageNo: 1));
    context.read<LocationBloc>().workOrderLocations.clear();
    context.read<LocationBloc>().workOrderLoToListReachedMax = false;
    return Column(
      children: [
        CustomIconButtonRow(
            primaryOnPress: () {},
            secondaryOnPress: () {},
            secondaryVisible: false,
            clearOnPress: () {}),
        const SizedBox(height: xxTinierSpacing),
        BlocConsumer<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              (currentState is FetchingLocationWorkOrders && pageNo == 1) ||
              currentState is LocationWorkOrdersFetched ||
              currentState is LocationWorkOrdersNotFetched,
          listener: (context, state) {
            if (state is LocationWorkOrdersFetched &&
                state.workOrderLoToListReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingLocationWorkOrders) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationWorkOrdersFetched) {
              return LocationDetailsWorkOrdersBody(
                  workOrderLocations: state.workOrderLocations,
                  workOrderLoToListReachedMax:
                      state.workOrderLoToListReachedMax);
            } else if (state is LocationWorkOrdersNotFetched) {
              return NoRecordsText(
                  text: state.workOrderNotFetched,
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
