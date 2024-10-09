import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/secondary_button.dart';
import '../../checklist/workforce/widgets/upload_picture_container.dart';
import 'attach_document_alert_dialog.dart';

class AttachDocumentSection extends StatelessWidget {
  final Map docMap;
  final ImagePickerBloc imagePickerBloc;

  const AttachDocumentSection(
      {super.key, required this.docMap, required this.imagePickerBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Attached Documents',
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            Text('${docMap['imageCount']}/6',
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500))
          ],
        ),
        const SizedBox(height: xxTinierSpacing),
        UploadPictureContainer(
            imagePathsList: docMap['imageList'] ?? [],
            clientId: docMap['clientId'] ?? '',
            imagePickerBloc: imagePickerBloc,
            fileExtension: docMap['fileExtension'] ?? ''),
        SecondaryButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AttachDocumentAlertDialog(
                        imagePickerBloc: imagePickerBloc);
                  });
            },
            textValue: StringConstants.kUpload)
      ],
    );
  }
}
