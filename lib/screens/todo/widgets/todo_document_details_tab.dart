import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../../blocs/todo/todo_bloc.dart';
import '../../../blocs/todo/todo_event.dart';
import '../../../blocs/todo/todo_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/progress_bar.dart';
import 'todo_document_details_subtitle.dart';

class ToDoDocumentDetailsTab extends StatelessWidget {
  final int initialIndex;
  final List<ToDoDocumentDetailsDatum> documentDetailsDatum;
  final Map todoMap;

  const ToDoDocumentDetailsTab(
      {Key? key,
      required this.initialIndex,
      required this.documentDetailsDatum,
      required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (documentDetailsDatum.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoDocument,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: documentDetailsDatum.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documentDetailsDatum[index].docname,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black),
                                  maxLines: 3),
                              BlocListener<ToDoBloc, ToDoStates>(
                                listener: (context, state) {
                                  if (state is DeletingToDoDocument) {
                                    ProgressBar.show(context);
                                  } else if (state is ToDoDocumentDeleted) {
                                    context.read<ToDoBloc>().add(
                                        FetchToDoDetailsAndDocumentDetails(
                                            todoId: todoMap['todoId'],
                                            selectedIndex: initialIndex));
                                  } else if (state
                                      is CannotDeleteToDoDocument) {
                                    showCustomSnackBar(
                                        context,
                                        DatabaseUtil.getText(
                                            'some_unknown_error_please_try_again'),
                                        '');
                                  }
                                },
                                child: IconButton(
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AndroidPopUp(
                                                titleValue:
                                                    DatabaseUtil.getText(
                                                        'DeleteRecord'),
                                                onPressed: () {
                                                  todoMap['todoDocId'] =
                                                      documentDetailsDatum[
                                                              index]
                                                          .tododocid;
                                                  context.read<ToDoBloc>().add(
                                                      DeleteToDoDocument(
                                                          todoMap: todoMap));
                                                  Navigator.pop(context);
                                                },
                                                contentValue: '');
                                          });
                                    },
                                    icon: const Icon(Icons.delete,
                                        size: kIconSize)),
                              )
                            ],
                          ),
                          subtitle: ToDoDocumentDetailsSubtitle(
                              documentDetailsDatum: documentDetailsDatum[index],
                              todoMap: todoMap)));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tinierSpacing);
                }));
  }
}
