import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todo_bloc.dart';
import 'package:toolkit/blocs/todo/todo_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/todo/todo_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_master_model.dart';
import '../../../widgets/expansion_tile_border.dart';

class ToDoCategoryExpansionTile extends StatelessWidget {
  final Map todoMap;
  final List<ToDoMasterDatum> data;

  const ToDoCategoryExpansionTile(
      {Key? key, required this.todoMap, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ToDoBloc>().add(ChangeToDoCategory(categoryId: ''));
    String categoryName = '';
    return BlocBuilder<ToDoBloc, ToDoStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ToDoCategoryChanged,
        builder: (context, state) {
          if (state is ToDoCategoryChanged) {
            todoMap['categoryid'] = state.categoryId.toString();
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        categoryName == ''
                            ? StringConstants.kSelect
                            : categoryName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[index].name,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[index].id.toString(),
                                groupValue: state.categoryId,
                                onChanged: (value) {
                                  value = data[index].id.toString();
                                  categoryName = data[index].name;
                                  context.read<ToDoBloc>().add(
                                      ChangeToDoCategory(categoryId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
