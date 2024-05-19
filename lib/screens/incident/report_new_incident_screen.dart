import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/incident_contractor_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_report_anonymously_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import 'category_screen.dart';
import 'widgets/report_new_incident_bottom_bar.dart';

class ReportNewIncidentScreen extends StatelessWidget {
  static const routeName = 'ReportNewIncidentScreen';
  final Map addAndEditIncidentMap;
  static String eventDate = '';
  static int imageIndex = 0;
  static String clientId = '';

  const ReportNewIncidentScreen({Key? key, required this.addAndEditIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List dateTimeList = addAndEditIncidentMap['eventdatetime']
        .toString()
        .replaceAll(' ', ',')
        .split(',');
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(
          title: StringConstants.kReportNewIncident,
        ),
        body: Padding(
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
                      IncidentReportAnonymousExpansionTile(
                          addIncidentMap: addAndEditIncidentMap),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kDateOfIncident,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      Visibility(
                        visible: CategoryScreen.isFromEdit != true ||
                            addAndEditIncidentMap['eventdatetime'] == null,
                        replacement: Text(
                            (addAndEditIncidentMap['eventdatetime'] == null)
                                ? ""
                                : dateTimeList[0]),
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
                        visible: CategoryScreen.isFromEdit != true ||
                            addAndEditIncidentMap['eventdatetime'] == null,
                        replacement: Text(
                            (addAndEditIncidentMap['eventdatetime'] == null)
                                ? ""
                                : dateTimeList[1]),
                        child: TimePickerTextField(
                          hintText: StringConstants.kSelectTime,
                          onTimeChanged: (String time) {
                            addAndEditIncidentMap['eventdatetime'] =
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
                          value: (CategoryScreen.isFromEdit == true &&
                                  addAndEditIncidentMap['description'] != null)
                              ? addAndEditIncidentMap['description']
                              : '',
                          maxLength: 250,
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          onTextFieldChanged: (String textField) {
                            addAndEditIncidentMap['description'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kUploadPhoto,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      UploadImageMenu(
                        isUpload: true,
                        onUploadImageResponse: (List uploadImageList) {
                          addAndEditIncidentMap['filenames'] = uploadImageList;
                        },
                      ),
                      const SizedBox(height: xxTinySpacing),
                      IncidentContractorListTile(
                          addIncidentMap: addAndEditIncidentMap),
                    ]))),
        bottomNavigationBar: ReportNewIncidentBottomBar(
            addAndEditIncidentMap: addAndEditIncidentMap));
  }
}
