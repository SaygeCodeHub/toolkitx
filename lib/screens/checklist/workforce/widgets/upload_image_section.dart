import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_state.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_picture_container.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/secondary_button.dart';
import '../../../../widgets/upload_alert_dialog.dart';
import '../../../safetyNotice/widgets/safety_notice_image_count.dart';

typedef UploadImageResponseCallBack = Function(List uploadImageList);

class UploadImageMenu extends StatelessWidget {
  final UploadImageResponseCallBack onUploadImageResponse;
  final void Function()? onSign;
  final void Function()? removeSignPad;
  final bool? showSignPad;
  final bool? isSignature;
  final bool? isUpload;
  final List uploadImageList = [];
  final bool? isFromCertificate;
  final List? editedImageList;

  UploadImageMenu(
      {Key? key,
      required this.onUploadImageResponse,
      this.onSign,
      this.isSignature = false,
      this.showSignPad = false,
      this.removeSignPad,
      this.isUpload = false,
      this.isFromCertificate = false,
      this.editedImageList = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BlocBuilder<ImagePickerBloc, ImagePickerState>(builder: (context, state) {
        if (state is PickingImage) {
          return const Padding(
            padding: EdgeInsets.all(xxTinierSpacing),
            child: SizedBox(
                width: kProgressIndicatorTogether,
                height: kProgressIndicatorTogether,
                child: CircularProgressIndicator()),
          );
        } else if (state is ImagePicked) {
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
                  Text('${state.imageCount.toString()}/6',
                      style: Theme.of(context).textTheme.small.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w500)),
                ],
              ),
              UploadPictureContainer(imagePathsList: state.pickedImagesList),
              SecondaryButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return UploadAlertDialog(
                            isSignature: isSignature,
                            onCamera: () {
                              // if (removeSignPad != null) {
                              //   removeSignPad!();
                              // }
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onDevice: () {
                              // if (removeSignPad != null) {
                              //   removeSignPad!();
                              // }
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onSign: onSign,
                          );
                        });
                  },
                  textValue: (isSignature == false)
                      ? StringConstants.kUpload
                      : StringConstants.kEditSignature),
            ],
          );
        } else if (state is FailedToPickImage) {
          return Text(
            state.errText,
            style: const TextStyle(color: AppColor.errorRed),
          );
        } else {
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
                  Text('0/6',
                      style: Theme.of(context).textTheme.small.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w500)),
                ],
              ),
              SecondaryButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return UploadAlertDialog(
                            isSignature: isSignature,
                            onCamera: () {
                              // if (removeSignPad != null) {
                              //   removeSignPad!();
                              // }
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onDevice: () {
                              // if (removeSignPad != null) {
                              //   removeSignPad!();
                              // }
                              context.read<ImagePickerBloc>().add(PickImage());
                              Navigator.pop(context);
                            },
                            onSign: onSign,
                          );
                        });
                  },
                  textValue: (isSignature == false)
                      ? StringConstants.kUpload
                      : StringConstants.kEditSignature),
            ],
          );
        }
      }),
    ]);
  }
}
