import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_details_model.dart';
import '../../../utils/database_utils.dart';
import 'submit_todo_button.dart';

class ToDoDetailsTab extends StatelessWidget {
  final int initialIndex;
  final ToDoDetailsData todoDetails;
  final Map todoMap;

  const ToDoDetailsTab(
      {super.key,
      required this.initialIndex,
      required this.todoDetails,
      required this.todoMap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: tinySpacing),
          Visibility(
              visible: todoDetails.isdraft == '1',
              child: Text(
                DatabaseUtil.getText('DraftMessageToDo'),
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.deepBlue, fontSize: 15),
              )),
          (todoDetails.isdraft == '1')
              ? const SizedBox(height: tinySpacing)
              : const SizedBox.shrink(),
          Text(DatabaseUtil.getText('Heading'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(todoDetails.heading, style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Description'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(todoDetails.description,
              style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Category'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(todoDetails.category, style: Theme.of(context).textTheme.small),
          const SizedBox(height: tinySpacing),
          Text(DatabaseUtil.getText('Duedate'),
              style: Theme.of(context).textTheme.medium.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.bold)),
          const SizedBox(height: xxTinierSpacing),
          Text(todoDetails.duedate, style: Theme.of(context).textTheme.small),
          const SizedBox(height: smallerSpacing),
          SubmitToDoButton(todoMap: todoMap, todoDetails: todoDetails)
        ]));
  }
}
