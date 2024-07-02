import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/widgets/control_engineer_expansion_tile.dart';
import 'package:toolkit/screens/permit/widgets/instructed_date_time_fields.dart';
import 'package:toolkit/screens/permit/widgets/instruction_received_expansion_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';

class EditSwitchingInstructionScreen extends StatelessWidget {
  static const routeName = 'EditSwitchingInstructionScreen';

  const EditSwitchingInstructionScreen({
    super.key,
    required this.permitSwithcingScheduleInstructionDatum,
  });

  final PermitSwithcingScheduleInstructionDatum
      permitSwithcingScheduleInstructionDatum;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const FetchPermitMaster());
    Map editSwitchingScheduleMap = {};
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
            child: BlocBuilder<PermitBloc, PermitStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingPermitMaster ||
                  currentState is PermitMasterFetched ||
                  currentState is CouldNotFetchPermitMaster,
              builder: (context, state) {
                if (state is FetchingPermitMaster) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.5),
                        child: const CircularProgressIndicator()),
                  );
                } else if (state is PermitMasterFetched) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DatabaseUtil.getText('Location'),
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        Text(permitSwithcingScheduleInstructionDatum.location),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kEquipmentUIN,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        Text(permitSwithcingScheduleInstructionDatum
                            .equipmentuid),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kOperation,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        Text(permitSwithcingScheduleInstructionDatum.operation),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kInstructionReceivedBy,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        InstructionReceivedExpansionTile(
                          instructionList: state.permitGetMasterModel.data[3],
                          editSwitchingScheduleMap: editSwitchingScheduleMap,
                          editName: permitSwithcingScheduleInstructionDatum
                              .instructionreceivedbyname,
                        ),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kInstructedDateTime,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        PermitSwitchingDateTimeFields(
                            callBackFunctionForDateTime:
                                (String date, String time) {
                          editSwitchingScheduleMap["instructiondate"] = date;
                          editSwitchingScheduleMap["instructiontime"] = time;
                        }),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kControlEngineer,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        ControlEngineerExpansionTile(
                          controlEngineerList:
                              state.permitGetMasterModel.data[3],
                          editSwitchingScheduleMap: editSwitchingScheduleMap,
                          editValue: permitSwithcingScheduleInstructionDatum
                              .controlengineername,
                        ),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kCarriedoutDateTime,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        PermitSwitchingDateTimeFields(
                            callBackFunctionForDateTime:
                                (String date, String time) {
                          editSwitchingScheduleMap["carriedoutdate"] = date;
                          editSwitchingScheduleMap["carriedouttime"] = time;
                        }),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kCarriedoutConfirmedDateTime,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        PermitSwitchingDateTimeFields(
                            callBackFunctionForDateTime:
                                (String date, String time) {
                          print('date==========>$date');
                          editSwitchingScheduleMap["carriedoutconfirmeddate"] =
                              date;
                          editSwitchingScheduleMap["carriedoutconfirmedtime"] =
                              time;
                        }),
                        const SizedBox(height: xxxSmallestSpacing),
                        Text(StringConstants.kSafetyKeyNumber,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: tiniestSpacing),
                        TextFieldWidget(
                          value: permitSwithcingScheduleInstructionDatum
                              .safetykeynumber,
                          onTextFieldChanged: (textField) {
                            editSwitchingScheduleMap['safetykeynumber'] =
                                textField;
                          },
                        ),
                      ]);
                } else if (state is CouldNotFetchPermitMaster) {
                  return const Center(
                      child: Text(StringConstants.kNoRecordsFound));
                }
                return const SizedBox.shrink();
              },
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
            } else if (state is PermitSwitchingScheduleNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                editSwitchingScheduleMap['instructionid'] =
                    permitSwithcingScheduleInstructionDatum.id;
                context.read<PermitBloc>().add(UpdatePermitSwitchingSchedule(
                    editSwitchingScheduleMap: editSwitchingScheduleMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
