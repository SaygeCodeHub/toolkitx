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

  const IncidentLocationListTile({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportNewIncidentBloc>()
        .add(ReportNewIncidentLocationChange(selectLocationName: ''));
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
                            .medium
                            .copyWith(color: AppColor.black)),
                    subtitle: (state.selectLocationName == '')
                        ? null
                        : Text(state.selectLocationName,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.black)),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible: state.selectLocationName ==
                        DatabaseUtil.getText('Other'),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringConstants.kOther,
                              style: Theme.of(context).textTheme.medium),
                          const SizedBox(height: tiniestSpacing),
                          TextFieldWidget(
                            hintText: DatabaseUtil.getText('OtherLocation'),
                            onTextFieldChanged: (String textField) {
                              addIncidentMap['location_name'] = textField;
                            },
                          ),
                          const SizedBox(height: tinySpacing)
                        ])),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
