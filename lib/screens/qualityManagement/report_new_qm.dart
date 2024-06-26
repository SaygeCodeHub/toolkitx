import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/utils/incident_view_image_util.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import '../incident/widgets/date_picker.dart';
import '../incident/widgets/time_picker.dart';
import 'widgets/qm_bottom_navigation_bar.dart';
import 'widgets/qm_contractor_list_tile.dart';
import 'widgets/qm_report_anonymously_expansion_tile.dart';

class ReportNewQA extends StatelessWidget {
  static const routeName = 'ReportNewQA';
  static bool isFromEdit = false;

  const ReportNewQA({super.key});

  static Map reportAndEditQMMap = {};
  static String eventDate = '';

  @override
  Widget build(BuildContext context) {
    context.read<ImagePickerBloc>().add(PickImageInitial());
    context
        .read<QualityManagementBloc>()
        .add(FetchQualityManagementMaster(reportNewQAMap: reportAndEditQMMap));
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
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
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinySpacing),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DatabaseUtil.getText('HideMyIdentity'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              ReportAnonymouslyExpansionTile(
                                  reportNewQAMap: reportAndEditQMMap),
                              const SizedBox(height: xxxTinierSpacing),
                              QualityManagementContractorListTile(
                                  reportNewQAMap: reportAndEditQMMap),
                              const SizedBox(height: xxTinySpacing),
                              Text(DatabaseUtil.getText('Date'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              Visibility(
                                visible: ReportNewQA.isFromEdit != true &&
                                    reportAndEditQMMap['eventdatetime'] == null,
                                replacement: Text(
                                    (reportAndEditQMMap['eventdatetime'] ==
                                            null)
                                        ? ""
                                        : reportAndEditQMMap['eventdatetime']
                                            .toString()
                                            .substring(0, 10)),
                                child: DatePickerTextField(
                                  hintText: StringConstants.kSelectDate,
                                  onDateChanged: (String date) {
                                    eventDate = date;
                                  },
                                ),
                              ),
                              const SizedBox(height: xxTinySpacing),
                              Text(StringConstants.kTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              Visibility(
                                visible: ReportNewQA.isFromEdit != true &&
                                    reportAndEditQMMap['eventdatetime'] == null,
                                replacement: Text(
                                    (reportAndEditQMMap['eventdatetime'] ==
                                            null)
                                        ? ""
                                        : reportAndEditQMMap['eventdatetime']
                                            .toString()
                                            .substring(12, 19)),
                                child: TimePickerTextField(
                                  hintText: StringConstants.kSelectTime,
                                  onTimeChanged: (String time) {
                                    reportAndEditQMMap['eventdatetime'] =
                                        '$eventDate $time';
                                  },
                                ),
                              ),
                              const SizedBox(height: xxTinySpacing),
                              Text(StringConstants.kDetailedDescription,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              TextFieldWidget(
                                  value: (ReportNewQA.isFromEdit == true &&
                                          reportAndEditQMMap['description'] !=
                                              null)
                                      ? reportAndEditQMMap['description']
                                      : '',
                                  maxLength: 250,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.text,
                                  onTextFieldChanged: (String textField) {
                                    reportAndEditQMMap['description'] =
                                        textField;
                                  }),
                              const SizedBox(height: xxTinySpacing),
                              Visibility(
                                visible: isFromEdit == true,
                                child: Text(DatabaseUtil.getText('viewimage'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(height: xxxTinierSpacing),
                              Visibility(
                                visible: reportAndEditQMMap['files'] != null,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: ViewImageUtil.viewImageList(
                                            reportAndEditQMMap['files'] ?? '')
                                        .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          splashColor: AppColor.transparent,
                                          highlightColor: AppColor.transparent,
                                          onTap: () {
                                            launchUrlString(
                                                '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(reportAndEditQMMap['files'] ?? '')[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(state.clientId)}',
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: xxxTinierSpacing),
                                            child: Text(
                                                ViewImageUtil.viewImageList(
                                                    reportAndEditQMMap[
                                                            'files'] ??
                                                        '')[index],
                                                style: const TextStyle(
                                                    color: AppColor.deepBlue)),
                                          ));
                                    }),
                              ),
                              const SizedBox(height: xxTinySpacing),
                              UploadImageMenu(
                                isUpload: true,
                                onUploadImageResponse: (List uploadImageList) {
                                  reportAndEditQMMap['pickedImage'] =
                                      uploadImageList;
                                },
                              ),
                              const SizedBox(height: xxTinySpacing),
                            ])));
              } else if (state is QualityManagementMasterNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context.read<QualityManagementBloc>().add(
                          FetchQualityManagementMaster(
                              reportNewQAMap: reportAndEditQMMap));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox.shrink();
              }
            }),
        bottomNavigationBar:
            NewQMReportingBottomBar(reportNewQAMap: reportAndEditQMMap));
  }
}
