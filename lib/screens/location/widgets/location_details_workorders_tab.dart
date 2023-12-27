import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../workorder/workorder_filter_screen.dart';
import 'location_details_workorders_body.dart';

class LocationDetailsWorkOrdersTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;
  final String expenseId;

  const LocationDetailsWorkOrdersTab(
      {Key? key, required this.selectedTabIndex, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationWorkOrders(pageNo: 1));
    context.read<LocationBloc>().workOrderLocations.clear();
    context.read<LocationBloc>().workOrderLoToListReachedMax = false;
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) {
            return currentState is LocationWorkOrdersFetched ||
                currentState is FetchingLocationWorkOrders ||
                currentState is LocationWorkOrdersNotFetched;
          },
          builder: (context, state) {
            if (state is LocationWorkOrdersFetched) {
              return CustomIconButtonRow(
                  isEnabled: true,
                  primaryOnPress: () {
                    WorkOrderFilterScreen.isFromLocation = true;
                    WorkOrderFilterScreen.expenseId = expenseId;
                    Navigator.pushNamed(
                        context, WorkOrderFilterScreen.routeName);
                  },
                  secondaryOnPress: () {},
                  clearVisible: state.filterMap.isNotEmpty,
                  secondaryVisible: false,
                  clearOnPress: () {
                    pageNo = 1;
                    state.filterMap.clear();
                    WorkOrderFilterScreen.workOrderFilterMap.clear();
                    context.read<LocationBloc>().workOrderLocations.clear();
                    context.read<LocationBloc>().workOrderLoToListReachedMax =
                        false;
                    context
                        .read<LocationBloc>()
                        .add(FetchLocationWorkOrders(pageNo: pageNo));
                  });
            } else if (state is LocationWorkOrdersNotFetched) {
              return CustomIconButtonRow(
                  isEnabled: true,
                  primaryOnPress: () {
                    WorkOrderFilterScreen.isFromLocation = true;
                    WorkOrderFilterScreen.expenseId = expenseId;
                    Navigator.pushNamed(
                        context, WorkOrderFilterScreen.routeName);
                  },
                  secondaryOnPress: () {},
                  clearVisible: state.filtersMap.isNotEmpty,
                  secondaryVisible: false,
                  clearOnPress: () {
                    pageNo = 1;
                    state.filtersMap.clear();
                    WorkOrderFilterScreen.workOrderFilterMap.clear();
                    context.read<LocationBloc>().workOrderLocations.clear();
                    context.read<LocationBloc>().workOrderLoToListReachedMax =
                        false;
                    context
                        .read<LocationBloc>()
                        .add(FetchLocationWorkOrders(pageNo: pageNo));
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
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
              if (context.read<LocationBloc>().workOrderFilterMap.isNotEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
