import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../permit/permit_filter_screen.dart';
import 'location_details_permits_body.dart';

class LocationDetailsPermitsTab extends StatelessWidget {
  final int selectedTabIndex;
  final String expenseId;
  static int pageNo = 1;

  const LocationDetailsPermitsTab(
      {super.key, required this.selectedTabIndex, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationPermits(pageNo: 1));
    context.read<LocationBloc>().locationPermits.clear();
    context.read<LocationBloc>().locationPermitListReachedMax = false;
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) {
            return currentState is LocationPermitsFetched ||
                currentState is LocationPermitsNotFetched;
          },
          builder: (context, state) {
            if (state is LocationPermitsFetched) {
              return CustomIconButtonRow(
                isEnabled: true,
                primaryOnPress: () {
                  PermitFilterScreen.isFromLocation = true;
                  PermitFilterScreen.expenseId = expenseId;
                  Navigator.pushNamed(context, PermitFilterScreen.routeName);
                },
                secondaryOnPress: () {},
                secondaryVisible: false,
                clearVisible: state.filterMap.isNotEmpty,
                clearOnPress: () {
                  pageNo = 1;
                  state.filterMap.clear();
                  PermitFilterScreen.permitFilterMap.clear();
                  context.read<LocationBloc>().locationPermits.clear();
                  context.read<LocationBloc>().locationPermitListReachedMax =
                      false;
                  context
                      .read<LocationBloc>()
                      .add(FetchLocationPermits(pageNo: pageNo));
                },
              );
            } else if (state is LocationPermitsNotFetched) {
              return CustomIconButtonRow(
                isEnabled: true,
                primaryOnPress: () {
                  PermitFilterScreen.isFromLocation = true;
                  PermitFilterScreen.expenseId = expenseId;
                  Navigator.pushNamed(context, PermitFilterScreen.routeName);
                },
                secondaryOnPress: () {},
                secondaryVisible: false,
                clearVisible: state.filterMap.isNotEmpty,
                clearOnPress: () {
                  pageNo = 1;
                  state.filterMap.clear();
                  PermitFilterScreen.permitFilterMap.clear();
                  context.read<LocationBloc>().locationPermits.clear();
                  context.read<LocationBloc>().locationPermitListReachedMax =
                      false;
                  context
                      .read<LocationBloc>()
                      .add(FetchLocationPermits(pageNo: pageNo));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
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
              if (context.read<LocationBloc>().permitsFilterMap.isNotEmpty) {
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
