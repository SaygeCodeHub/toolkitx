
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../../blocs/pickAndUploadImage/pick_and_upload_image_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';

class SafetyNoticeImageCount extends StatelessWidget {
  const SafetyNoticeImageCount({Key? key, required this.imageLength}) : super(key: key);
  final int imageLength;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickAndUploadImageBloc, PickAndUploadImageStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ImagePickerLoaded,
        builder: (context, state) {
          if (state is ImagePickerLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringConstants.kPhoto,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                Text(
                    '${(context.read<PickAndUploadImageBloc>().isInitialUpload == true) ? imageLength : state.incrementNumber + imageLength}/6',
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringConstants.kUploadPhoto,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                Text('$imageLength/6',
                    style: Theme.of(context).textTheme.small.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w500)),
              ],
            );
          }
        });
  }
}
