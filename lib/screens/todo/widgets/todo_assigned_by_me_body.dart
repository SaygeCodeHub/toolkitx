import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../todo_details_and_document_details_screen.dart';
import 'todo_assigned_by_me_subtitle.dart';

class TodoAssignedByMeBody extends StatelessWidget {
  final List<AssignByMeListDatum> assignedByMeListDatum;
  final Map todoMap;

  const TodoAssignedByMeBody(
      {Key? key, required this.assignedByMeListDatum, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (assignedByMeListDatum.isEmpty)
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(StringConstants.kNoToDoAssignedBy,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.mediumBlack))),
          )
        : Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: assignedByMeListDatum.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    ToDoDetailsAndDocumentDetailsScreen
                                        .routeName,
                                    arguments: assignedByMeListDatum[index].id);
                              },
                              title: Text(assignedByMeListDatum[index].todoname,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black)),
                              subtitle: ToDoAssignedByMeSubtitle(
                                  assignedByMeListDatum:
                                      assignedByMeListDatum[index],
                                  todoMap: todoMap))));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                }),
          );
  }
}
