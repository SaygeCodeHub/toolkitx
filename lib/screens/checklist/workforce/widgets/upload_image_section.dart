import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_state.dart';
import 'package:toolkit/widgets/pick_image_widget.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';

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
    context.read<ImagePickerBloc>().add(FetchImages());
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BlocBuilder<ImagePickerBloc, ImagePickerState>(
          buildWhen: (previousState, currentState) =>
              currentState is PickingImage ||
              currentState is ImagePicked ||
              currentState is FailedToPickImage ||
              currentState is ImagesFetched,
          builder: (context, state) {
            if (state is PickingImage) {
              return const Padding(
                padding: EdgeInsets.all(xxTinierSpacing),
                child: SizedBox(
                    width: kProgressIndicatorTogether,
                    height: kProgressIndicatorTogether,
                    child: CircularProgressIndicator()),
              );
            } else if (state is ImagePicked) {
              onUploadImageResponse(state.pickedImagesList);
              return PickImageWidget(imageMap: {
                'imageCount': state.imageCount,
                'imageList': state.pickedImagesList,
                'clientId': state.clientId,
                'isSignature': isSignature,
                'onSign': onSign
              });
            } else if (state is FailedToPickImage) {
              return Text(
                state.errText,
                style: const TextStyle(color: AppColor.errorRed),
              );
            } else if (state is ImagesFetched) {
              onUploadImageResponse(state.images);
              return PickImageWidget(imageMap: {
                'imageCount': state.imageCount,
                'imageList': state.images,
                'clientId': state.clientId,
                'isSignature': isSignature,
                'onSign': onSign
              });
            } else {
              return PickImageWidget(imageMap: {
                'imageCount': 0,
                'imageList': const [],
                'clientId': '',
                'isSignature': isSignature,
                'onSign': onSign
              });
            }
          })
    ]);
  }
}
