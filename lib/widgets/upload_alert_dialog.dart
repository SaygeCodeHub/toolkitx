import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../utils/constants/string_constants.dart';

class UploadAlertDialog extends StatelessWidget {
  final void Function() onCamera;
  final void Function() onDevice;
  final void Function()? onSign;
  final bool? isSignature;

  const UploadAlertDialog(
      {super.key,
      required this.onCamera,
      required this.onDevice,
      this.isSignature = false,
      this.onSign});

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
                child: Text(
                    (isSignature == false)
                        ? StringConstants.kUploadFrom
                        : StringConstants.kEditSignature,
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
                            onTap: onCamera,
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
                                    child: Icon(Icons.camera_alt_outlined,
                                        size: 30)))),
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
                          onTap: onDevice,
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
                        Text(StringConstants.kDevice,
                            style: Theme.of(context)
                                .textTheme
                                .small
                                .copyWith(color: AppColor.black))
                      ])),
                  if (isSignature == true)
                    const VerticalDivider(
                        color: AppColor.grey,
                        width: kDividerWidth,
                        thickness: kDividerThickness,
                        indent: kDividerIndent,
                        endIndent: kDividerEndIndent),
                  if (isSignature == true)
                    Padding(
                        padding: const EdgeInsets.all(xxTinierSpacing),
                        child: Column(children: [
                          InkWell(
                            onTap: onSign,
                            child: Container(
                              width: kAlertDialogTogether,
                              height: kAlertDialogTogether,
                              decoration: BoxDecoration(
                                  color: AppColor.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                      kAlertDialogRadius)),
                              child: const Center(
                                  child: Icon(
                                Icons.edit,
                                size: 30,
                              )),
                            ),
                          ),
                          const SizedBox(height: tiniestSpacing),
                          Text(StringConstants.kSignature,
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
