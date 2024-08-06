import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';

class UploadPictureContainer extends StatelessWidget {
  final List imagePathsList;
  final String clientId;
  final ImagePickerBloc imagePickerBloc; // Accept the bloc as a parameter

  const UploadPictureContainer({
    Key? key,
    required this.imagePathsList,
    required this.clientId,
    required this.imagePickerBloc, // Initialize the bloc parameter
  }) : super(key: key);

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
                                imagePickerBloc.add(RemovePickedImage(
                                    pickedImagesList: imagePathsList,
                                    index: index));
                              });
                        });
                  }),
              subtitle: Image.file(File(imagePathsList[index])));
        });
  }
}
