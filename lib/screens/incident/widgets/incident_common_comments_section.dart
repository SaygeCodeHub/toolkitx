import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import '../../checklist/workforce/widgets/upload_image_section.dart';

typedef UploadListCallBack = Function(List uploadList);
typedef TextFieldListCallBack = Function(String textValue);

class IncidentCommonCommentsSection extends StatelessWidget {
  final UploadListCallBack onPhotosUploaded;
  final TextFieldListCallBack onTextFieldValue;

  const IncidentCommonCommentsSection(
      {Key? key,
      required this.onPhotosUploaded,
      required this.onTextFieldValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kComments,
              style: Theme.of(context).textTheme.small.copyWith(
                  color: AppColor.deepBlue, fontWeight: FontWeight.w500)),
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
                              color: AppColor.deepBlue,
                              fontWeight: FontWeight.w500)),
                      Text('${state.incrementNumber}/6',
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
                              color: AppColor.deepBlue,
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
            isFromIncident: true,
            onUploadImageResponse: (List uploadImageList) {
              onPhotosUploaded(uploadImageList);
            },
          ),
          const SizedBox(height: xxTinySpacing),
        ]));
  }
}
