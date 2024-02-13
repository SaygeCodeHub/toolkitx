import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/screens/loto/loto_add_comment_screen.dart';
import 'package:toolkit/screens/loto/loto_upload_photos_screen.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../loto_assign_team_screen.dart';
import '../loto_assign_workfoce_screen.dart';
import '../loto_reject_screen.dart';

class LotoPopupMenuButton extends StatelessWidget {
  const LotoPopupMenuButton(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchLotoDetailsModel});

  final List popUpMenuItems;
  final FetchLotoDetailsModel fetchLotoDetailsModel;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText('assign_workforce')) {
            context.read<LotoDetailsBloc>().assignWorkforceDatum = [];
            context.read<LotoDetailsBloc>().lotoWorkforceReachedMax = false;
            LotoAssignWorkforceScreen.pageNo = 1;
            Navigator.pushNamed(context, LotoAssignWorkforceScreen.routeName,
                    arguments: fetchLotoDetailsModel.data.id)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex))
                    });
          }
          if (value == DatabaseUtil.getText('assign_team')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex))
                    });
          }
          if (value == DatabaseUtil.getText('AddComment')) {
            Navigator.pushNamed(context, LotoAddCommentScreen.routeName).then(
                (_) => {
                      context
                          .read<LotoDetailsBloc>()
                          .add(FetchLotoDetails(lotoTabIndex: 0))
                    });
          }
          if (value == DatabaseUtil.getText('UploadPhotos')) {
            Navigator.pushNamed(context, LotoUploadPhotosScreen.routeName).then(
                (_) => {
                      context
                          .read<LotoDetailsBloc>()
                          .add(FetchLotoDetails(lotoTabIndex: 0))
                    });
          }
          if (value == DatabaseUtil.getText('assign_team')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex))
                    });
          }
          if (value == DatabaseUtil.getText('Start')) {
            StartLotoScreen.isFromStartRemoveLoto = false;
            Navigator.pushNamed(context, StartLotoScreen.routeName).then((_) =>
                {
                  context
                      .read<LotoDetailsBloc>()
                      .add(FetchLotoDetails(lotoTabIndex: 0))
                });
          }
          if (value == DatabaseUtil.getText('StartRemoveLotoButton')) {
            StartLotoScreen.isFromStartRemoveLoto = true;
            Navigator.pushNamed(context, StartLotoScreen.routeName).then((_) =>
                {
                  context
                      .read<LotoDetailsBloc>()
                      .add(FetchLotoDetails(lotoTabIndex: 0))
                });
          }
          if (value ==
              DatabaseUtil.getText('assign _workforce_for_remove_loto')) {
            Navigator.pushNamed(context, LotoAssignWorkforceScreen.routeName)
                .then((_) => {
                      context
                          .read<LotoDetailsBloc>()
                          .add(FetchLotoDetails(lotoTabIndex: 0))
                    });
          }

          if (value == DatabaseUtil.getText('assign_team_for_remove_loto')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex))
                    });
          }
          if (value == DatabaseUtil.getText('Apply')) {
            showDialog(
                context: context,
                builder: (context) => BlocListener<LotoDetailsBloc,
                        LotoDetailsState>(
                    listener: (context, state) {
                      if (state is LotoApplying) {
                        ProgressBar.show(context);
                      } else if (state is LotoApplied) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(
                            context, StringConstants.kLotoApplied, '');
                        Navigator.pop(context);
                      } else if (state is LotoNotApplied) {
                        ProgressBar.dismiss(context);
                        showCustomSnackBar(context, state.getError, '');
                      }
                    },
                    child: AndroidPopUp(
                        titleValue: DatabaseUtil.getText('ApproveLotoTitle'),
                        contentValue:
                            DatabaseUtil.getText('removelotoremovemessage'),
                        onPrimaryButton: () {
                          context.read<LotoDetailsBloc>().add(ApplyLotoEvent());
                          context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                              lotoTabIndex: context
                                  .read<LotoDetailsBloc>()
                                  .lotoTabIndex));
                        })));
          }
          if (value == DatabaseUtil.getText('ApproveButton')) {
            showDialog(
                context: context,
                builder: (context) =>
                    BlocListener<LotoDetailsBloc, LotoDetailsState>(
                        listener: (context, state) {
                          if (state is LotoAccepting) {
                            ProgressBar.show(context);
                          } else if (state is LotoAccepted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(
                                context, StringConstants.kLotoAccepted, '');
                            Navigator.pop(context);
                          } else if (state is LotoNotAccepted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.getError, '');
                          }
                        },
                        child: AndroidPopUp(
                            titleValue:
                                DatabaseUtil.getText('ApproveLotoTitle'),
                            contentValue:
                                DatabaseUtil.getText('ApproveLotoMessage'),
                            onPrimaryButton: () {
                              context
                                  .read<LotoDetailsBloc>()
                                  .add(AcceptLotoEvent());
                              context.read<LotoDetailsBloc>().add(
                                  FetchLotoDetails(
                                      lotoTabIndex: context
                                          .read<LotoDetailsBloc>()
                                          .lotoTabIndex));
                            })));
          }
          if (value == DatabaseUtil.getText('RemoveLoto')) {
            showDialog(
                context: context,
                builder: (context) =>
                    BlocListener<LotoDetailsBloc, LotoDetailsState>(
                        listener: (context, state) {
                          if (state is LotoRemoving) {
                            ProgressBar.show(context);
                          } else if (state is LotoRemoved) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(
                                context, StringConstants.kLotoRemoved, '');
                            Navigator.pop(context);
                          } else if (state is LotoNotRemoved) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.getError, '');
                          }
                        },
                        child: AndroidPopUp(
                            titleValue:
                                DatabaseUtil.getText('ApproveLotoTitle'),
                            contentValue:
                                DatabaseUtil.getText('removelotoremovemessage'),
                            onPrimaryButton: () {
                              context
                                  .read<LotoDetailsBloc>()
                                  .add(RemoveLotoEvent());
                              context.read<LotoDetailsBloc>().add(
                                  FetchLotoDetails(
                                      lotoTabIndex: context
                                          .read<LotoDetailsBloc>()
                                          .lotoTabIndex));
                            })));
          }
          if (value == DatabaseUtil.getText('RejectButton')) {
            Navigator.pushNamed(context, LotoRejectScreen.routeName);
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
