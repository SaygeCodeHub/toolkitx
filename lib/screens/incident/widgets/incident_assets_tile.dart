import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/tickets/fetch_ticket_master_model.dart';
import '../../../utils/database_utils.dart';

class IncidentAssetsTile extends StatefulWidget {
  const IncidentAssetsTile({super.key, required this.addAndEditIncidentMap});

  final Map addAndEditIncidentMap;

  @override
  State<IncidentAssetsTile> createState() => _IncidentAssetsTileState();
}

class _IncidentAssetsTileState extends State<IncidentAssetsTile> {
  @override
  void initState() {
    context
        .read<ReportNewIncidentBloc>()
        .selectedAsset = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
      builder: (context, state) {
        if (state is IncidentAssetListFetched) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DatabaseUtil.getText('Assets'),
                  style: Theme
                      .of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: tinierSpacing),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    key: GlobalKey(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    title: context
                        .read<ReportNewIncidentBloc>()
                        .selectedAsset
                        .isNotEmpty
                        ? Text(
                        context
                            .read<ReportNewIncidentBloc>()
                            .selectedAsset)
                        : const Text(StringConstants.kSelect),
                    children: [
                      SizedBox(
                        height: kPermitEditSwitchingExpansionTileHeight,
                        child: MediaQuery(
                            data: MediaQuery.of(context)
                                .removePadding(removeTop: true),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.assetList.length,
                                itemBuilder: (context, listIndex) {
                                  return ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: xxTinierSpacing),
                                      title: Text(
                                          state.assetList[listIndex].name),
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<ReportNewIncidentBloc>()
                                              .selectedAsset =
                                          state.assetList[listIndex].name;
                                          widget.addAndEditIncidentMap[
                                          'assetid'] =
                                          state.assetList[listIndex].id;
                                        });
                                      });
                                })),
                      )
                    ]),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
