import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
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
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              for (int i = 0; i < popUpMenuOptions.length; i++)
                _buildPopupMenuItem(
                    context, popUpMenuOptions[i], popUpMenuOptions[i])
            ]);
  }
}
