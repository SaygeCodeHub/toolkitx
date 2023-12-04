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
import 'location_details_logbooks_body.dart';

class LocationDetailsLogBooksTab extends StatelessWidget {
  final int selectedTabIndex;
  static int pageNo = 1;

  const LocationDetailsLogBooksTab({Key? key, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationLogBooks(pageNo: 1));
    context.read<LocationBloc>().locationLogBooks.clear();
    context.read<LocationBloc>().locationLogBooksListReachedMax = false;
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
              (currentState is FetchingLocationLogBooks && pageNo == 1) ||
              currentState is LocationLogBooksFetched ||
              currentState is LocationLogBooksNotFetched,
          listener: (context, state) {
            if (state is LocationLogBooksFetched &&
                state.locationLogBooksListReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingLocationLogBooks) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationLogBooksFetched) {
              return LocationDetailsLogBooksBody(
                  locationLogBooks: state.locationLogBooks,
                  locationLogBooksListReachedMax:
                      state.locationLogBooksListReachedMax);
            } else if (state is LocationLogBooksNotFetched) {
              return NoRecordsText(
                  text: state.logBooksNotFetched,
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
