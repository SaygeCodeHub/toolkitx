import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../configs/app_dimensions.dart';

class AttachDocumentImageDialog extends StatelessWidget {
  final ImagePickerBloc imagePickerBloc;

  const AttachDocumentImageDialog({super.key, required this.imagePickerBloc});

  @override
  Widget build(BuildContext context) {
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
                            imagePickerBloc.isCamera = true;
                            imagePickerBloc.add(PickImage());
                            Navigator.pop(context);
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
                                  child: Icon(Icons.camera, size: 30)))),
                      const SizedBox(height: tiniestSpacing),
                      const Text(
                        StringConstants.kCamera,
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
                          imagePickerBloc.isCamera = false;
                          imagePickerBloc.add(PickImage());
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
                      Text(StringConstants.kGallery,
                          style: Theme.of(context)
                              .textTheme
                              .small
                              .copyWith(color: AppColor.black))
                    ])),
              ]))
        ]);
  }
}
