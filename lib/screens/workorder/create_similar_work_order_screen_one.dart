import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_events.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import '../incident/widgets/time_picker.dart';
import 'widgets/workorder_company_list_tile.dart';
import 'widgets/workorder_location_list_tile.dart';

class CreateSimilarWorkOrderScreen extends StatelessWidget {
  static const routeName = 'CreateSimilarWorkOrderScreen';
  final Map workOrderDetailsMap;

  const CreateSimilarWorkOrderScreen(
      {Key? key, required this.workOrderDetailsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
    return Scaffold(
        appBar: const GenericAppBar(),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textValue: DatabaseUtil.getText('buttonBack'),
              )),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                child: PrimaryButton(
                    onPressed: () {},
                    textValue: DatabaseUtil.getText('nextButtonText')),
              ),
            ],
          ),
        ),
        body: BlocBuilder<WorkOrderBloc, WorkOrderStates>(
            builder: (context, state) {
          if (state is FetchingWorkOrderMaster) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkOrderMasterFetched) {
            return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinySpacing),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CompanyListTile(
                              data: state.fetchWorkOrdersMasterModel.data,
                              workOrderDetailsMap: workOrderDetailsMap),
                          LocationListTile(
                              data: state.fetchWorkOrdersMasterModel.data,
                              workOrderDetailsMap: workOrderDetailsMap),
                          const SizedBox(height: xxxTinierSpacing),
                          Text(DatabaseUtil.getText('OtherLocation'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                              onTextFieldChanged: (String textField) {
                                workOrderDetailsMap['locationid'] = textField;
                              }),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('PlannedStartDate'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          DatePickerTextField(
                            hintText: StringConstants.kSelectDate,
                            onDateChanged: (String date) {
                              workOrderDetailsMap['plannedstartdate'] = date;
                            },
                          ),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('PlannedStartTime'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TimePickerTextField(
                            hintText: StringConstants.kSelectTime,
                            onTimeChanged: (String time) {
                              workOrderDetailsMap['plannedstarttime'] = time;
                            },
                          ),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('PlannedEndDate'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          DatePickerTextField(
                            hintText: StringConstants.kSelectDate,
                            onDateChanged: (String date) {
                              workOrderDetailsMap['plannedfinishdate'] = date;
                            },
                          ),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('PlannedEndTime'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TimePickerTextField(
                            hintText: StringConstants.kSelectTime,
                            onTimeChanged: (String time) {
                              workOrderDetailsMap['plannedfinishtime'] = time;
                            },
                          ),
                        ])));
          } else if (state is WorkOrderMasterNotFetched) {
            return GenericReloadButton(
                onPressed: () {
                  context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
                },
                textValue: StringConstants.kReload);
          } else {
            return const SizedBox.shrink();
          }
        }));
  }
}
