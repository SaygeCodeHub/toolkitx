import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorders_model.dart';
import '../../../widgets/custom_card.dart';
import '../workorder_details_tab_screen.dart';
import '../workorder_list_screen.dart';

class WorkOrderListCard extends StatelessWidget {
  final WorkOrderDatum data;

  const WorkOrderListCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, WorkOrderDetailsTabScreen.routeName,
                  arguments:
                      context.read<WorkOrderTabDetailsBloc>().workOrderId)
              .then((value) => Navigator.pushReplacementNamed(
                  context, WorkOrderListScreen.routeName,
                  arguments: false));
        },
        contentPadding: const EdgeInsets.all(xxTinierSpacing),
        title: Padding(
            padding: const EdgeInsets.only(bottom: xxTinierSpacing),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.woname,
                      style: Theme.of(context).textTheme.small.copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w600)),
                  const SizedBox(width: tinierSpacing),
                  Text(data.status,
                      style: Theme.of(context)
                          .textTheme
                          .xxSmall
                          .copyWith(color: AppColor.deepBlue))
                ])),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.subject, style: Theme.of(context).textTheme.xSmall),
            const SizedBox(height: tinierSpacing),
            Row(children: [
              Image.asset("assets/icons/calendar.png",
                  height: kIconSize, width: kIconSize),
              const SizedBox(width: tiniestSpacing),
              Text(data.schedule,
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.grey))
            ]),
            const SizedBox(height: tinierSpacing),
            Row(
              children: [
                Text('${data.contractorname}  -',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(color: AppColor.grey)),
                const SizedBox(width: tiniestSpacing),
                Expanded(
                  child: Text(data.type,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.grey,
                          overflow: TextOverflow.ellipsis)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
