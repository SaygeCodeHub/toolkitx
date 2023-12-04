import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/generic_no_records_text.dart';
import 'location_details_checklists_body.dart';

class LocationDetailsCheckListsTab extends StatelessWidget {
  final int selectedTabIndex;

  const LocationDetailsCheckListsTab({Key? key, required this.selectedTabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(FetchCheckListsLocation());
    return Column(
      children: [
        CustomIconButtonRow(
            primaryOnPress: () {},
            secondaryOnPress: () {},
            secondaryVisible: false,
            clearOnPress: () {}),
        const SizedBox(height: xxTinierSpacing),
        BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingLocationCheckLists ||
              currentState is LocationCheckListsFetched ||
              currentState is LocationCheckListsNotFetched,
          builder: (context, state) {
            if (state is FetchingLocationCheckLists) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationCheckListsFetched) {
              return LocationDetailsCheckListsBody(
                  checklistsLocation: state.fetchLocationCheckListsModel.data);
            } else if (state is LocationCheckListsNotFetched) {
              return NoRecordsText(
                  text: state.checkListsNotFetched,
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
