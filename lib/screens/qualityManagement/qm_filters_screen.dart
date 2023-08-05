import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'qm_list_screen.dart';
import 'widgets/qm_status_filter.dart';

class QualityManagementFilterScreen extends StatelessWidget {
  static const routeName = 'QualityManagementFilterScreen';

  QualityManagementFilterScreen({Key? key}) : super(key: key);
  final Map qmFilterMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        SelectQualityManagementStatusFilter(
            statusList: (qmFilterMap['status'] == null)
                ? []
                : qmFilterMap['status']
                    .toString()
                    .replaceAll(' ', '')
                    .split(','),
            statusId: ''));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
        body: BlocBuilder<QualityManagementBloc, QualityManagementStates>(
            buildWhen: (previousState, currentState) =>
                currentState is QualityManagementListFetched,
            builder: (context, state) {
              if (state is QualityManagementListFetched) {
                qmFilterMap.addAll(state.filtersMap);
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(DatabaseUtil.getText('DateRange'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxTinySpacing),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: DatePickerTextField(
                                        editDate: qmFilterMap["st"] ?? '',
                                        hintText: StringConstants.kSelectDate,
                                        onDateChanged: (String date) {
                                          qmFilterMap["st"] = date;
                                        })),
                                const SizedBox(width: xxTinierSpacing),
                                Text(DatabaseUtil.getText('to')),
                                const SizedBox(width: xxTinierSpacing),
                                Expanded(
                                    child: DatePickerTextField(
                                        editDate: qmFilterMap["et"] ?? '',
                                        hintText:
                                            DatabaseUtil.getText('SelectDate'),
                                        onDateChanged: (String date) {
                                          qmFilterMap["et"] = date;
                                        }))
                              ]),
                          const SizedBox(height: xxTinySpacing),
                          Text(DatabaseUtil.getText('Status'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxTinySpacing),
                          BlocBuilder<QualityManagementBloc,
                                  QualityManagementStates>(
                              builder: (context, state) {
                            if (state
                                is QualityManagementFilterStatusSelected) {
                              qmFilterMap['status'] = state.selectedStatusList
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', '')
                                  .replaceAll(' ', '');
                              return QualityManagementStatusFilter(
                                  selectedStatusList: state.selectedStatusList);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                          const SizedBox(height: xxxSmallerSpacing),
                          PrimaryButton(
                              onPressed: () {
                                if (qmFilterMap['st'] != null &&
                                        qmFilterMap['et'] == null ||
                                    qmFilterMap['st'] == null &&
                                        qmFilterMap['et'] != null) {
                                  showCustomSnackBar(
                                      context,
                                      DatabaseUtil.getText('TimeDateValidate'),
                                      '');
                                } else {
                                  context.read<QualityManagementBloc>().add(
                                      QualityManagementApplyFilter(
                                          filtersMap: qmFilterMap));
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context,
                                      QualityManagementListScreen.routeName,
                                      arguments: false);
                                }
                              },
                              textValue: DatabaseUtil.getText('Apply'))
                        ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
