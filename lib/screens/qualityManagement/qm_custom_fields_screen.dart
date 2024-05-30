import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/qm_details_screen.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../utils/qm_custom_field_info_util.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'report_new_qm.dart';

class QualityManagementCustomFieldsScreen extends StatelessWidget {
  static const routeName = 'QualityManagementCustomFieldsScreen';
  final Map reportNewQAMap;
  static List customInfoFieldList = [];

  const QualityManagementCustomFieldsScreen(
      {Key? key, required this.reportNewQAMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    customInfoFieldList.clear();
    context
        .read<QualityManagementBloc>()
        .add(ReportNewQualityManagementFetchCustomInfoField());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kReportNewIncident),
      body: BlocBuilder<QualityManagementBloc, QualityManagementStates>(
          buildWhen: (previousState, currentState) =>
              currentState is ReportNewQualityManagementCustomFieldFetched,
          builder: (context, state) {
            if (state is ReportNewQualityManagementCustomFieldFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: xxTinySpacing),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.fetchQualityManagementMasterModel
                                .data![4].length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      state.fetchQualityManagementMasterModel
                                          .data![4][index].title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                  const SizedBox(height: xxxTinierSpacing),
                                  QualityManagementCustomFieldInfoUtil()
                                      .addCustomFieldsCaseWidget(
                                          index,
                                          state
                                              .fetchQualityManagementMasterModel
                                              .data![4],
                                          customInfoFieldList,
                                          reportNewQAMap),
                                  const SizedBox(height: xxTinySpacing),
                                ],
                              );
                            }),
                      ]),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          MultiBlocListener(
            listeners: [
              BlocListener<QualityManagementBloc, QualityManagementStates>(
                  listener: (context, state) {
                if (state is ReportNewQualityManagementSaving) {
                  ProgressBar.show(context);
                } else if (state is ReportNewQualityManagementSaved) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  context.read<QualityManagementBloc>().add(
                      FetchQualityManagementList(pageNo: 1, isFromHome: false));
                } else if (state is ReportNewQualityManagementNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, state.qualityManagementNotSavedMessage, '');
                }
              }),
              BlocListener<QualityManagementBloc, QualityManagementStates>(
                  listener: (context, state) {
                if (state is UpdatingQualityManagementDetails) {
                  ProgressBar.show(context);
                } else if (state is QualityManagementDetailsUpdated ||
                    state is ReportNewQualityManagementPhotoSaved) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, QualityManagementDetailsScreen.routeName,
                      arguments:
                          context.read<QualityManagementBloc>().encryptQmId);
                } else if (state is QualityManagementDetailsNotUpdated) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.editDetailsNotUpdated, '');
                }
              }),
            ],
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    if (ReportNewQA.isFromEdit == false) {
                      reportNewQAMap['customfields'] = customInfoFieldList;
                      context.read<QualityManagementBloc>().add(
                          SaveReportNewQualityManagement(
                              role: '', reportNewQAMap: reportNewQAMap));
                    } else {
                      reportNewQAMap['customfields'] = customInfoFieldList;
                      context.read<QualityManagementBloc>().add(
                          UpdateQualityManagementDetails(
                              editQMDetailsMap: reportNewQAMap));
                    }
                  },
                  textValue: DatabaseUtil.getText('buttonSave')),
            ),
          ),
        ],
      )),
    );
  }
}
