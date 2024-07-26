import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/android_pop_up.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/text_button.dart';

class TankSubmitAnswerSignaturePadSection extends StatelessWidget {
  final List answerList;
  final Map tankChecklistDataMap;

  const TankSubmitAnswerSignaturePadSection(
      {super.key,
      required this.answerList,
      required this.tankChecklistDataMap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PrimaryButton(
          onPressed: () {
            showDialog(
                barrierColor: AppColor.transparent,
                context: context,
                builder: (context) {
                  return AndroidPopUp(
                      titleValue: StringConstants.kChecklist,
                      contentValue: StringConstants.kChecklistNotEditable,
                      onPrimaryButton: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  titlePadding: const EdgeInsets.only(
                                      left: tinySpacing,
                                      top: tinySpacing,
                                      right: tinySpacing),
                                  buttonPadding:
                                      const EdgeInsets.all(tiniestSpacing),
                                  contentPadding: const EdgeInsets.only(
                                      left: xxTinySpacing,
                                      right: xxTinySpacing,
                                      top: xxTinySpacing,
                                      bottom: 0),
                                  actionsPadding: const EdgeInsets.only(
                                      right: xxTinySpacing,
                                      bottom: tiniestSpacing),
                                  title: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.75,
                                    child: SignaturePad(
                                        map: tankChecklistDataMap,
                                        mapKey: 'sign_text'),
                                  ),
                                  actions: [
                                    CustomTextButton(
                                        onPressed: () {
                                          tankChecklistDataMap['sign_text'] =
                                              '';
                                          Navigator.of(context).pop();
                                        },
                                        textValue: StringConstants.kNo),
                                    CustomTextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          context
                                              .read<TankManagementBloc>()
                                              .add(SubmitNominationChecklist(
                                                  tankChecklistMap:
                                                      tankChecklistDataMap,
                                                  editQuestionsList: answerList,
                                                  isDraft: false));
                                        },
                                        textValue: StringConstants.kYes)
                                  ]);
                            });
                      });
                });
          },
          textValue: StringConstants.kSubmit),
    );
  }
}
