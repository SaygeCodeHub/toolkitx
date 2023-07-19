import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/category_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import 'incident_contractor_list.dart';

class IncidentContractorListTile extends StatelessWidget {
  final Map addIncidentMap;
  static String contractorName = '';

  const IncidentContractorListTile({
    Key? key,
    required this.addIncidentMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(
        ReportNewIncidentContractorListChange(
            selectContractorName: contractorName,
            selectContractorId: (addIncidentMap['companyid'] == null ||
                    addIncidentMap['companyid'].isEmpty)
                ? ''
                : addIncidentMap['companyid']));
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentContractorSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentContractorSelected) {
            addIncidentMap['companyid'] = state.selectContractorId;
            return Visibility(
              visible: CategoryScreen.isFromEdit != true,
              replacement: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(DatabaseUtil.getText('contractor'),
                    style: Theme.of(context)
                        .textTheme
                        .medium
                        .copyWith(color: AppColor.black)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: tiniestSpacing),
                  child: Text(
                      (addIncidentMap['companyid'] == null ||
                              addIncidentMap['companyid'].toString().isEmpty)
                          ? ""
                          : state.selectContractorName,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.black)),
                ),
              ),
              child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncidentContractorList(
                                fetchIncidentMasterModel:
                                    state.fetchIncidentMasterModel,
                                selectContractorId: state.selectContractorId,
                                selectContractorName:
                                    state.selectContractorName)));
                  },
                  title: Text(DatabaseUtil.getText('contractor'),
                      style: Theme.of(context)
                          .textTheme
                          .medium
                          .copyWith(color: AppColor.black)),
                  subtitle: (addIncidentMap['companyid'] == null ||
                          addIncidentMap['companyid'].toString().isEmpty)
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: tiniestSpacing),
                          child: Text(state.selectContractorName,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.black)),
                        ),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
