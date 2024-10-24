import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../configs/app_dimensions.dart';
import 'attach_document_image_dialog.dart';

class AttachDocumentAlertDialog extends StatelessWidget {
  final ImagePickerBloc imagePickerBloc;

  const AttachDocumentAlertDialog({super.key, required this.imagePickerBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
        builder: (context, state) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCardRadius),
              side: const BorderSide(color: AppColor.black)),
          actions: [
            Center(
                child: Text(StringConstants.kUploadFrom,
                    style: Theme.of(context).textTheme.medium)),
            const SizedBox(height: tiniestSpacing),
            IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                      padding: const EdgeInsets.all(xxTinierSpacing),
                      child: Column(children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AttachDocumentImageDialog(
                                        imagePickerBloc: imagePickerBloc);
                                  });
                            },
                            borderRadius:
                                BorderRadius.circular(kAlertDialogRadius),
                            child: Container(
                                width: kAlertDialogTogether,
                                height: kAlertDialogTogether,
                                decoration: BoxDecoration(
                                    color: AppColor.blueGrey,
                                    borderRadius: BorderRadius.circular(
                                        kAlertDialogRadius)),
                                child: const Center(
                                    child: Icon(Icons.image, size: 30)))),
                        const SizedBox(height: tiniestSpacing),
                        const Text(
                          StringConstants.kImage,
                        )
                      ])),
                  const VerticalDivider(
                      color: AppColor.grey,
                      width: kDividerWidth,
                      thickness: kDividerThickness,
                      indent: kDividerIndent,
                      endIndent: kDividerEndIndent),
                  Padding(
                      padding: const EdgeInsets.all(xxTinierSpacing),
                      child: Column(children: [
                        InkWell(
                          onTap: () {
                            imagePickerBloc.add(PickDocument());
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: kAlertDialogTogether,
                            height: kAlertDialogTogether,
                            decoration: BoxDecoration(
                                color: AppColor.blueGrey,
                                borderRadius:
                                    BorderRadius.circular(kAlertDialogRadius)),
                            child: const Center(
                                child: Icon(
                              Icons.drive_folder_upload,
                              size: 30,
                            )),
                          ),
                        ),
                        const SizedBox(height: tiniestSpacing),
                        Text(StringConstants.kDocument,
                            style: Theme.of(context)
                                .textTheme
                                .small
                                .copyWith(color: AppColor.black))
                      ]))
                ]))
          ]);
    });
  }
}
