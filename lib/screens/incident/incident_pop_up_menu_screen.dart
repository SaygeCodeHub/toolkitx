import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../configs/app_dimensions.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import 'category_screen.dart';
import 'widgets/incident_contractor_list_tile.dart';
import 'incident_add_comments_screen.dart';
import 'incident_mark_as_resolved_screen.dart';
import 'incident_status_screen.dart';

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
          context.read<ImagePickerBloc>().pickedImagesList.clear();
          context.read<ImagePickerBloc>().add(PickImageInitial());
          if (value == DatabaseUtil.getText('AddComments')) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentAddCommentsScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('EditIncident')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            CategoryScreen.addAndEditIncidentMap = incidentDetailsMap;
            IncidentContractorListTile.contractorName =
                (incidentDetailsModel.data!.companyname == "null")
                    ? ''
                    : incidentDetailsModel.data!.companyname;
            CategoryScreen.isFromEdit = true;
            Navigator.pushNamed(context, CategoryScreen.routeName);
          }
          if (value == DatabaseUtil.getText('Report')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentStatusScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('Acknowledge')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentStatusScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('DefineMitigation')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentStatusScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('ApproveMitigation')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentStatusScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('ImplementMitigation')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentStatusScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
          if (value == DatabaseUtil.getText('Markasresolved')) {
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncidentMarkAsResolvedScreen(
                    incidentListDatum: incidentListDatum,
                    incidentDetailsModel: incidentDetailsModel)));
          }
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
