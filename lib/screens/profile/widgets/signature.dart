import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signature/signature.dart';
import 'package:toolkit/blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/upload_image_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/api_constants.dart';

class SignaturePad extends StatefulWidget {
  final Map map;
  final String mapKey;

  const SignaturePad({Key? key, required this.map, required this.mapKey})
      : super(key: key);

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final SignatureController signController = SignatureController(
      penStrokeWidth: 3,
      penColor: AppColor.black,
      exportBackgroundColor: AppColor.white);

  saveSign() {
    signController.onDrawEnd = () async {
      widget.map[widget.mapKey] =
          'data:image/png;base64,${base64Encode(await signController.toPngBytes() as List<int>)}';
    };
  }

  bool showSignPad = false;
  bool newSign = false;
  String? croppedFilePath;

  @override
  void initState() {
    if (widget.map[widget.mapKey] == '' || widget.map[widget.mapKey] == null) {
      showSignPad = true;
      newSign = true;
    }
    saveSign();
    super.initState();
  }

  @override
  void dispose() {
    signController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(StringConstants.kSignature,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        if (showSignPad == true)
          IconButton(
              onPressed: () {
                signController.clear();
                widget.map[widget.mapKey] = '';
              },
              icon: const Icon(Icons.refresh),
              iconSize: kIconSize)
      ]),
      const SizedBox(height: xxxTinierSpacing),
      Container(
          decoration:
              BoxDecoration(border: Border.all(color: AppColor.lightGrey)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: (showSignPad == true)
                  ? Signature(
                      controller: signController,
                      width: double.infinity,
                      height: kSignaturePadHeight,
                      backgroundColor: AppColor.white)
                  : BlocBuilder<PickAndUploadImageBloc,
                      PickAndUploadImageStates>(builder: (context, state) {
                      if (state is ImagePickerLoaded) {
                        widget.map[widget.mapKey] =
                            'data:image/png;base64,${base64Encode(File(state.imagePath).readAsBytesSync())}';
                        return Image.file(File(state.imagePath));
                      }
                      if (state is PickImageLoading) {
                        return SizedBox(
                            height: kSignaturePadHeight,
                            child: Center(
                                child: Shimmer.fromColors(
                                    baseColor: AppColor.paleGrey,
                                    highlightColor: AppColor.white,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.circular(
                                                kCardRadius))))));
                      }
                      if (state is ImagePickerError) {
                        return Text(state.errorMessage,
                            style: const TextStyle(color: AppColor.errorRed));
                      } else {
                        if (croppedFilePath != null) {
                          return Image.file(File(croppedFilePath!),
                              width: double.infinity,
                              height: kSignaturePadHeight);
                        }
                        return CachedNetworkImage(
                            width: double.infinity,
                            height: kSignaturePadHeight,
                            imageUrl:
                                '${ApiConstants.baseDocUrl}${widget.map[widget.mapKey]}',
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColor.paleGrey,
                                highlightColor: AppColor.white,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(
                                            kCardRadius)))),
                            errorWidget: (context, url, error) => const Center(
                                child:
                                    Text(StringConstants.kSignatureNotFound)));
                      }
                    }))),
      (newSign == false)
          ? UploadImageMenu(
              imagePickerBloc: ImagePickerBloc(),
              onUploadImageResponse: (List uploadImageList) {},
              isSignature: true,
              removeSignPad: () {
                setState(() {
                  showSignPad = false;
                });
              },
              onSign: () {
                setState(() {
                  showSignPad = true;
                  Navigator.pop(context);
                });
              })
          : const SizedBox()
    ]);
  }
}
