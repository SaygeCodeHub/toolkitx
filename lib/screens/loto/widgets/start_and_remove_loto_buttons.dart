import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../blocs/uploadImage/upload_image_event.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';


class StartAndRemoveLotoButtons extends StatelessWidget {
  const StartAndRemoveLotoButtons({
    super.key,
    required this.startLotoMap,
  });

  final Map startLotoMap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context
          .read<LotoDetailsBloc>()
          .checklistArrayIdList
          .length ==
          1 ||
          context
              .read<LotoDetailsBloc>()
              .checklistArrayIdList
              .isEmpty,
      replacement: PrimaryButton(
          onPressed: () {
            if (startLotoMap['pickedImage'] != null &&
                startLotoMap['pickedImage']
                    .isNotEmpty) {
              context.read<UploadImageBloc>().add(
                  UploadImage(
                      images:
                      startLotoMap['pickedImage'],
                      imageLength: context
                          .read<ImagePickerBloc>()
                          .lengthOfImageList));
            } else {
              context.read<LotoDetailsBloc>().answerList.removeWhere((map) => map.isEmpty);
              context
                  .read<LotoDetailsBloc>()
                  .add(SaveLotoChecklist());
            }
          },
          textValue:
          DatabaseUtil.getText("nextButtonText")),
      child: PrimaryButton(
          onPressed: () {
            if (startLotoMap['pickedImage'] != null &&
                startLotoMap['pickedImage']
                    .isNotEmpty) {
              context.read<UploadImageBloc>().add(
                  UploadImage(
                      images:
                      startLotoMap['pickedImage'],
                      imageLength: context
                          .read<ImagePickerBloc>()
                          .lengthOfImageList));
            } else {
              context.read<LotoDetailsBloc>().answerList.removeWhere((map) => map.isEmpty);
              context
                  .read<LotoDetailsBloc>()
                  .add(StartLotoEvent());
            }
          },
          textValue: DatabaseUtil.getText(
              "StartLotoButton")),
    );
  }
}