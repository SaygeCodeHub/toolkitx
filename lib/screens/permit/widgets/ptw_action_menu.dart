import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/accept_permit_request_screen.dart';
import 'package:toolkit/screens/permit/clear_permit_screen.dart';
import 'package:toolkit/screens/permit/permit_edit_safety_document_screen.dart';
import 'package:toolkit/screens/permit/permit_transfer_component_screen.dart';
import 'package:toolkit/screens/permit/prepare_permit_screen.dart';
import 'package:toolkit/screens/permit/surrender_permit_screen.dart';
import 'package:toolkit/screens/permit/transfer_permit_offline_screen.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/screens/permit/surrender_permit_screen.dart';
import '../../../../../configs/app_spacing.dart';
import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/view_offline_permit_screen.dart';
import '../close_permit_screen.dart';
import '../open_permit_screen.dart';

class PTWActionMenu extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;
  final List popUpMenuItems;
  final String permitId;

  const PTWActionMenu(
      {Key? key,
      required this.permitDetailsModel,
      required this.popUpMenuItems,
      required this.permitId})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
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
        offset: const Offset(0, xxTiniestSpacing),
        onSelected: (value) {
          if (popUpMenuItems[value] == StringConstants.kGeneratePdf) {
            if (isNetworkEstablished) {
              context.read<PermitBloc>().add(GeneratePDF(permitId));
            } else {
              Navigator.pushNamed(context, OfflineHtmlViewerScreen.routeName,
                  arguments: permitId);
            }
          } else if (popUpMenuItems[value] == StringConstants.kClosePermit) {
            Navigator.pushNamed(context, ClosePermitScreen.routeName,
                    arguments: permitDetailsModel)
                .then((value) => context
                    .read<PermitBloc>()
                    .add(GetPermitDetails(permitId: permitId)));
          } else if (popUpMenuItems[value] == StringConstants.kOpenPermit) {
            Navigator.pushNamed(context, OpenPermitScreen.routeName,
                    arguments: permitDetailsModel)
                .then((value) => context
                    .read<PermitBloc>()
                    .add(GetPermitDetails(permitId: permitId)));
          } else if (popUpMenuItems[value] == StringConstants.kRequestPermit) {
            context.read<PermitBloc>().add(RequestPermit(permitId));
          }
          if (popUpMenuItems[value] == StringConstants.kPreparePermit) {
            Navigator.of(context)
                .pushNamed(PreparePermitScreen.routeName, arguments: permitId);
          }
          if (popUpMenuItems[value] == StringConstants.kAcceptPermitRequest) {
            Navigator.of(context).pushNamed(AcceptPermitRequestScreen.routeName,
                arguments: permitDetailsModel);
          }
          if (popUpMenuItems[value] == StringConstants.kClearPermitRequest) {
            Navigator.of(context)
                .pushNamed(ClearPermitScreen.routeName, arguments: permitId);
          }
          if (popUpMenuItems[value] == StringConstants.kEditSafetyDocument) {
            Navigator.of(context).pushNamed(
                PermitEditSafetyDocumentScreen.routeName,
                arguments: permitId);
          }
          if (popUpMenuItems[value] == StringConstants.kSurrenderPermit) {
            Navigator.of(context).pushNamed(SurrenderPermitScreen.routeName,
                arguments: permitDetailsModel);
          }
          if (popUpMenuItems[value] ==
              StringConstants.kTransferComponentPerson) {
            if (isNetworkEstablished) {
              Navigator.of(context).pushNamed(
                  PermitTransferComponentScreen.routeName,
                  arguments: permitId);
            } else {
              Navigator.of(context).pushNamed(
                  TransferPermitOfflineScreen.routeName,
                  arguments: permitDetailsModel);
            }
          }
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuItems.length; i++)
                _buildPopupMenuItem(context, popUpMenuItems[i], i)
            ]);
  }
}
