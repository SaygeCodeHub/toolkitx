import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todo_event.dart';
import '../../blocs/todo/todo_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/status_tag.dart';
import 'todo_details_and_document_details_screen.dart';

class ToDoHistoryListScreen extends StatefulWidget {
  static const routeName = 'ToDoHistoryListScreen';
  final Map todoMap;

  const ToDoHistoryListScreen({Key? key, required this.todoMap})
      : super(key: key);

  @override
  State<ToDoHistoryListScreen> createState() => _ToDoHistoryListScreenState();
}

class _ToDoHistoryListScreenState extends State<ToDoHistoryListScreen> {
  ScrollController controller = ScrollController();
  int page = 1;
  List historyListData = [];
  bool waitForData = false;
  bool noMoreData = false;

  @override
  void initState() {
    page = 1;
    noMoreData = false;
    historyListData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(FetchToDoHistoryList(page: page));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kToDoHistory),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocConsumer<ToDoBloc, ToDoStates>(
              buildWhen: (previousState, currentState) =>
                  ((currentState is TodoHistoryListFetched &&
                          noMoreData != true) ||
                      (currentState is FetchingTodoHistoryList && page == 1)),
              listener: (context, state) {
                if (state is TodoHistoryListFetched) {
                  if (state.fetchToDoHistoryListModel.status == 204 &&
                      historyListData.isNotEmpty) {
                    noMoreData = true;
                    showCustomSnackBar(
                        context, StringConstants.kAllDataLoaded, '');
                  }
                }
              },
              builder: (context, state) {
                if (state is FetchingTodoHistoryList) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoHistoryListFetched) {
                  if (state.fetchToDoHistoryListModel.data.isNotEmpty) {
                    if (page == 1) {
                      historyListData = state.fetchToDoHistoryListModel.data;
                    } else {
                      for (var item in state.fetchToDoHistoryListModel.data) {
                        historyListData.add(item);
                      }
                    }
                    waitForData = false;
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        controller: controller
                          ..addListener(() {
                            if (noMoreData != true && waitForData == false) {
                              if (controller.position.extentAfter < 500) {
                                page++;
                                context
                                    .read<ToDoBloc>()
                                    .add(FetchToDoHistoryList(page: page));
                                waitForData = true;
                              }
                            }
                          }),
                        shrinkWrap: true,
                        itemCount: state.fetchToDoHistoryListModel.data.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: tinierSpacing),
                                  child: ListTile(
                                      onTap: () {
                                        widget.todoMap['isFromHistory'] = true;
                                        ToDoDetailsAndDocumentDetailsScreen
                                            .todoMap['isFromHistory'] = true;
                                        Navigator.pushNamed(
                                            context,
                                            ToDoDetailsAndDocumentDetailsScreen
                                                .routeName,
                                            arguments: state
                                                .fetchToDoHistoryListModel
                                                .data[index]
                                                .id);
                                      },
                                      title: Text(
                                          state.fetchToDoHistoryListModel
                                              .data[index].todoname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .small
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.black)),
                                      subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: tinierSpacing),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state
                                                        .fetchToDoHistoryListModel
                                                        .data[index]
                                                        .description,
                                                    maxLines: 3),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Text(
                                                    state
                                                        .fetchToDoHistoryListModel
                                                        .data[index]
                                                        .category,
                                                    maxLines: 3),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Row(children: [
                                                  Image.asset(
                                                      'assets/icons/calendar.png',
                                                      height: kImageHeight,
                                                      width: kImageWidth),
                                                  const SizedBox(
                                                      width: tiniestSpacing),
                                                  Text(state
                                                      .fetchToDoHistoryListModel
                                                      .data[index]
                                                      .duedate)
                                                ]),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                StatusTag(tags: [
                                                  StatusTagModel(
                                                      title: (state
                                                                  .fetchToDoHistoryListModel
                                                                  .data[index]
                                                                  .istododue ==
                                                              1)
                                                          ? DatabaseUtil
                                                              .getText(
                                                                  'Overdue')
                                                          : '',
                                                      bgColor:
                                                          AppColor.errorRed),
                                                ])
                                              ])))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        });
                  } else {
                    return Center(
                        child: Text(DatabaseUtil.getText('no_records_found')));
                  }
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }
}
