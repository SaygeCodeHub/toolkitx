import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/fetch_loto_checklist_questions_model.dart';

class TypeThreeExpansionTile extends StatelessWidget {
  final Map startLotoMap;
  final List answerList;

  const TypeThreeExpansionTile(
      {super.key,
      required this.queOptionList,
      required this.startLotoMap,
      required this.questionId,
      required this.answerList});

  final List<QueOption> queOptionList;
  final String questionId;

  @override
  Widget build(BuildContext context) {
    String selectedValue = "";
    context
        .read<LotoDetailsBloc>()
        .add(SelectOption(id: startLotoMap['optionid'] ?? 0, text: ''));
    return BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
        buildWhen: (previousState, currentState) =>
            currentState is OptionSelected,
        builder: (context, state) {
          if (state is OptionSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    key: GlobalKey(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    title: Text(selectedValue),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: queOptionList.length,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxTinierSpacing),
                                    title: Text(
                                        queOptionList[listIndex].queoptiontext),
                                    onTap: () {
                                      startLotoMap['optionid'] =
                                          queOptionList[listIndex].queoptionid;
                                      startLotoMap['optiontext'] =
                                          queOptionList[listIndex]
                                              .queoptiontext;
                                      selectedValue = queOptionList[listIndex]
                                          .queoptiontext;
                                      context.read<LotoDetailsBloc>().add(
                                          SelectOption(
                                              id: startLotoMap['optionid'],
                                              text: queOptionList[listIndex]
                                                  .queoptiontext));
                                      answerList[listIndex]["questionid"] =
                                          questionId;
                                      answerList[listIndex]["answer"] =
                                          startLotoMap['optionid'];
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
