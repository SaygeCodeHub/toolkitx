import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../../utils/database_utils.dart';
import 'workorder_company_list.dart';

class CompanyListTile extends StatelessWidget {
  final List<List<WorkOrderMasterDatum>> data;
  final Map workOrderDetailsMap;

  const CompanyListTile(
      {Key? key, required this.data, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(SelectWorkOrderCompanyOptions(
        companyId: workOrderDetailsMap['contractorname'] ?? '',
        companyName: workOrderDetailsMap['companyid'] ?? ''));
    return BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is WorkOrderCompanyOptionSelected,
        builder: (context, state) {
          if (state is WorkOrderCompanyOptionSelected) {
            workOrderDetailsMap['companyid'] = state.companyId;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkOrderCompanyList(
                                data: data,
                                companyId: state.companyId,
                              )));
                },
                title: Text(DatabaseUtil.getText('Company'),
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: tiniestSpacing),
                  child: Text(state.companyName,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.black)),
                ),
                trailing:
                    const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
