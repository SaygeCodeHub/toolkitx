import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../loto/loto_filter_screen.dart';
import 'location_details_loto_body.dart';

class LocationDetailsLoToTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;
  final String expenseId;

  const LocationDetailsLoToTab(
      {Key? key, required this.selectedTabIndex, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationLoTo(pageNo: pageNo));
    context.read<LocationBloc>().locationLoTos.clear();
    context.read<LocationBloc>().locationLoToListReachedMax = false;
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previous, current) {
            return current is LocationLoToFetched ||
                current is FetchingLocationLoTo ||
                current is LocationLoToNotFetched;
          },
          builder: (context, state) {
            if (state is LocationLoToFetched) {
              return CustomIconButtonRow(
                isEnabled: true,
                clearVisible: state.loToFilterMap.isNotEmpty,
                primaryOnPress: () {
                  LotoFilterScreen.isFromLocation = true;
                  LotoFilterScreen.expenseId = expenseId;
                  Navigator.pushNamed(context, LotoFilterScreen.routeName);
                },
                secondaryOnPress: () {},
                secondaryVisible: false,
                clearOnPress: () {
                  pageNo = 1;
                  state.loToFilterMap.clear();
                  // LotoFilterScreen.lotoFilterMap.clear();
                  context.read<LocationBloc>().locationLoTos.clear();
                  context.read<LocationBloc>().locationLoToListReachedMax =
                      false;
                  context
                      .read<LocationBloc>()
                      .add(FetchLocationLoTo(pageNo: pageNo));
                },
              );
            } else if (state is LocationLoToNotFetched) {
              return CustomIconButtonRow(
                isEnabled: true,
                clearVisible: state.filtersMap.isNotEmpty,
                primaryOnPress: () {
                  LotoFilterScreen.isFromLocation = true;
                  LotoFilterScreen.expenseId = expenseId;
                  Navigator.pushNamed(context, LotoFilterScreen.routeName);
                },
                secondaryOnPress: () {},
                secondaryVisible: false,
                clearOnPress: () {
                  pageNo = 1;
                  state.filtersMap.clear();
                  // LotoFilterScreen.lotoFilterMap.clear();
                  context.read<LocationBloc>().locationLoTos.clear();
                  context.read<LocationBloc>().locationLoToListReachedMax =
                      false;
                  context
                      .read<LocationBloc>()
                      .add(FetchLocationLoTo(pageNo: pageNo));
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
              if (context.read<LotoListBloc>().filters.isNotEmpty) {
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
