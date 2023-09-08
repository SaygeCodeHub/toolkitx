import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/certificates/uploadCertificates/upload_certificate_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';
import '../incident/widgets/date_picker.dart';

class UploadCertificateScreen extends StatelessWidget {
  static const routeName = 'UploadCertificateScreen';
  final Map certificateItemsMap;

  UploadCertificateScreen({
    super.key,
    required this.certificateItemsMap,
  });

  final Map uploadCertificateMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: AppBar(
          title: Text(
        certificateItemsMap['title'],
        style: const TextStyle(color: AppColor.black),
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: xxxSmallestSpacing,
            right: xxxSmallestSpacing,
            top: xxTinySpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.kStartDate,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DatePickerTextField(
                    editDate: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    hintText: DatabaseUtil.getText('Date'),
                    onDateChanged: (String date) {
                      uploadCertificateMap['startdate'] = date;
                    }),
              ),
              const SizedBox(
                height: xxTinySpacing,
              ),
              Text(
                StringConstants.kExpiryDate ,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black),
              ),
              DatePickerTextField(
                  editDate: DateFormat('dd MMM yyyy').format(DateTime.now()),
                  hintText: DatabaseUtil.getText('Date'),
                  onDateChanged: (String date) {
                    uploadCertificateMap['enddate'] = date;
                  }),
              const SizedBox(
                height: tinySpacing,
              ),
              UploadImageMenu(
                isFromCertificate: true,
                onUploadImageResponse: (List uploadCertificateList) {
                  uploadCertificateMap['name'] = uploadCertificateList
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "");
                },
              ),
              const SizedBox(
                height: xxMediumSpacing,
              ),
              BlocListener<UploadCertificateBloc, UploadCertificateState>(
                listener: (context, state) {
                  if (state is UploadCertificateSaving) {
                    ProgressBar.show(context);
                  } else if (state is UploadCertificateSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, StringConstants.kCertificateUploaded, '');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else if (state is CertificateApprovalPending) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, state.certificateApprovalPending, '');
                    Navigator.pop(context);
                  } else if (state is UploadCertificateNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, StringConstants.kFillAllDetails, '');
                  }
                },
                child: PrimaryButton(
                    onPressed: () {
                      uploadCertificateMap['certificateid'] =
                          certificateItemsMap['id'];
                      context
                          .read<UploadCertificateBloc>()
                          .add(UploadCertificates(uploadCertificateMap));
                    },
                    textValue: StringConstants.kSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
