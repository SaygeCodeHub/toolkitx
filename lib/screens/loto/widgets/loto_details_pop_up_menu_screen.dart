// import 'package:flutter/material.dart';
// import 'package:toolkit/configs/app_theme.dart';
//
// import '../../../configs/app_dimensions.dart';
// import '../../../configs/app_spacing.dart';
// class LotoDetailsPopupMenu extends StatelessWidget {
//   const LotoDetailsPopupMenu({super.key});
//
//   PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
//     return PopupMenuItem(
//         value: position,
//         child: Text(title, style: Theme.of(context).textTheme.xSmall));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: PopupMenuButton(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(kCardRadius)),
//         iconSize: kIconSize,
//         icon: const Icon(Icons.more_vert_outlined),
//         offset: const Offset(0, xxTinierSpacing),
//         onSelected: (value) {
//           // if (value == DatabaseUtil.getText('AddComments')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentAddCommentsScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('EditIncident')) {
//           //   CategoryScreen.addAndEditIncidentMap = incidentDetailsMap;
//           //   IncidentContractorListTile.contractorName =
//           //   (incidentDetailsModel.data!.companyname == "null")
//           //       ? ''
//           //       : incidentDetailsModel.data!.companyname;
//           //   CategoryScreen.isFromEdit = true;
//           //   Navigator.pushNamed(context, CategoryScreen.routeName);
//           // }
//           // if (value == DatabaseUtil.getText('Report')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentStatusScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('Acknowledge')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentStatusScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('DefineMitigation')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentStatusScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('ApproveMitigation')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentStatusScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('ImplementMitigation')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentStatusScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('Markasresolved')) {
//           //   Navigator.of(context).push(MaterialPageRoute(
//           //       builder: (context) => IncidentMarkAsResolvedScreen(
//           //           incidentListDatum: incidentListDatum,
//           //           incidentDetailsModel: incidentDetailsModel)));
//           // }
//           // if (value == DatabaseUtil.getText('GenerateReport')) {
//           //   context
//           //       .read<IncidentDetailsBloc>()
//           //       .add(GenerateIncidentPDF(incidentListDatum.id));
//           // }
//         },
//         position: PopupMenuPosition.under,
//         itemBuilder: (BuildContext context) => [
//           for (int i = 0; i < popUpMenuItems.length; i++)
//             _buildPopupMenuItem(
//                 context, popUpMenuItems[i], popUpMenuItems[i])
//         ]));
//   }
// }
