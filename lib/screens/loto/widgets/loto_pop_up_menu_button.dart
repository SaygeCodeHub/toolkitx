import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/screens/loto/widgets/loto_assign_workforce_body.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../loto_assign_team_screen.dart';
import '../loto_assign_workfoce_screen.dart';

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
            context.read<LotoDetailsBloc>().lotoListReachedMax = false;
            LotoAssignWorkforceScreen.pageNo = 1;
            LotoAssignWorkforceBody.isFirst = true;
            Navigator.pushNamed(context, LotoAssignWorkforceScreen.routeName,
                arguments: fetchLotoDetailsModel.data.id);
          }
          if (value == DatabaseUtil.getText('assign_team')) {
            Navigator.pushNamed(context, LotoAssignTeamScreen.routeName);
          }
          if (value == DatabaseUtil.getText('Start')) {
            Navigator.pushNamed(context, StartLotoScreen.routeName);
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
                        showCustomSnackBar(
                            context, StringConstants.kSomethingWentWrong, '');
                      }
                    },
                    child: AndroidPopUp(
                        titleValue: StringConstants.kPleaseConfirm,
                        contentValue: StringConstants.kPleaseVerifyEverything,
                        onPrimaryButton: () {
                          context.read<LotoDetailsBloc>().add(ApplyLotoEvent());
                          context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                              lotTabIndex: context
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
                            showCustomSnackBar(context,
                                StringConstants.kSomethingWentWrong, '');
                          }
                        },
                        child: AndroidPopUp(
                            titleValue: StringConstants.kPleaseConfirm,
                            contentValue: StringConstants.kWantToApproveLoto,
                            onPrimaryButton: () {
                              context
                                  .read<LotoDetailsBloc>()
                                  .add(AcceptLotoEvent());
                              context.read<LotoDetailsBloc>().add(
                                  FetchLotoDetails(
                                      lotTabIndex: context
                                          .read<LotoDetailsBloc>()
                                          .lotoTabIndex));
                            })));
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
