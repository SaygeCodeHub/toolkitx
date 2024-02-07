import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/qualityManagement/widgets/qm_mark_as_resolved_screen.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../utils/database_utils.dart';
import 'qm_add_comments_screen.dart';
import 'report_new_qm.dart';
import 'widgets/qm_contractor_list_tile.dart';

class QualityManagementPopUpMenuScreen extends StatelessWidget {
  final List popUpMenuItems;
  final QMDetailsData data;
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;
  final Map editQMDetailsMap;
  final String qmId;

  const QualityManagementPopUpMenuScreen(
      {Key? key,
      required this.popUpMenuItems,
      required this.data,
      required this.fetchQualityManagementDetailsModel,
      required this.editQMDetailsMap,
      required this.qmId})
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
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('Edit')) {
            ReportNewQA.isFromEdit = true;
            ReportNewQA.reportAndEditQMMap = editQMDetailsMap;
            QualityManagementContractorListTile.contractorName =
                (data.companyname != 'null') ? data.companyname : '';
            Navigator.pushNamed(context, ReportNewQA.routeName,
                    arguments: editQMDetailsMap)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('Report')) {
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('Acknowledge')) {
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('DefineMitigation')) {
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('ApproveMitigation')) {
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('ImplementMitigation')) {
            Navigator.pushNamed(
                    context, QualityManagementAddCommentsScreen.routeName,
                    arguments: fetchQualityManagementDetailsModel)
                .then((_) => context.read<QualityManagementBloc>().add(
                    FetchQualityManagementDetails(
                        qmId: qmId, initialIndex: 0)));
          }
          if (value == DatabaseUtil.getText('Markasresolved')) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QualityManagementMarkAsResolvedScreen(
                    fetchQualityManagementDetailsModel:
                        fetchQualityManagementDetailsModel)));
          }
          if (value == DatabaseUtil.getText('GenerateReport')) {
            context
                .read<QualityManagementBloc>()
                .add(GenerateQualityManagementPDF());
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
