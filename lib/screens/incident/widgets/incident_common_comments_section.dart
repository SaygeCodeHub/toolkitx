import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';
import 'incident_classification_expansion_tile.dart';

typedef UploadListCallBack = Function(List uploadList);
typedef TextFieldListCallBack = Function(String textValue);

class IncidentCommonCommentsSection extends StatelessWidget {
  final UploadListCallBack onPhotosUploaded;
  final TextFieldListCallBack onTextFieldValue;
  final IncidentDetailsModel? incidentDetailsModel;
  final Map incidentCommentsMap;

  const IncidentCommonCommentsSection(
      {Key? key,
      required this.onPhotosUploaded,
      required this.onTextFieldValue,
      this.incidentDetailsModel,
      required this.incidentCommentsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Visibility(
            visible: incidentDetailsModel!.data!.nextStatus == '1',
            child: Text(DatabaseUtil.getText('Classification'),
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
          ),
          (incidentDetailsModel!.data!.nextStatus != '1')
              ? const SizedBox.shrink()
              : const SizedBox(height: xxTinierSpacing),
          Visibility(
              visible: incidentDetailsModel!.data!.nextStatus == '1',
              child: IncidentClassificationExpansionTile(
                  incidentCommentsMap: incidentCommentsMap)),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kComments,
              style: Theme.of(context).textTheme.small.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: xxTinierSpacing),
          TextFieldWidget(
              textInputAction: TextInputAction.done,
              maxLines: 6,
              maxLength: 250,
              onTextFieldChanged: (String textValue) {
                onTextFieldValue(textValue);
              }),
          const SizedBox(height: xxTinierSpacing),
          BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ImagePickerLoaded,
              builder: (context, state) {
                if (state is ImagePickerLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringConstants.kUploadPhoto,
                          style: Theme.of(context).textTheme.small.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500)),
                      Text('${(context.read<PickAndUploadImageBloc>().isInitialUpload == true) ? 0 : state.incrementNumber}/6',
                          style: Theme.of(context).textTheme.small.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500)),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringConstants.kUploadPhoto,
                          style: Theme.of(context).textTheme.small.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500)),
                      Text('0/6',
                          style: Theme.of(context).textTheme.small.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500)),
                    ],
                  );
                }
              }),
          const SizedBox(height: xxTinierSpacing),
          UploadImageMenu(
            isUpload: true,
            onUploadImageResponse: (List uploadImageList) {
              onPhotosUploaded(uploadImageList);
            },
          ),
          const SizedBox(height: xxTinySpacing),
        ]));
  }
}
