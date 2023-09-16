import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';

class WorkOrderTabThreeItemsTab extends StatelessWidget {
  final WorkOrderDetailsData data;

  const WorkOrderTabThreeItemsTab({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: data.items.isNotEmpty,
        replacement: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(StringConstants.kNoParts,
                    style: Theme.of(context).textTheme.medium))),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(tinierSpacing),
                      onTap: () {},
                      title: Text(data.items[index].item,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black)),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        CustomIconButton(
                            icon: Icons.delete,
                            onPressed: () {},
                            size: kEditAndDeleteIconTogether),
                        const SizedBox(width: xxxTinierSpacing),
                        CustomIconButton(
                            icon: Icons.edit,
                            onPressed: () {},
                            size: kEditAndDeleteIconTogether)
                      ]),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text('${data.items[index].type}: '),
                                  const SizedBox(width: xxxTinierSpacing),
                                  Text(data.items[index].code),
                                ]),
                                const SizedBox(height: xxxTinierSpacing),
                                Row(children: [
                                  Text(
                                      '${DatabaseUtil.getText('PlannedQuan')}: '),
                                  const SizedBox(width: xxxTinierSpacing),
                                  Text((data.items[index].plannedquan
                                              .toString() ==
                                          'null')
                                      ? ''
                                      : data.items[index].plannedquan
                                          .toString())
                                ]),
                                const SizedBox(height: xxxTinierSpacing),
                                Row(children: [
                                  Text('${DatabaseUtil.getText('UsedQuan')}: '),
                                  const SizedBox(width: xxxTinierSpacing),
                                  Text((data.items[index].actualquan
                                              .toString() ==
                                          'null')
                                      ? ''
                                      : data.items[index].actualquan.toString())
                                ])
                              ]))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: tinierSpacing);
            }));
  }
}
