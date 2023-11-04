import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets_get_downtime_model.dart';
import 'package:toolkit/screens/assets/widgets/assets_add_and_edit_downtime_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/assets/assets_bloc.dart';

class AssetsDowntimePopUpMenu extends StatelessWidget {
  const AssetsDowntimePopUpMenu(
      {super.key,
      required this.popUpMenuItems,
      required this.fetchAssetsDowntimeModel, required this.downtimeId});

  final List popUpMenuItems;
  final FetchAssetsDowntimeModel fetchAssetsDowntimeModel;
  final String downtimeId;

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == DatabaseUtil.getText("Edit")) {
            Navigator.pushNamed(context, AssetsAddAndEditDowntimeScreen.routeName,arguments: downtimeId,)
                .then((_) => {
            context.read<AssetsBloc>().add(FetchAssetsGetDownTime(
            assetId: context.read<AssetsBloc>().assetId, pageNo: 1))
            });
          }
          if (value == DatabaseUtil.getText("Delete")) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
