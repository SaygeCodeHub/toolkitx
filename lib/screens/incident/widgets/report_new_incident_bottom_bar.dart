import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../blocs/uploadImage/upload_image_event.dart';
import '../../../blocs/uploadImage/upload_image_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../incident_location_screen.dart';

class ReportNewIncidentBottomBar extends StatelessWidget {
  final Map addAndEditIncidentMap;

  const ReportNewIncidentBottomBar(
      {Key? key, required this.addAndEditIncidentMap})
      : super(key: key);

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
              BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
                listener: (context, state) {
                  if (state is ReportNewIncidentDateTimeDescValidated) {
                    showCustomSnackBar(
                        context, state.dateTimeDescValidationMessage, '');
                  } else if (state
                      is ReportNewIncidentDateTimeDescValidationComplete) {
                    Navigator.pushNamed(
                        context, IncidentLocationScreen.routeName,
                        arguments: addAndEditIncidentMap);
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
                    context.read<ReportNewIncidentBloc>().add(
                        ReportNewIncidentDateTimeDescriptionValidation(
                            reportNewIncidentMap: addAndEditIncidentMap));
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
                    if (addAndEditIncidentMap['filenames'] != null &&
                        addAndEditIncidentMap['filenames'].isNotEmpty) {
                      context.read<UploadImageBloc>().add(UploadImage(
                          images: addAndEditIncidentMap['filenames'],
                          imageLength: context
                              .read<ImagePickerBloc>()
                              .lengthOfImageList));
                    } else {
                      context.read<ReportNewIncidentBloc>().add(
                          ReportNewIncidentDateTimeDescriptionValidation(
                              reportNewIncidentMap: addAndEditIncidentMap));
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
