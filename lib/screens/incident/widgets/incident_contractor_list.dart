import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../widgets/generic_app_bar.dart';

class IncidentContractorList extends StatelessWidget {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectContractorId;
  final String selectContractorName;

  const IncidentContractorList(
      {super.key,
      required this.fetchIncidentMasterModel,
      required this.selectContractorId,
      required this.selectContractorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectContractor),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: fetchIncidentMasterModel
                            .incidentMasterDatum![8].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(fetchIncidentMasterModel
                                  .incidentMasterDatum![8][index].groupName!),
                              value: fetchIncidentMasterModel
                                  .incidentMasterDatum![8][index].groupId!
                                  .toString(),
                              groupValue: selectContractorId,
                              onChanged: (value) {
                                context.read<ReportNewIncidentBloc>().add(
                                    ReportNewIncidentContractorListChange(
                                        selectContractorName:
                                            fetchIncidentMasterModel
                                                .incidentMasterDatum![8][index]
                                                .groupName!,
                                        selectContractorId:
                                            fetchIncidentMasterModel
                                                .incidentMasterDatum![8][index]
                                                .groupId!
                                                .toString()));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
