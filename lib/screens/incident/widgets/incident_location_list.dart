import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../widgets/generic_app_bar.dart';

class IncidentLocationList extends StatelessWidget {
  final FetchIncidentMasterModel fetchIncidentMasterModel;
  final String selectLocationName;

  const IncidentLocationList(
      {Key? key,
      required this.fetchIncidentMasterModel,
      required this.selectLocationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportNewIncidentBloc>()
        .add(FetchIncidentLocations(siteId: ''));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child:
                  BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is IncidentLocationsFetching ||
                    currentState is IncidentLocationsFetched ||
                    currentState is IncidentLocationsNotFetched,
                builder: (context, state) {
                  if (state is IncidentLocationsFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is IncidentLocationsFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: state.locationList.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColor.deepBlue,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title:
                                        Text(state.locationList[index]['name']),
                                    value: state.locationList[index]['name'],
                                    groupValue: selectLocationName,
                                    onChanged: (value) {
                                      value = state.locationList[index]['name'];
                                      context
                                          .read<ReportNewIncidentBloc>()
                                          .add(ReportNewIncidentLocationChange(
                                            selectLocationName: state
                                                .locationList[index]['name'],
                                          ));
                                      context.read<ReportNewIncidentBloc>().add(
                                          SelectLocationId(
                                              locationId: state
                                                  .locationList[index]['id']));
                                      Navigator.pop(context);
                                    });
                              }),
                          const SizedBox(height: xxxSmallerSpacing)
                        ]);
                  } else if (state is IncidentLocationsNotFetched) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  }
                  return const SizedBox.shrink();
                },
              )),
        ));
  }
}
