import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../blocs/workorder/workorder_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorders_model.dart';
import '../../../widgets/custom_card.dart';
import '../workorder_details_tab_screen.dart';

class WorkOrderListCard extends StatelessWidget {
  final WorkOrderDatum data;

  const WorkOrderListCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print('data.actionCount ${data.actionCount}');
    return CustomCard(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, WorkOrderDetailsTabScreen.routeName,
                  arguments: data.id)
              .then((value) {
            if (context.mounted) {
              print('inside here');
              context
                  .read<WorkOrderBloc>()
                  .add(FetchWorkOrders(pageNo: 1, isFromHome: false));
            }
          });
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
                  (data.actionCount > 0)
                      ? const Icon(Icons.pending_actions_rounded,
                          size: kImageHeight, color: AppColor.orange)
                      : const SizedBox.shrink(),
                  const Spacer(),
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
