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
import 'incident_site_list.dart';

class IncidentSiteListTile extends StatelessWidget {
  final Map addIncidentMap;

  const IncidentSiteListTile({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportNewIncidentBloc>()
        .add(ReportIncidentSiteListChange(selectSiteName: ''));
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentSiteSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentSiteSelected) {
            addIncidentMap['site_name'] = state.selectSiteName;
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IncidentSiteList(
                                  fetchIncidentMasterModel:
                                      state.fetchIncidentMasterModel,
                                  selectSiteName: state.selectSiteName)));
                    },
                    title: Text(DatabaseUtil.getText('Site'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.selectSiteName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.selectSiteName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible:
                        state.selectSiteName == DatabaseUtil.getText('Other'),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DatabaseUtil.getText('OtherSite'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              hintText: StringConstants.kOther,
                              onTextFieldChanged: (String textField) {
                                addIncidentMap['site_name'] = textField;
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
