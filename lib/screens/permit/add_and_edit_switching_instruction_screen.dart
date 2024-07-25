import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/permit_switching_schedule_table_screen.dart';
import 'package:toolkit/screens/permit/widgets/add_and_edit_switching_instruction_body.dart';
import 'package:toolkit/screens/permit/widgets/control_engineer_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/instruction_received_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/permit_switching_date_time_fields.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/global.dart';
import '../../widgets/generic_text_field.dart';

class AddAndEditSwitchingInstructionScreen extends StatelessWidget {
  static const routeName = 'EditSwitchingInstructionScreen';

  const AddAndEditSwitchingInstructionScreen({
    super.key,
    required this.permitSwithcingScheduleInstructionDatum,
    required this.isFromEdit,
    required this.scheduleId,
  });

  final PermitSwithcingScheduleInstructionDatum
      permitSwithcingScheduleInstructionDatum;
  final bool isFromEdit;
  final String scheduleId;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const FetchPermitMaster());
    Map switchingScheduleMap = {};
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Visibility(
              visible: isNetworkEstablished == true,
              replacement: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DatabaseUtil.getText('Location'),
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    isFromEdit == true
                        ? const Text("data.location")
                        : TextFieldWidget(
                            onTextFieldChanged: (textField) {
                              switchingScheduleMap['location'] = textField;
                            },
                          ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kEquipmentUIN,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    isFromEdit == true
                        ? const Text("data.equipmentuid")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                maxLines: 5,
                                onTextFieldChanged: (textField) {
                                  switchingScheduleMap['equipmentuid'] =
                                      textField;
                                },
                              ),
                              const SizedBox(height: tiniestSpacing),
                              const Text(StringConstants.kIncludingVoltageLevel,
                                  style: TextStyle(color: AppColor.deepBlue))
                            ],
                          ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kOperation,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    isFromEdit == true
                        ? const Text("data.operation")
                        : TextFieldWidget(
                            onTextFieldChanged: (textField) {
                              switchingScheduleMap['operation'] = textField;
                            },
                          ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kInstructionReceivedBy,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      // value: isFromEdit == true ? data.safetykeynumber : '',
                      onTextFieldChanged: (textField) {
                        switchingScheduleMap['safetykeynumber'] = textField;
                      },
                    ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kInstructedDateTime,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    PermitSwitchingDateTimeFields(
                      callBackFunctionForDateTime: (String date, String time) {
                        switchingScheduleMap["instructiondate"] = date;
                        switchingScheduleMap["instructiontime"] = time;
                      },
                      // editDate:
                      // isFromEdit == true ? data.instructionreceiveddate : '',
                      // editTime:
                      // isFromEdit == true ? data.instructionreceivedtime : '',
                    ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kControlEngineer,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      // value: isFromEdit == true ? data.safetykeynumber : '',
                      onTextFieldChanged: (textField) {
                        switchingScheduleMap['safetykeynumber'] = textField;
                      },
                    ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kCarriedoutDateTime,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    PermitSwitchingDateTimeFields(
                      callBackFunctionForDateTime: (String date, String time) {
                        switchingScheduleMap["carriedoutdate"] = date;
                        switchingScheduleMap["carriedouttime"] = time;
                      },
                      // editDate: isFromEdit == true ? data.carriedoutdate : '',
                      // editTime: isFromEdit == true ? data.carriedouttime : '',
                    ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kCarriedoutConfirmedDateTime,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    PermitSwitchingDateTimeFields(
                      callBackFunctionForDateTime: (String date, String time) {
                        switchingScheduleMap["carriedoutconfirmeddate"] = date;
                        switchingScheduleMap["carriedoutconfirmedtime"] = time;
                      },
                      // editDate:,
                      // // isFromEdit == true ? data.carriedoutconfirmeddate : '',
                      // editTime:
                      // // isFromEdit == true ? data.carriedoutconfirmedtime : '',
                    ),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kSafetyKeyNumber,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      // value: isFromEdit == true ? data.safetykeynumber : '',
                      onTextFieldChanged: (textField) {
                        switchingScheduleMap['safetykeynumber'] = textField;
                      },
                    ),
                  ]),
              child: BlocBuilder<PermitBloc, PermitStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingPermitMaster ||
                    currentState is PermitMasterFetched ||
                    currentState is CouldNotFetchPermitMaster,
                builder: (context, state) {
                  if (state is PermitMasterFetched) {
                    return AddAndEditSwitchingInstructionBody(
                      isFromEdit: isFromEdit,
                      permitSwithcingScheduleInstructionDatum:
                          permitSwithcingScheduleInstructionDatum,
                      switchingScheduleMap: switchingScheduleMap,
                      permitGetMasterModel: state.permitGetMasterModel,
                    );
                  } else if (state is CouldNotFetchPermitMaster) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<PermitBloc, PermitStates>(
          listener: (context, state) {
            if (state is PermitSwitchingScheduleUpdating) {
              ProgressBar.show(context);
            } else if (state is PermitSwitchingScheduleUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, PermitSwitchingScheduleTableScreen.routeName,
                  arguments: scheduleId);
            } else if (state is PermitSwitchingScheduleNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }

            if (state is PermitSwitchingScheduleAdding) {
              ProgressBar.show(context);
            } else if (state is PermitSwitchingScheduleAdded) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              print('schedule id $scheduleId');
              Navigator.pushReplacementNamed(
                  context, PermitSwitchingScheduleTableScreen.routeName,
                  arguments: scheduleId);
            } else if (state is PermitSwitchingScheduleNotAdded) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                switchingScheduleMap['instructionid'] =
                    permitSwithcingScheduleInstructionDatum.id;
                print('on tap map $switchingScheduleMap');
                isFromEdit == true
                    ? context.read<PermitBloc>().add(
                        UpdatePermitSwitchingSchedule(
                            editSwitchingScheduleMap: switchingScheduleMap))
                    : context.read<PermitBloc>().add(AddPermitSwitchingSchedule(
                        addSwitchingScheduleMap: switchingScheduleMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
