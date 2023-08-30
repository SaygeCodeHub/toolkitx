import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import 'qm_contractor_list_tile.dart';
import 'qm_new_reporting_image_section.dart';
import 'qm_report_anonymously_expansion_tile.dart';

class QMNewReportingBody extends StatelessWidget {
  final Map reportNewQMMap;

  const QMNewReportingBody({Key? key, required this.reportNewQMMap})
      : super(key: key);
  static String eventDate = '';

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isUploadInitial = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Padding(
      padding: const EdgeInsets.only(
          left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
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
            ReportAnonymouslyExpansionTile(reportNewQAMap: reportNewQMMap),
            const SizedBox(height: xxxTinierSpacing),
            QualityManagementContractorListTile(reportNewQAMap: reportNewQMMap),
            const SizedBox(height: xxTinySpacing),
            Text(DatabaseUtil.getText('Date'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            DatePickerTextField(
              hintText: StringConstants.kSelectDate,
              onDateChanged: (String date) {
                eventDate = date;
              },
            ),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kTime,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TimePickerTextField(
              hintText: StringConstants.kSelectTime,
              onTimeChanged: (String time) {
                reportNewQMMap['eventdatetime'] = '$eventDate $time';
              },
            ),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kDetailedDescription,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            TextFieldWidget(
                maxLength: 250,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                onTextFieldChanged: (String textField) {
                  reportNewQMMap['description'] = textField;
                }),
            const SizedBox(height: xxTinySpacing),
            QMNewReportingImageSection(),
            const SizedBox(height: xxTinierSpacing),
            UploadImageMenu(
              isUpload: true,
              onUploadImageResponse: (List uploadImageList) {
                reportNewQMMap['filenames'] = uploadImageList
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", "");
              },
            ),
            const SizedBox(height: xxTinySpacing),
          ],
        ),
      ),
    );
  }
}
