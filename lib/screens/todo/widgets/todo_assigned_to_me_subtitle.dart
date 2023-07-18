import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/status_tag.dart';

class ToDoAssignedToMeSubtitle extends StatelessWidget {
  final AssignedToMeListDatum assignToMeListDatum;

  const ToDoAssignedToMeSubtitle({Key? key, required this.assignToMeListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(assignToMeListDatum.description, maxLines: 3),
              const SizedBox(height: tinierSpacing),
              Text(assignToMeListDatum.category, maxLines: 3),
              const SizedBox(height: tinierSpacing),
              Row(children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(assignToMeListDatum.duedate)
              ]),
              const SizedBox(height: tinierSpacing),
              StatusTag(tags: [
                StatusTagModel(
                    title: (assignToMeListDatum.istododue == 0)
                        ? DatabaseUtil.getText('Overdue')
                        : '',
                    bgColor: AppColor.errorRed),
              ])
            ]));
  }
}
