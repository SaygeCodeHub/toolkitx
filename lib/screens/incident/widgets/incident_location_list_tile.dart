import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import 'incident_location_list.dart';

class IncidentLocationListTile extends StatelessWidget {
  final Map addIncidentMap;

  const IncidentLocationListTile({super.key, required this.addIncidentMap});

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(ReportNewIncidentLocationChange(
        selectLocationName: (addIncidentMap['location_name'] == null)
            ? ''
            : addIncidentMap['location_name']));
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentLocationSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentLocationSelected) {
            addIncidentMap['location_name'] = state.selectLocationName;
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IncidentLocationList(
                                  fetchIncidentMasterModel:
                                      state.fetchIncidentMasterModel,
                                  selectLocationName:
                                      state.selectLocationName)));
                    },
                    title: Text(DatabaseUtil.getText('Location'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.selectLocationName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.selectLocationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible: state.selectLocationName ==
                        DatabaseUtil.getText('Other'),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringConstants.kOther,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              hintText: DatabaseUtil.getText('OtherLocation'),
                              onTextFieldChanged: (String textField) {
                                addIncidentMap['location_name'] =
                                    (state.selectLocationName == 'Other'
                                        ? textField
                                        : '');
                              })
                        ])),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
