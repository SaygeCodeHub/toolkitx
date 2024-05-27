import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../blocs/qualityManagement/qm_states.dart';
import '../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../blocs/uploadImage/upload_image_event.dart';
import '../../../blocs/uploadImage/upload_image_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../qm_location_screen.dart';

class NewQMReportingBottomBar extends StatelessWidget {
  final Map reportNewQAMap;

  const NewQMReportingBottomBar({
    super.key,
    required this.reportNewQAMap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  if (state
                      is ReportNewQualityManagementDateTimeDescValidated) {
                    showCustomSnackBar(
                        context, state.dateTimeDescValidationMessage, '');
                  } else if (state
                      is ReportNewQualityManagementDateTimeDescValidationComplete) {
                    Navigator.pushNamed(
                        context, QualityManagementLocationScreen.routeName,
                        arguments: reportNewQAMap);
                  }
                },
              ),
              BlocListener<UploadImageBloc, UploadImageState>(
                listener: (context, state) {
                  if (state is UploadingImage) {
                    GenericLoadingPopUp.show(
                        context, StringConstants.kUploadFiles);
                  } else if (state is ImageUploaded) {
                    GenericLoadingPopUp.dismiss(context);
                    reportNewQAMap['ImageString'] = state.images
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '');
                    context.read<QualityManagementBloc>().add(
                        ReportNewQualityManagementDateTimeDescriptionValidation(
                            reportNewQAMap: reportNewQAMap));
                  } else if (state is ImageCouldNotUpload) {
                    GenericLoadingPopUp.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
              ),
            ],
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    if (reportNewQAMap['pickedImage'] != null &&
                        reportNewQAMap['pickedImage'].isNotEmpty) {
                      context.read<UploadImageBloc>().add(UploadImage(
                          images: reportNewQAMap['pickedImage'],
                          imageLength: context
                              .read<ImagePickerBloc>()
                              .lengthOfImageList));
                    } else {
                      context.read<QualityManagementBloc>().add(
                          ReportNewQualityManagementDateTimeDescriptionValidation(
                              reportNewQAMap: reportNewQAMap));
                    }
                  },
                  textValue: DatabaseUtil.getText('nextButtonText')),
            ),
          ),
        ],
      ),
    );
  }
}
