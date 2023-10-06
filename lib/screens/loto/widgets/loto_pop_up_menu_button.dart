import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/screens/loto/widgets/loto_assign_workforce_body.dart';
import 'package:toolkit/screens/loto/widgets/start_loto_screen.dart';
import '../../../utils/database_utils.dart';
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
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
