import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';

class LotoViewResponseScreen extends StatelessWidget {
  static const routeName = 'LotoViewResponseScreen';
  final String checklistId;

  const LotoViewResponseScreen({super.key, required this.checklistId});

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoDetailsBloc>()
        .add(FetchLotoChecklistQuestions(checkListId: checklistId));
    return Scaffold(
      appBar: const GenericAppBar(title: "Back to Checklist"),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: tinySpacing),
        child: BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
          builder: (context, state) {
            if (state is LotoChecklistQuestionsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LotoChecklistQuestionsFetched) {
              var questionlist =
                  state.fetchLotoChecklistQuestionsModel.data!.questionlist;
              return ListView.separated(
                itemCount: questionlist!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomCard(
                    child: ListTile(
                        title: Text(questionlist[index].title,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black)),
                        subtitle: Text(questionlist[index].optioncomment)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
