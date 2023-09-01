import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../report_new_qm.dart';
import 'qm_contractor_list.dart';

class QualityManagementContractorListTile extends StatelessWidget {
  final Map reportNewQAMap;
  static String contractorName = '';

  const QualityManagementContractorListTile({
    Key? key,
    required this.reportNewQAMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        ReportNewQualityManagementContractorListChange(
            selectContractorName: contractorName,
            selectContractorId: (reportNewQAMap['companyid'] == null ||
                    reportNewQAMap['companyid'].isEmpty)
                ? ''
                : reportNewQAMap['companyid']));
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementContractorSelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementContractorSelected) {
            reportNewQAMap['companyid'] = state.selectContractorId;
            return Visibility(
              visible: ReportNewQA.isFromEdit != true,
              replacement: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QualityManagementContractorList(
                                    fetchQualityManagementMasterModel:
                                        state.fetchQualityManagementMasterModel,
                                    selectContractorId:
                                        state.selectContractorId,
                                    selectContractorName:
                                        state.selectContractorName)));
                  },
                  title: Text(DatabaseUtil.getText('contractor'),
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: tiniestSpacing),
                    child: Text(
                        (reportNewQAMap['companyid'] == null ||
                                reportNewQAMap['companyid'].toString().isEmpty)
                            ? ""
                            : state.selectContractorName,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(color: AppColor.black)),
                  ),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
              child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QualityManagementContractorList(
                                    fetchQualityManagementMasterModel:
                                        state.fetchQualityManagementMasterModel,
                                    selectContractorId:
                                        state.selectContractorId,
                                    selectContractorName:
                                        state.selectContractorName)));
                  },
                  title: Text(DatabaseUtil.getText('contractor'),
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600)),
                  subtitle: (reportNewQAMap['companyid'] == null ||
                          reportNewQAMap['companyid'].toString().isEmpty)
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
