import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';

class ToDoAssignedByMeSubtitle extends StatelessWidget {
  final AssignByMeListDatum assignedByMeListDatum;

  const ToDoAssignedByMeSubtitle(
      {Key? key, required this.assignedByMeListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(assignedByMeListDatum.description, maxLines: 3),
              const SizedBox(height: tinierSpacing),
              Text(assignedByMeListDatum.category),
              const SizedBox(height: tinierSpacing),
              Row(children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: tiniestSpacing),
                Text(assignedByMeListDatum.duedate)
              ]),
              const SizedBox(height: tinierSpacing),
              IconAndTextRow(
                  title: assignedByMeListDatum.createdfor,
                  icon: 'human_avatar_three'),
              const SizedBox(height: tinierSpacing),
              StatusTag(tags: [
                StatusTagModel(
                    title: (assignedByMeListDatum.istododue == 1)
                        ? DatabaseUtil.getText('Overdue')
                        : '',
                    bgColor: AppColor.errorRed),
              ])
            ]));
  }
}
