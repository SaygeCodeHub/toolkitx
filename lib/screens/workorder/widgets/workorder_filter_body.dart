import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/workorder/workorder_bloc.dart';
import '../../../blocs/workorder/workorder_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../incident/widgets/date_picker.dart';
import '../workorder_filter_screen.dart';
import '../workorder_list_screen.dart';
import 'workorder_status_filter.dart';
import 'workorder_type_filter.dart';

class WorkOrderFilterBody extends StatelessWidget {
  final Map workOrderFilterMap;
  final List<List<WorkOrderMasterDatum>> workOderDatum;

  const WorkOrderFilterBody(
      {super.key,
      required this.workOrderFilterMap,
      required this.workOderDatum});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomPadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(StringConstants.kDateRange,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: DatePickerTextField(
                              editDate: (workOrderFilterMap['st'] == null)
                                  ? ''
                                  : workOrderFilterMap['st'],
                              hintText: StringConstants.kSelectDate,
                              onDateChanged: (String date) {
                                workOrderFilterMap['st'] = date;
                              })),
                      const SizedBox(width: xxTinierSpacing),
                      const Text(StringConstants.kBis),
                      const SizedBox(width: xxTinierSpacing),
                      Expanded(
                          child: DatePickerTextField(
                              editDate: (workOrderFilterMap['et'] == null)
                                  ? ''
                                  : workOrderFilterMap['et'],
                              hintText: StringConstants.kSelectDate,
                              onDateChanged: (String date) {
                                workOrderFilterMap['et'] = date;
                              }))
                    ]),
                const SizedBox(height: xxTinySpacing),
                Text('Keyword',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                TextFieldWidget(
                    value: (workOrderFilterMap['kword'] == null)
                        ? ''
                        : workOrderFilterMap['kword'],
                    hintText: 'Keyword',
                    onTextFieldChanged: (String textField) {
                      workOrderFilterMap['kword'] = textField;
                    }),
                const SizedBox(height: xxTinySpacing),
                Text('Workorder Type',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                WorkOrderTypeFilter(
                    workOrderFilterMap: workOrderFilterMap,
                    workOderDatum: workOderDatum),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('Status'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                WorkOrderStatusFilter(
                  workOrderFilterMap: workOrderFilterMap,
                ),
                const SizedBox(height: xxxSmallerSpacing),
                PrimaryButton(
                    onPressed: () {
                      if (workOrderFilterMap['st'] != null &&
                              workOrderFilterMap['et'] == null ||
                          workOrderFilterMap['st'] == null &&
                              workOrderFilterMap['et'] != null) {
                        showCustomSnackBar(context,
                            DatabaseUtil.getText('TimeDateValidate'), '');
                      } else {
                        if (WorkOrderFilterScreen.isFromLocation == true) {
                          context.read<LocationBloc>().add(
                              ApplyWorkOrderListFilter(
                                  filterMap: workOrderFilterMap));
                          Navigator.pop(context);
                          context.read<LocationBloc>().add(FetchLocationDetails(
                              locationId: WorkOrderFilterScreen.expenseId,
                              selectedTabIndex: 4));
                        } else {
                          context.read<WorkOrderBloc>().add(
                              WorkOrderApplyFilter(
                                  workOrderFilterMap: workOrderFilterMap));
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, WorkOrderListScreen.routeName,
                              arguments: false);
                        }
                      }
                    },
                    textValue: DatabaseUtil.getText('Apply'))
              ])),
    );
  }
}
