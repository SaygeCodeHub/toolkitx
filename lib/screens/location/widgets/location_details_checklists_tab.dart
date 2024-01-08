import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../checklist/systemUser/sys_user_filters_screen.dart';
import '../../checklist/systemUser/widgets/sys_user_filter_section.dart';
import 'location_details_checklists_body.dart';

class LocationDetailsCheckListsTab extends StatelessWidget {
  final int selectedTabIndex;
  final String expenseId;

  const LocationDetailsCheckListsTab(
      {Key? key, required this.selectedTabIndex, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(FetchCheckListsLocation());
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              currentState is LocationCheckListsFetched ||
              currentState is LocationCheckListsNotFetched,
          builder: (context, state) {
            if (state is LocationCheckListsFetched) {
              return CustomIconButtonRow(
                  primaryOnPress: () {
                    FilterSection.isFromLocation = true;
                    FilterSection.expenseId = expenseId;
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  },
                  secondaryOnPress: () {},
                  secondaryVisible: false,
                  clearVisible: state.filterMap.isNotEmpty,
                  primaryVisible: state.userType == '1',
                  clearOnPress: () {
                    state.filterMap.clear();
                    FilterSection.filterDataMap.clear();
                    context.read<LocationBloc>().add(FetchCheckListsLocation());
                  });
            } else if (state is LocationCheckListsNotFetched) {
              return CustomIconButtonRow(
                  primaryOnPress: () {
                    FilterSection.isFromLocation = true;
                    FilterSection.expenseId = expenseId;
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  },
                  clearVisible: state.filterMap.isNotEmpty,
                  primaryVisible: state.userType == '1',
                  secondaryOnPress: () {},
                  secondaryVisible: false,
                  clearOnPress: () {
                    state.filterMap.clear();
                    FilterSection.filterDataMap.clear();
                    context.read<LocationBloc>().add(FetchCheckListsLocation());
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
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
              if (context.read<LocationBloc>().checkListFilterMap.isNotEmpty) {
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
