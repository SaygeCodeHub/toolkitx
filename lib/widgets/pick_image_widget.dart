import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_picture_container.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import 'package:toolkit/widgets/upload_alert_dialog.dart';

class PickImageWidget extends StatelessWidget {
  final Map imageMap;

  const PickImageWidget({super.key, required this.imageMap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(StringConstants.kPhoto,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            Text('${imageMap['imageCount']}/6',
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
          ],
        ),
        UploadPictureContainer(
            imagePathsList: imageMap['imageList'] ?? [],
            clientId: imageMap['clientId'] ?? ''),
        const SizedBox(height: xxTinierSpacing),
        SecondaryButton(
            onPressed: imageMap['imageCount'] != 6
                ? () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return UploadAlertDialog(
                            isSignature: imageMap['isSignature'],
                            onCamera: () {
                              context.read<ImagePickerBloc>().isCamera = true;
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onDevice: () {
                              context.read<ImagePickerBloc>().isCamera = false;
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onSign: imageMap['onSign'],
                          );
                        });
                  }
                : null,
            textValue: (imageMap['isSignature'] == false)
                ? StringConstants.kUpload
                : StringConstants.kEditSignature),
      ],
    );
  }
}
