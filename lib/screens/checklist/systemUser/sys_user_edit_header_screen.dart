import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/edit_header_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_events.dart';
import '../widgets/checklist_app_bar.dart';

class EditHeaderScreen extends StatelessWidget {
  static const routeName = 'EditHeaderScreen';
  final List editHeaderList = [];

  EditHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CheckListHeaderBloc>().add(FetchCheckListEditHeader(
        scheduleId:
            context.read<CheckListScheduleDatesResponseBloc>().scheduleId));
    return Scaffold(
        appBar: ChecklistAppBar(
            title: BlocBuilder<CheckListHeaderBloc, CheckListHeaderStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingCheckListEditHeader ||
                    currentState is CheckListEditHeaderFetched ||
                    currentState is CheckListEditHeaderError,
                builder: (context, state) {
                  if (state is CheckListEditHeaderFetched) {
                    return Text(state
                        .getCheckListEditHeaderModel.data![0].checklistname);
                  } else {
                    return const SizedBox();
                  }
                })),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<CheckListHeaderBloc, CheckListHeaderStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingCheckListEditHeader ||
                    currentState is CheckListEditHeaderFetched ||
                    currentState is CheckListEditHeaderError,
                listener: (context, state) {
                  if (state is SubmittingCheckListHeader) {
                    ProgressBar.show(context);
                  } else if (state is CheckListHeaderSubmitted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.headerMessage, '');
                  } else if (state is CheckListHeaderNotSubmitted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.message, '');
                  }
                },
                builder: (context, state) {
                  if (state is FetchingCheckListEditHeader) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CheckListEditHeaderFetched) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                state.getCheckListEditHeaderModel.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: state
                                              .getCheckListEditHeaderModel
                                              .data![index]
                                              .title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          children: [
                                            (state
                                                        .getCheckListEditHeaderModel
                                                        .data![index]
                                                        .ismandatory ==
                                                    1)
                                                ? TextSpan(
                                                    text: ' *',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                                : const TextSpan()
                                          ]),
                                    ),
                                    const SizedBox(height: xxxTinierSpacing),
                                    EditHeader()
                                        .fetchEditHeaderSwitchCaseWidget(
                                            index,
                                            state.getCheckListEditHeaderModel
                                                .data![index],
                                            editHeaderList),
                                    const SizedBox(height: xxTinierSpacing),
                                  ]);
                            }),
                        const SizedBox(height: xxTinySpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<CheckListHeaderBloc>().add(
                                  CheckListSubmitHeader(
                                      scheduleId: context
                                          .read<
                                              CheckListScheduleDatesResponseBloc>()
                                          .scheduleId,
                                      submitHeaderList: editHeaderList));
                            },
                            textValue: StringConstants.kSubmit)
                      ]),
                    );
                  } else if (state is CheckListEditHeaderError) {
                    return Center(
                        child: Text(state.noHeaderMessage,
                            style: Theme.of(context).textTheme.medium));
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
