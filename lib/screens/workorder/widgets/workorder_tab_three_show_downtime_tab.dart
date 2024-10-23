import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../utils/global.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import '../workorder_add_and_edit_down_time_screen.dart';

class WorkOrderTabThreeShowDowntimeTab extends StatelessWidget {
  final WorkOrderDetailsData data;

  const WorkOrderTabThreeShowDowntimeTab({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: data.downtime.isNotEmpty,
        replacement: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(StringConstants.kNoDowntown,
                    style: Theme.of(context).textTheme.medium))),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.downtime.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: tiniestSpacing,
                          left: tinierSpacing,
                          right: tinierSpacing,
                          bottom: tinierSpacing),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('${DatabaseUtil.getText('StartDate')}: '),
                            const SizedBox(width: xxxTinierSpacing),
                            Text(data.downtime[index].start)
                          ]),
                          const SizedBox(height: xxxTinierSpacing),
                          Row(children: [
                            Text('${DatabaseUtil.getText('EndDate')}: '),
                            const SizedBox(width: xxxTinierSpacing),
                            Text(data.downtime[index].end)
                          ]),
                        ],
                      ),
                      trailing: (isNetworkEstablished)
                          ? Row(mainAxisSize: MainAxisSize.min, children: [
                              CustomIconButton(
                                  icon: Icons.delete,
                                  onPressed: () {},
                                  size: kEditAndDeleteIconTogether),
                              const SizedBox(width: xxxTinierSpacing),
                              CustomIconButton(
                                  icon: Icons.edit,
                                  onPressed: () {
                                    WorkOrderAddAndEditDownTimeScreen
                                            .addAndEditDownTimeMap[
                                        'downTimeId'] = data.downtime[index].id;
                                    WorkOrderAddAndEditDownTimeScreen
                                            .addAndEditDownTimeMap[
                                        'workorderId'] = data.id;
                                    Navigator.pushNamed(
                                        context,
                                        WorkOrderAddAndEditDownTimeScreen
                                            .routeName);
                                  },
                                  size: kEditAndDeleteIconTogether)
                            ])
                          : const SizedBox.shrink()));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: tinierSpacing);
            }));
  }
}
