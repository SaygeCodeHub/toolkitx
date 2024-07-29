import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/fetch_switching_schedule_instructions_model.dart';
import 'package:toolkit/screens/permit/widgets/permit_switching_date_time_fields.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class AddAndEditInstructionOfflineBody extends StatelessWidget {
  const AddAndEditInstructionOfflineBody({
    super.key,
    required this.isFromEdit,
    required this.switchingScheduleMap,
    required this.permitSwithcingScheduleInstructionDatum,
  });

  final bool isFromEdit;
  final Map switchingScheduleMap;
  final PermitSwithcingScheduleInstructionDatum
      permitSwithcingScheduleInstructionDatum;

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(FetchSwitchingScheduleDetails(
        instructionId: permitSwithcingScheduleInstructionDatum.id));
    return BlocBuilder<PermitBloc, PermitStates>(
      buildWhen: (previousState, currentState) =>
          currentState is SwitchingScheduleDetailsFetching ||
          currentState is SwitchingScheduleDetailsFetched ||
          currentState is SwitchingScheduleDetailsNotFetched,
      builder: (context, state) {
        if (state is SwitchingScheduleDetailsFetching) {
          return Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5),
                  child: const CircularProgressIndicator()));
        } else if (state is SwitchingScheduleDetailsFetched) {
          var data = state.fetchSwitchingScheduleDetailsModel.data;
            switchingScheduleMap['instructionid'] = data.id;
          if(isFromEdit){
            switchingScheduleMap['safetykeynumber'] = data.safetykeynumber;
            switchingScheduleMap['location'] = data.location;
            switchingScheduleMap['operation'] = data.operation;
            switchingScheduleMap['equipmentuid'] = data.equipmentuid;
            switchingScheduleMap["instructionreceiveddate"] =
                data.instructionreceiveddate;
            switchingScheduleMap["instructionreceivedtime"] =
                data.instructionreceivedtime;
            switchingScheduleMap["carriedoutdate"] = data.carriedoutdate;
            switchingScheduleMap["carriedouttime"] = data.carriedouttime;
            switchingScheduleMap["carriedoutconfirmeddate"] =
                data.carriedoutconfirmeddate;
            switchingScheduleMap["carriedoutconfirmedtime"] =
                data.carriedoutconfirmedtime;
            switchingScheduleMap["instructionreceivedbyname"] =
                data.instructionreceivedbyname;
            switchingScheduleMap["controlengineername"] =
                data.controlengineername;
            switchingScheduleMap["ismanual"] = data.ismanual;
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DatabaseUtil.getText('Location'),
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                isFromEdit == true
                    ? Text(data.location)
                    : TextFieldWidget(
                        onTextFieldChanged: (textField) {
                          switchingScheduleMap['location'] = textField;
                        },
                      ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kEquipmentUIN,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                isFromEdit == true
                    ? Text(data.equipmentuid)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWidget(
                            maxLines: 5,
                            onTextFieldChanged: (textField) {
                              switchingScheduleMap['equipmentuid'] = textField;
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
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                isFromEdit == true
                    ? Text(data.operation)
                    : TextFieldWidget(
                        onTextFieldChanged: (textField) {
                          switchingScheduleMap['operation'] = textField;
                        },
                      ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kInstructionReceivedBy,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                TextFieldWidget(
                  value:
                      isFromEdit == true ? data.instructionreceivedbyname : '',
                  onTextFieldChanged: (textField) {
                    switchingScheduleMap["instructionreceivedbyname"] =
                        textField;
                  },
                ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kInstructedDateTime,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                PermitSwitchingDateTimeFields(
                  callBackFunctionForDateTime: (String date, String time) {
                    switchingScheduleMap["instructionreceiveddate"] = date;
                    switchingScheduleMap["instructionreceivedtime"] = time;
                  },
                  editDate:
                      isFromEdit == true ? data.instructionreceiveddate : '',
                  editTime:
                      isFromEdit == true ? data.instructionreceivedtime : '',
                ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kControlEngineer,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                TextFieldWidget(
                  value: isFromEdit == true ? data.controlengineername : '',
                  onTextFieldChanged: (textField) {
                    switchingScheduleMap['controlengineername'] = textField;
                  },
                ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kCarriedoutDateTime,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                PermitSwitchingDateTimeFields(
                  callBackFunctionForDateTime: (String date, String time) {
                    switchingScheduleMap["carriedoutdate"] = date;
                    switchingScheduleMap["carriedouttime"] = time;
                  },
                  editDate: isFromEdit == true ? data.carriedoutdate : '',
                  editTime: isFromEdit == true ? data.carriedouttime : '',
                ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kCarriedoutConfirmedDateTime,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                PermitSwitchingDateTimeFields(
                  callBackFunctionForDateTime: (String date, String time) {
                    switchingScheduleMap["carriedoutconfirmeddate"] = date;
                    switchingScheduleMap["carriedoutconfirmedtime"] = time;
                  },
                  editDate:
                      isFromEdit == true ? data.carriedoutconfirmeddate : '',
                  editTime:
                      isFromEdit == true ? data.carriedoutconfirmedtime : '',
                ),
                const SizedBox(height: xxxSmallestSpacing),
                Text(StringConstants.kSafetyKeyNumber,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.black, fontWeight: FontWeight.bold)),
                const SizedBox(height: tiniestSpacing),
                TextFieldWidget(
                  value: isFromEdit == true ? data.safetykeynumber : '',
                  onTextFieldChanged: (textField) {
                    switchingScheduleMap['safetykeynumber'] = textField;
                  },
                ),
              ]);
        } else if (state is SwitchingScheduleDetailsNotFetched) {
          return Text(state.errorMessage);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
