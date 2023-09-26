import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'add_parts_list_body.dart';

class WorkOrderAddPartsScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddPartsScreen';
  const WorkOrderAddPartsScreen({super.key});
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<WorkOrderTabDetailsBloc>().docListReachedMax = false;
    context
        .read<WorkOrderTabDetailsBloc>()
        .add(FetchAssignPartsList(pageNo: 1));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddParts')),
      body: const Padding(
        padding: EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: AddPartsListBody(),
      ),
    );
  }
}


