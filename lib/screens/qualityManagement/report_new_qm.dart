import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/widgets/error_section.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/qm_bottom_navigation_bar.dart';
import 'widgets/qm_new_reporting_body.dart';

class ReportNewQA extends StatelessWidget {
  static const routeName = 'ReportNewQA';

  ReportNewQA({Key? key}) : super(key: key);
  final Map reportNewQMMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(FetchQualityManagementMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('NewQAReporting')),
        body: BlocBuilder<QualityManagementBloc, QualityManagementStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingQualityManagementMaster ||
                currentState is QualityManagementMasterFetched ||
                currentState is QualityManagementMasterNotFetched,
            builder: (context, state) {
              if (state is FetchingQualityManagementMaster) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is QualityManagementMasterFetched) {
                return QMNewReportingBody(reportNewQMMap: reportNewQMMap);
              } else if (state is QualityManagementMasterNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context
                          .read<QualityManagementBloc>()
                          .add(FetchQualityManagementMaster());
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox.shrink();
              }
            }),
        bottomNavigationBar:
            NewQMReportingBottomBar(reportNewQAMap: reportNewQMMap));
  }
}
