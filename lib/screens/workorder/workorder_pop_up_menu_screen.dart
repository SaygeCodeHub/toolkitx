import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/workorder/workorder_add_parts_screen.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../blocs/workorder/workorder_bloc.dart';
import '../../blocs/workorder/workorder_events.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import 'widgets/assign_workforce_body.dart';
import 'workorder_add_and_edit_down_time_screen.dart';
import 'assign_workforce_screen.dart';
import 'start_workorder_screen.dart';
import 'workorder_add_comments_screen.dart';
import 'workorder_assign_document_screen.dart';
import 'workorder_add_mis_cost_screen.dart';
import '../../widgets/android_pop_up.dart';
import 'workorder_form_one_screen.dart';

class WorkOrderPopUpMenuScreen extends StatelessWidget {
  final List popUpMenuOptions;
  final Map workOrderDetailsMap;

  const WorkOrderPopUpMenuScreen(
      {Key? key,
      required this.popUpMenuOptions,
      required this.workOrderDetailsMap})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
        value: position,
        child: Text(title, style: Theme.of(context).textTheme.xSmall));
  }

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius)),
      iconSize: kIconSize,
      icon: const Icon(Icons.more_vert_outlined),
      offset: const Offset(0, xxTinierSpacing),
      onSelected: (value) {
        if (value == DatabaseUtil.getText('CreateSimillar')) {
          WorkOrderFormScreenOne.isSimilarWorkOrder = true;
          WorkOrderFormScreenOne.isFromEdit = false;
          Navigator.pushNamed(context, WorkOrderFormScreenOne.routeName,
              arguments: workOrderDetailsMap);
        }
        if (value == DatabaseUtil.getText('Edit')) {
          WorkOrderFormScreenOne.isFromEdit = true;

          Navigator.pushNamed(context, WorkOrderFormScreenOne.routeName,
              arguments: workOrderDetailsMap);
        }
        if (value == DatabaseUtil.getText('AddMiscCost')) {
          WorkOrderAddMisCostScreen.workOrderDetailsMap = workOrderDetailsMap;
          WorkOrderAddMisCostScreen.workOrderMasterDatum =
              context.read<WorkOrderBloc>().workOrderMasterDatum;
          WorkOrderAddMisCostScreen.isFromEdit = false;
          Navigator.pushNamed(context, WorkOrderAddMisCostScreen.routeName);
        }
        if (value == DatabaseUtil.getText('AddDowntime')) {
          WorkOrderAddAndEditDownTimeScreen
                  .addAndEditDownTimeMap['workorderId'] =
              workOrderDetailsMap['workorderId'];
          Navigator.pushNamed(
              context, WorkOrderAddAndEditDownTimeScreen.routeName);
        }
        if (value == DatabaseUtil.getText('Accept')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('AcceptWO'),
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<WorkOrderTabDetailsBloc>().add(
                          AcceptWorkOrder(
                              workOrderId:
                                  workOrderDetailsMap['workorderId'] ?? ''));
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('Reject')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('RejectWO'),
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<WorkOrderTabDetailsBloc>().add(
                          RejectWorkOrder(
                              workOrderId:
                                  workOrderDetailsMap['workorderId'] ?? ''));
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('Hold')) {
          showDialog(
              context: context,
              builder: (context) {
                return AndroidPopUp(
                    titleValue: DatabaseUtil.getText('OnHoldWO'),
                    contentValue: '',
                    onPrimaryButton: () {
                      context.read<WorkOrderTabDetailsBloc>().add(HoldWorkOrder(
                          workOrderId:
                              workOrderDetailsMap['workorderId'] ?? ''));
                      Navigator.pop(context);
                    });
              });
        }
        if (value == DatabaseUtil.getText('assign_workforce')) {
          AssignWorkForceBody.assignWorkForceMap['workorderId'] =
              workOrderDetailsMap['workorderId'] ?? '';
          context.read<WorkOrderTabDetailsBloc>().assignWorkForceDatum = [];
          Navigator.pushNamed(context, AssignWorkForceScreen.routeName);
        }
        if (value == DatabaseUtil.getText('AddParts')) {
          context.read<WorkOrderTabDetailsBloc>().addPartsDatum = [];
          Navigator.pushNamed(context, WorkOrderAddPartsScreen.routeName);
        }
        if (value == DatabaseUtil.getText('Start')) {
          StartWorkOrderScreen.startWorkOrderMap['workorderId'] =
              workOrderDetailsMap['workorderId'];
          Navigator.pushNamed(context, StartWorkOrderScreen.routeName);
        }
        if (value == DatabaseUtil.getText('AddDocuments')) {
          Navigator.pushNamed(context, WorkOrderAssignDocumentScreen.routeName);
        }
        if (value == DatabaseUtil.getText('AddComment')) {
          WorkOrderAddCommentsScreen.addCommentsMap['workorderId'] =
              workOrderDetailsMap['workorderId'];
          Navigator.pushNamed(context, WorkOrderAddCommentsScreen.routeName);
        }
      },
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        for (int i = 0; i < popUpMenuOptions.length; i++)
          _buildPopupMenuItem(context, popUpMenuOptions[i], popUpMenuOptions[i])
      ],
    );
  }
}
