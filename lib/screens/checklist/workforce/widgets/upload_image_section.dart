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

class UploadImageMenu extends StatefulWidget {
  final UploadImageResponseCallBack onUploadImageResponse;
  final void Function()? onSign;
  final void Function()? removeSignPad;
  final bool? showSignPad;
  final bool? isSignature;
  final bool? isUpload;
  final bool? isFromCertificate;
  final List? editedImageList;
  final ImagePickerBloc? imagePickerBloc; // Pass the bloc as a parameter

  const UploadImageMenu({
    Key? key,
    required this.onUploadImageResponse,
    this.imagePickerBloc, // Initialize the bloc parameter
    this.onSign,
    this.isSignature = false,
    this.showSignPad = false,
    this.removeSignPad,
    this.isUpload = false,
    this.isFromCertificate = false,
    this.editedImageList = const [],
  }) : super(key: key);

  @override
  _UploadImageMenuState createState() => _UploadImageMenuState();
}

class _UploadImageMenuState extends State<UploadImageMenu> {
  late ImagePickerBloc _imagePickerBloc;

  @override
  void initState() {
    super.initState();
    _imagePickerBloc = widget.imagePickerBloc!;
    _imagePickerBloc.add(FetchImages());
  }

  @override
  void dispose() {
    _imagePickerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ImagePickerBloc, ImagePickerState>(
          bloc: _imagePickerBloc, // Pass the bloc directly to BlocBuilder
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
              widget.onUploadImageResponse(state.pickedImagesList);
              return PickImageWidget(
                imageMap: {
                  'imageCount': state.imageCount,
                  'imageList': state.pickedImagesList,
                  'clientId': state.clientId,
                  'isSignature': widget.isSignature,
                  'onSign': widget.onSign,
                },
                imagePickerBloc: _imagePickerBloc,
              );
            } else if (state is FailedToPickImage) {
              return Text(
                state.errText,
                style: const TextStyle(color: AppColor.errorRed),
              );
            } else if (state is ImagesFetched) {
              widget.onUploadImageResponse(state.images);
              return PickImageWidget(
                imageMap: {
                  'imageCount': state.imageCount,
                  'imageList': state.images,
                  'clientId': state.clientId,
                  'isSignature': widget.isSignature,
                  'onSign': widget.onSign,
                },
                imagePickerBloc: _imagePickerBloc,
              );
            } else {
              return PickImageWidget(
                imageMap: {
                  'imageCount': 0,
                  'imageList': const [],
                  'clientId': '',
                  'isSignature': widget.isSignature,
                  'onSign': widget.onSign,
                },
                imagePickerBloc: _imagePickerBloc,
              );
            }
          },
        )
      ],
    );
  }
}

