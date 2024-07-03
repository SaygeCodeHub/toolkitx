import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_event.dart';
import 'package:toolkit/blocs/checklist/workforce/rejectReason/workforce_checklist_reject_reason_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WorkForceViewDocumentsScreen extends StatelessWidget {
  static const routeName = 'WorkForceViewDocumentsScreen';

  const WorkForceViewDocumentsScreen(
      {super.key, required this.checklistDataMap});

  final Map checklistDataMap;

  @override
  Widget build(BuildContext context) {
    context.read<WorkForceCheckListSaveRejectBloc>().add(
        FetchChecklistWorkforceDocuments(
            checklistId: checklistDataMap['checklistId']));
    return Scaffold(
      appBar: GenericAppBar(title: checklistDataMap['name']),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        child: BlocBuilder<WorkForceCheckListSaveRejectBloc,
            WorkForceCheckListRejectReasonStates>(
          builder: (context, state) {
            if (state is ChecklistWorkforceDocumentsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChecklistWorkforceDocumentsFetched) {
              var data = state.fetchChecklistWorkforceDocumentsModel.data;
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    String files = state.fetchChecklistWorkforceDocumentsModel
                        .data[index].files;
                    return CustomCard(
                        child: Padding(
                            padding: const EdgeInsets.all(xxTinierSpacing),
                            child: ListTile(
                                title: Text(data[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.mediumBlack)),
                                subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: xxTinierSpacing),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index].type),
                                          const SizedBox(
                                              height: xxTinierSpacing),
                                          ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  ViewImageUtil.viewImageList(
                                                          files)
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                    splashColor:
                                                        AppColor.transparent,
                                                    highlightColor:
                                                        AppColor.transparent,
                                                    onTap: () async {
                                                      launchUrlString(
                                                          '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(state.clientId)}',
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom:
                                                              xxxTinierSpacing),
                                                      child: Text(
                                                          ViewImageUtil
                                                              .viewImageList(
                                                                  files)[index],
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .deepBlue)),
                                                    ));
                                              }),
                                          const SizedBox(
                                              height: xxTiniestSpacing)
                                        ])))));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  });
            } else if (state is ChecklistWorkforceDocumentsNotFetched) {
              return const Center(child: Text(StringConstants.kNoRecordsFound));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
