import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_submit_answer_signature_pad_section.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';

class TankSubmitEditAnswerButton extends StatelessWidget {
  final List answerList;
  final Map tankChecklistDataMap;

  const TankSubmitEditAnswerButton(
      {super.key,
      required this.answerList,
      required this.tankChecklistDataMap});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TankManagementBloc, TankManagementState>(
        listener: (context, state) {
          if (state is NominationChecklistSubmitting) {
            ProgressBar.show(context);
          } else if (state is NominationChecklistSubmitted) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            context.read<TankManagementBloc>().add(FetchNominationChecklist(
                nominationId: tankChecklistDataMap['nominationId'],
                tabIndex: 1));
          } else if (state is NominationChecklistNotSubmitted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        child: Row(children: [
          TankSubmitAnswerSignaturePadSection(
              answerList: answerList,
              tankChecklistDataMap: tankChecklistDataMap),
          const SizedBox(width: xxTinySpacing),
          Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<TankManagementBloc>().add(
                        SubmitNominationChecklist(
                            tankChecklistMap: tankChecklistDataMap,
                            editQuestionsList: answerList,
                            isDraft: true));
                  },
                  textValue: StringConstants.kSaveDraft))
        ]));
  }
}
