import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../configs/app_dimensions.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/incident/incident_details_model.dart';
import 'category_screen.dart';
import 'widgets/incident_contractor_list_tile.dart';

class IncidentDetailsPopUpMenu extends StatelessWidget {
  final List popUpMenuItems;
  final IncidentListDatum incidentListDatum;
  final Map incidentDetailsMap;
  final IncidentDetailsModel incidentDetailsModel;

  const IncidentDetailsPopUpMenu(
      {Key? key,
      required this.popUpMenuItems,
      required this.incidentListDatum,
      required this.incidentDetailsMap,
      required this.incidentDetailsModel})
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
          if (value == DatabaseUtil.getText('AddComments')) {}
          if (value == DatabaseUtil.getText('EditIncident')) {
            CategoryScreen.addAndEditIncidentMap = incidentDetailsMap;
            IncidentContractorListTile.contractorName =
                (incidentDetailsModel.data!.companyname == "null")
                    ? ''
                    : incidentDetailsModel.data!.companyname;
            CategoryScreen.isFromEdit = true;
            Navigator.pushNamed(context, CategoryScreen.routeName);
          }
          if (value == DatabaseUtil.getText('Report')) {}
          if (value == DatabaseUtil.getText('Acknowledge')) {}
          if (value == DatabaseUtil.getText('DefineMitigation')) {}
          if (value == DatabaseUtil.getText('ApproveMitigation')) {}
          if (value == DatabaseUtil.getText('ImplementMitigation')) {}
          if (value == DatabaseUtil.getText('Markasresolved')) {}
          if (value == DatabaseUtil.getText('GenerateReport')) {
            context
                .read<IncidentDetailsBloc>()
                .add(GenerateIncidentPDF(incidentListDatum.id));
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
