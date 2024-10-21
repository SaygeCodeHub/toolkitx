import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'incident_list_screen.dart';
import 'widgets/date_picker.dart';
import 'widgets/filter_status_section.dart';

class IncidentFilterScreen extends StatelessWidget {
  static const routeName = 'IncidentFilterScreen';

  IncidentFilterScreen({super.key});
  final Map incidentFilterMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
        body: BlocBuilder<IncidentLisAndFilterBloc,
                IncidentListAndFilterStates>(
            buildWhen: (previousState, currentState) =>
                currentState is IncidentsFetched,
            builder: (context, state) {
              if (state is IncidentsFetched) {
                incidentFilterMap.addAll(state.filterMap);
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(DatabaseUtil.getText('DateRange'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxTinySpacing),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: DatePickerTextField(
                                        editDate: incidentFilterMap["st"] ?? '',
                                        hintText: StringConstants.kSelectDate,
                                        onDateChanged: (String date) {
                                          incidentFilterMap["st"] = date;
                                        })),
                                const SizedBox(width: xxTinierSpacing),
                                Text(DatabaseUtil.getText('to')),
                                const SizedBox(width: xxTinierSpacing),
                                Expanded(
                                    child: DatePickerTextField(
                                        editDate: incidentFilterMap["et"] ?? '',
                                        hintText:
                                            DatabaseUtil.getText('SelectDate'),
                                        onDateChanged: (String date) {
                                          incidentFilterMap["et"] = date;
                                        }))
                              ]),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('Status'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxTinySpacing),
                          IncidentStatusFilter(
                              incidentFilterMap: incidentFilterMap),
                          const SizedBox(height: xxxSmallerSpacing),
                          PrimaryButton(
                              onPressed: () {
                                if (incidentFilterMap['st'] != null &&
                                        incidentFilterMap['et'] == null ||
                                    incidentFilterMap['st'] == null &&
                                        incidentFilterMap['et'] != null) {
                                  showCustomSnackBar(
                                      context,
                                      DatabaseUtil.getText('TimeDateValidate'),
                                      '');
                                } else {
                                  context.read<IncidentLisAndFilterBloc>().add(
                                      ApplyIncidentFilter(
                                          incidentFilterMap:
                                              incidentFilterMap));
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                      context, IncidentListScreen.routeName,
                                      arguments: false);
                                }
                              },
                              textValue: DatabaseUtil.getText('Apply'))
                        ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
