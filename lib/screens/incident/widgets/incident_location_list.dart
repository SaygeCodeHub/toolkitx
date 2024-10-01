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
  final Map addIncidentMap;

  const IncidentLocationList({
    Key? key,
    required this.fetchIncidentMasterModel,
    required this.selectLocationName,
    required this.addIncidentMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(FetchIncidentLocations(
        siteId: context.read<ReportNewIncidentBloc>().siteId,
        addIncidentMap['locationid'] ?? ''));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                bottom: leftRightMargin),
            child: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is IncidentLocationsFetching ||
                  currentState is IncidentLocationsFetched ||
                  currentState is IncidentLocationsNotFetched,
              builder: (context, state) {
                if (state is IncidentLocationsFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is IncidentLocationsFetched) {
                  var data = state.fetchIncidentLocationModel.data;
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColor.deepBlue,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(data[index].name),
                            value: data[index].name,
                            groupValue: selectLocationName,
                            onChanged: (value) {
                              value = data[index].name;
                              context
                                  .read<ReportNewIncidentBloc>()
                                  .add(ReportNewIncidentLocationChange(
                                    selectLocationName: data[index].name,
                                  ));
                              context
                                  .read<ReportNewIncidentBloc>()
                                  .selectedAsset = '';
                              context.read<ReportNewIncidentBloc>().add(
                                  SelectLocationId(locationId: data[index].id));
                              Navigator.pop(context);
                            });
                      });
                } else if (state is IncidentLocationsNotFetched) {
                  return const Center(
                      child: Text(StringConstants.kNoRecordsFound));
                }
                return const SizedBox.shrink();
              },
            )));
  }
}
