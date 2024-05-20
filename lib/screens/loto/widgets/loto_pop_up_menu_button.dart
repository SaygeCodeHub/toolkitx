import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/screens/loto/loto_add_comment_screen.dart';
import 'package:toolkit/screens/loto/loto_upload_photos_screen.dart';
import 'package:toolkit/screens/loto/widgets/remove_loto_dialog.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_qr_scanner.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../loto_assign_team_screen.dart';
import '../loto_assign_workfoce_screen.dart';
import '../loto_reject_screen.dart';
import 'apply_loto_dialog.dart';
import 'approve_loto_dialog.dart';

class LotoPopupMenuButton extends StatelessWidget {
  const LotoPopupMenuButton(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchLotoDetailsModel,
      required this.decryptedLocation});

  final List popUpMenuItems;
  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final String decryptedLocation;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  void _startAndRemoveLoto(
      BuildContext context, String code, bool isFromRemove) {
    if (fetchLotoDetailsModel.data.location2.isNotEmpty ||
        fetchLotoDetailsModel.data.asset2.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomQRCodeScanner(
                    onCaptured: (qrCode) {
                      code = qrCode;
                    },
                    onPressed: () {
                      if (code == decryptedLocation) {
                        StartLotoScreen.isFromStartRemoveLoto = isFromRemove;
                        Navigator.pushReplacementNamed(
                                context, StartLotoScreen.routeName)
                            .then((_) => {
                                  context.read<LotoDetailsBloc>().add(
                                      FetchLotoDetails(
                                          lotoTabIndex: 0,
                                          lotoId:
                                              fetchLotoDetailsModel.data.id))
                                });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AndroidPopUp(
                                titleValue: StringConstants.kInvalidCode,
                                textValue: StringConstants.kOk,
                                isNoVisible: false,
                                contentValue: isFromRemove == true
                                    ? '${StringConstants.kPleaseScanRemoveLotoQR} ${fetchLotoDetailsModel.data.locname}'
                                    : '${StringConstants.kPleaseScanStartLotoQR} ${fetchLotoDetailsModel.data.locname}',
                                onPrimaryButton: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }));
                      }
                    },
                  )));
    } else {
      StartLotoScreen.isFromStartRemoveLoto = isFromRemove;
      Navigator.pushNamed(context, StartLotoScreen.routeName).then((_) => {
            context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                lotoTabIndex: 0, lotoId: fetchLotoDetailsModel.data.id))
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    String code = '';
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
                              context.read<LotoDetailsBloc>().lotoTabIndex,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('AddComment')) {
            Navigator.pushNamed(context, LotoAddCommentScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex: 0,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('UploadPhotos')) {
            Navigator.pushNamed(context, LotoUploadPhotosScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex: 0,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('assign_team')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('Start')) {
            _startAndRemoveLoto(context, code, false);
          }
          if (value == DatabaseUtil.getText('StartRemoveLotoButton')) {
            _startAndRemoveLoto(context, code, true);
          }
          if (value ==
              DatabaseUtil.getText('assign_workforce_for_remove_loto')) {
            Navigator.pushNamed(context, LotoAssignWorkforceScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex: 0,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('assign_team_for_remove_loto')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName)
                .then((_) => {
                      context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                          lotoTabIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex,
                          lotoId: fetchLotoDetailsModel.data.id))
                    });
          }
          if (value == DatabaseUtil.getText('Apply')) {
            showDialog(
                context: context,
                builder: (context) => const ApplyLotoDialog());
          }
          if (value == DatabaseUtil.getText('ApproveButton')) {
            showDialog(
                context: context,
                builder: (context) => const ApproveLotoDialog());
          }
          if (value == DatabaseUtil.getText('RemoveLoto')) {
            showDialog(
                context: context,
                builder: (context) => const RemoveLotoDialog());
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
