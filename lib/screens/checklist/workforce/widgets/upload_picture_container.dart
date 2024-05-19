import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/generic_alphanumeric_generator_util.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';

class UploadPictureContainer extends StatelessWidget {
  final List imagePathsList;
  final String clientId;

  const UploadPictureContainer(
      {Key? key, required this.imagePathsList, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 4,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemCount: imagePathsList.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.cancel_outlined,
                      color: AppColor.errorRed, size: kIconSize),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AndroidPopUp(
                              titleValue: StringConstants.kDelete,
                              contentValue: StringConstants.kDeleteImage,
                              onPrimaryButton: () {
                                Navigator.pop(context);
                                context.read<ImagePickerBloc>().add(
                                    RemovePickedImage(
                                        pickedImagesList: imagePathsList,
                                        index: index));
                              });
                        });
                  }),
              subtitle: (imagePathsList[index].contains(".toolkitx"))
                  ? Image.file(File(imagePathsList[index]))
                  : InkWell(
                      splashColor: AppColor.transparent,
                      highlightColor: AppColor.transparent,
                      onTap: () {
                        launchUrlString(
                            '${ApiConstants.viewDocBaseUrl}${imagePathsList[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                            mode: LaunchMode.inAppWebView);
                      },
                      child: CachedNetworkImage(
                          height: kUploadImageHeight,
                          imageUrl:
                              '${ApiConstants.viewDocBaseUrl}${imagePathsList[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColor.paleGrey,
                              highlightColor: AppColor.white,
                              child: Container(
                                  height: kNetworkImageContainerTogether,
                                  width: kNetworkImageContainerTogether,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius:
                                          BorderRadius.circular(kCardRadius)))),
                          errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline_sharp,
                              size: kIconSize))));
        });
  }
}
