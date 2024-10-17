import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/workorder/widgets/offline/workorder_sap_model.dart';
import 'package:toolkit/utils/global.dart';

import '../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../blocs/uploadImage/upload_image_event.dart';
import '../../../blocs/uploadImage/upload_image_state.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_loading_popup.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../workorder_add_comments_screen.dart';
import 'offline/workorder_sign_as_user_screen.dart';

class WorkOrderSaveCommentsBottomBar extends StatelessWidget {
  const WorkOrderSaveCommentsBottomBar(
      {super.key, required this.addCommentsMap});

  final Map addCommentsMap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
              child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textValue: DatabaseUtil.getText('buttonBack'),
          )),
          const SizedBox(width: xxTinierSpacing),
          MultiBlocListener(
            listeners: [
              BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
                listener: (context, state) {
                  if (state is SavingWorkOrderComments) {
                    ProgressBar.show(context);
                  } else if (state is WorkOrderCommentsSaved) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    context.read<WorkOrderTabDetailsBloc>().add(
                        WorkOrderDetails(
                            initialTabIndex: 4,
                            workOrderId: addCommentsMap['workorderId']));
                  } else if (state is WorkOrderCommentsNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.commentsNotSaved, '');
                  }
                },
              ),
              BlocListener<UploadImageBloc, UploadImageState>(
                listener: (context, state) {
                  if (state is UploadingImage) {
                    GenericLoadingPopUp.show(
                        context, StringConstants.kUploadFiles);
                  } else if (state is ImageUploaded) {
                    GenericLoadingPopUp.dismiss(context);
                    addCommentsMap['ImageString'] = state.images
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '');
                    context.read<WorkOrderTabDetailsBloc>().add(
                        SaveWorkOrderComments(addCommentsMap: addCommentsMap));
                  } else if (state is ImageCouldNotUpload) {
                    GenericLoadingPopUp.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
              ),
            ],
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    if (isNetworkEstablished) {
                      if (addCommentsMap['pickedImage'] != null &&
                          addCommentsMap['pickedImage'].isNotEmpty) {
                        context.read<UploadImageBloc>().add(UploadImage(
                            images: addCommentsMap['pickedImage'],
                            imageLength: context
                                .read<ImagePickerBloc>()
                                .lengthOfImageList));
                      }
                      context.read<WorkOrderTabDetailsBloc>().add(
                          SaveWorkOrderComments(
                              addCommentsMap: addCommentsMap));
                    } else {
                      if (addCommentsMap['comments'] == null ||
                          addCommentsMap['comments'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kPleaseAddComments, '');
                      } else {
                        Navigator.pushNamed(
                            context, WorkOrderSignAsUserScreen.routeName,
                            arguments: WorkOrderSapModel(
                                sapMap: addCommentsMap,
                                previousScreen:
                                    WorkOrderAddCommentsScreen.routeName));
                      }
                    }
                  },
                  textValue: StringConstants.kSave),
            ),
          ),
        ],
      ),
    );
  }
}
