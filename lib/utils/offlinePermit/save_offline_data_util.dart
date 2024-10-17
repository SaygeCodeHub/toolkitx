import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';

import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../screens/workorder/workorder_add_comments_screen.dart';

class SaveOfflineDataUtil {
  void savePermitData(
      String status, Map saveOfflineDataMap, BuildContext context) {
    switch (status) {
      case 'ClearPermitScreen':
        context.read<PermitBloc>().add(SaveClearPermit(
            clearPermitMap: saveOfflineDataMap,
            permitId: saveOfflineDataMap['permitid']));
        break;
      case 'AcceptPermitRequestScreen':
        context.read<PermitBloc>().add(AcceptPermitRequest(
            permitId: saveOfflineDataMap['permitid'],
            acceptPermitMap: saveOfflineDataMap));
        break;
      case 'OpenPermitScreen':
        context.read<PermitBloc>().add(
            OpenPermit(saveOfflineDataMap, saveOfflineDataMap['permitId']));
        break;
      case 'PreparePermitScreen':
        context.read<PermitBloc>().add(SaveMarkAsPrepared(
            permitId: saveOfflineDataMap['permitid'],
            markAsPreparedMap: saveOfflineDataMap));
        break;
      case 'ClosePermitScreen':
        context.read<PermitBloc>().add(ClosePermit(
            closePermitMap: saveOfflineDataMap,
            permitId: saveOfflineDataMap['permitId']));
        break;
      case 'SurrenderPermitScreen':
        context.read<PermitBloc>().add(SurrenderPermit(
            surrenderPermitMap: saveOfflineDataMap,
            permitId: saveOfflineDataMap['permitid']));
        break;
      case 'TransferPermitOfflineScreen':
        context.read<PermitBloc>().add(ChangePermitCP(
            changePermitCPMap: saveOfflineDataMap,
            permitId: saveOfflineDataMap['permitid']));
        break;
    }
  }

  void saveWorkOrderData(
      String screen, Map saveOfflineDataMap, BuildContext context) {
    switch (screen) {
      case WorkOrderAddCommentsScreen.routeName:
        context
            .read<WorkOrderTabDetailsBloc>()
            .add(SaveWorkOrderComments(addCommentsMap: saveOfflineDataMap));
        break;
      case 'StartScreen':
        context
            .read<WorkOrderTabDetailsBloc>()
            .add(StartWorkOrder(startWorkOrderMap: saveOfflineDataMap));
        break;
      case 'CompleteScreen':
        context
            .read<WorkOrderTabDetailsBloc>()
            .add(CompleteWorkOrder(completeWorkOrderMap: saveOfflineDataMap));
        break;
      case 'AcceptScreen':
        context.read<WorkOrderTabDetailsBloc>().add(AcceptWorkOrder(
            workOrderId: saveOfflineDataMap['workorderId'] ?? '',
            acceptOfflineMap: saveOfflineDataMap));
        break;
    }
  }
}
