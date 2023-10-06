import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import '../workorder_add_mis_cost_screen.dart';

class WorkOrderTabThreeMiscCostTab extends StatelessWidget {
  final WorkOrderDetailsData data;

  const WorkOrderTabThreeMiscCostTab({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: data.misccost.isNotEmpty,
        replacement: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(StringConstants.kNoMisCost,
                    style: Theme.of(context).textTheme.medium))),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.misccost.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(tinierSpacing),
                      title: Text(data.misccost[index].service,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        CustomIconButton(
                            dy: -20,
                            dx: 0,
                            icon: Icons.delete,
                            onPressed: () {},
                            size: kEditAndDeleteIconTogether),
                        const SizedBox(width: xxxTinierSpacing),
                        CustomIconButton(
                            dy: -21,
                            dx: 0,
                            icon: Icons.edit,
                            onPressed: () {
                              WorkOrderAddMisCostScreen.workOrderMasterDatum =
                                  context
                                      .read<WorkOrderBloc>()
                                      .workOrderMasterDatum;
                              WorkOrderAddMisCostScreen
                                      .workOrderDetailsMap['misCostId'] =
                                  data.misccost[index].id;
                              WorkOrderAddMisCostScreen
                                      .workOrderDetailsMap['vendorName'] =
                                  data.misccost[index].vendorname;
                              WorkOrderAddMisCostScreen
                                  .workOrderDetailsMap['workorderId'] = data.id;
                              Navigator.pushNamed(
                                  context, WorkOrderAddMisCostScreen.routeName);
                            },
                            size: kEditAndDeleteIconTogether)
                      ]),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('${DatabaseUtil.getText('Quantity')}: '),
                                  Text(data.misccost[index].quan.toString()),
                                ]),
                                const SizedBox(height: xxxTinierSpacing),
                                Row(children: [
                                  Text('${DatabaseUtil.getText('Amount')}: '),
                                  Text(data.misccost[index].amount)
                                ])
                              ]))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: tinierSpacing);
            }));
  }
}
