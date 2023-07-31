import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../utils/database_utils.dart';
import 'qm_add_comments_screen.dart';

class QualityManagementPopUpMenuScreen extends StatelessWidget {
  final List popUpMenuItems;
  final QMDetailsData data;
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;

  const QualityManagementPopUpMenuScreen(
      {Key? key,
      required this.popUpMenuItems,
      required this.data,
      required this.fetchQualityManagementDetailsModel})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius)),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, xxTinierSpacing),
        onSelected: (value) {
          if (value == DatabaseUtil.getText('AddComments')) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QualityManagementAddCommentsScreen(
                    fetchQualityManagementDetailsModel:
                        fetchQualityManagementDetailsModel,
                    data: data)));
          }
          if (value == DatabaseUtil.getText('EditIncident')) {}
          if (value == DatabaseUtil.getText('Report')) {}
          if (value == DatabaseUtil.getText('Acknowledge')) {}
          if (value == DatabaseUtil.getText('DefineMitigation')) {}
          if (value == DatabaseUtil.getText('ApproveMitigation')) {}
          if (value == DatabaseUtil.getText('ImplementMitigation')) {}
          if (value == DatabaseUtil.getText('Markasresolved')) {}
          if (value == DatabaseUtil.getText('GenerateReport')) {}
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuItems[i], popUpMenuItems[i])
            ]);
  }
}
