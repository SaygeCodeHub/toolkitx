import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_app_bar.dart';

class IncidentSiteList extends StatelessWidget {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectSiteName;
  final String locationId;

  const IncidentSiteList(
      {super.key,
      required this.fetchIncidentMasterModel,
      required this.selectSiteName,
      required this.locationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectSite),
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
                            .incidentMasterDatum![0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(fetchIncidentMasterModel
                                  .incidentMasterDatum![0][index].name!),
                              value: fetchIncidentMasterModel
                                  .incidentMasterDatum![0][index].name!,
                              groupValue: selectSiteName,
                              onChanged: (value) {
                                value = fetchIncidentMasterModel
                                    .incidentMasterDatum![0][index].name!;
                                context.read<ReportNewIncidentBloc>().add(
                                    ReportIncidentSiteListChange(
                                        selectSiteName: fetchIncidentMasterModel
                                                .incidentMasterDatum![0][index]
                                                .name ??
                                            '',
                                        siteId: (value !=
                                                DatabaseUtil.getText('Other'))
                                            ? fetchIncidentMasterModel
                                                .incidentMasterDatum![0][index]
                                                .id!
                                            : 0,
                                        locationId: ''));

                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
