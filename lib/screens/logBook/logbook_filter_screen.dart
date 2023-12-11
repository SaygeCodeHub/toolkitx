import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_events.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'logbook_list_screen.dart';
import 'widgets/logbook_acitivity_filter.dart';
import 'widgets/logbook_filter.dart';
import 'widgets/logbook_priority_filter.dart';
import 'widgets/logbook_status_filter.dart';
import 'widgets/logbook_type_filter.dart';

class LogBookFilterScreen extends StatelessWidget {
  static const routeName = 'LogBookFilterScreen';

  const LogBookFilterScreen({Key? key}) : super(key: key);
  static Map logbookFilterMap = {};
  static bool isFromLocation = false;
  static String expenseId = '';

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(FetchLogBookMaster());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kFilter),
        body: BlocConsumer<LogbookBloc, LogbookStates>(
            listener: (context, state) {
              if (state is LogBookMasterNotFetched) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
            },
            buildWhen: (previousState, currentState) =>
            currentState is LogBookFetchingMaster ||
                currentState is LogBookMasterFetched ||
                currentState is LogBookMasterNotFetched,
            builder: (context, state) {
              if (state is LogBookFetchingMaster) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogBookMasterFetched) {
                logbookFilterMap.addAll(state.filterMap);
                if (state.logBookFetchMasterModel.data.isNotEmpty) {
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
                                const SizedBox(height: xxTinySpacing),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: DatePickerTextField(
                                              editDate:
                                              (logbookFilterMap['st'] ==
                                                  null)
                                                  ? ''
                                                  : logbookFilterMap['st'],
                                              hintText:
                                              StringConstants.kSelectDate,
                                              onDateChanged: (String date) {
                                                logbookFilterMap['st'] = date;
                                              })),
                                      const SizedBox(width: xxTinierSpacing),
                                      const Text(StringConstants.kBis),
                                      const SizedBox(width: xxTinierSpacing),
                                      Expanded(
                                          child: DatePickerTextField(
                                              editDate:
                                              (logbookFilterMap['et'] ==
                                                  null)
                                                  ? ''
                                                  : logbookFilterMap['et'],
                                              hintText:
                                              StringConstants.kSelectDate,
                                              onDateChanged: (String date) {
                                                logbookFilterMap['et'] = date;
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
                                    value: (logbookFilterMap['kword'] == null)
                                        ? ''
                                        : logbookFilterMap['kword'],
                                    hintText: 'Keyword',
                                    onTextFieldChanged: (String textField) {
                                      logbookFilterMap['kword'] = textField;
                                    }),
                                const SizedBox(height: xxTinySpacing),
                                Text(DatabaseUtil.getText('type'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                LogbookTypeFilter(
                                    data: state.logBookFetchMasterModel.data,
                                    logbookFilterMap: logbookFilterMap),
                                const SizedBox(height: xxTinySpacing),
                                Text(DatabaseUtil.getText('Activity'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                LogBookActivityFilter(
                                    data: state.logBookFetchMasterModel.data,
                                    logbookFilterMap: logbookFilterMap),
                                const SizedBox(height: xxTinySpacing),
                                Text(DatabaseUtil.getText('LogBook'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                LogbookFilter(
                                    data: state.logBookFetchMasterModel.data,
                                    logbookFilterMap: logbookFilterMap),
                                const SizedBox(height: xxTinySpacing),
                                Text(DatabaseUtil.getText('Priority'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                LogbookPriorityFilter(
                                    logbookFilterMap: logbookFilterMap),
                                const SizedBox(height: xxTinySpacing),
                                Text(DatabaseUtil.getText('Status'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: xxxTinierSpacing),
                                LogbookStatusFilter(
                                    logbookFilterMap: logbookFilterMap),
                                const SizedBox(height: xxTinySpacing),
                                PrimaryButton(
                                    onPressed: () {
                                      if (logbookFilterMap['st'] != null &&
                                          logbookFilterMap['et'] == null ||
                                          logbookFilterMap['st'] == null &&
                                              logbookFilterMap['et'] != null) {
                                        showCustomSnackBar(
                                            context,
                                            DatabaseUtil.getText(
                                                'TimeDateValidate'),
                                            '');
                                      } else {
                                        if (isFromLocation == true) {
                                          context.read<LocationBloc>().add(
                                              ApplyLogBookListFilter(
                                                  filterMap: logbookFilterMap));
                                          Navigator.pop(context);
                                          context.read<LocationBloc>().add(
                                              FetchLocationDetails(
                                                  locationId: expenseId,
                                                  selectedTabIndex: 5));
                                        } else {
                                          context.read<LogbookBloc>().add(
                                              ApplyLogBookFilter(
                                                  filterMap: logbookFilterMap));
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(
                                              context,
                                              LogbookListScreen.routeName,
                                              arguments: false);
                                        }
                                      }
                                    },
                                    textValue: StringConstants.kApply)
                              ])));
                } else {
                  return Center(
                      child: Text(StringConstants.kNoData,
                          style: Theme.of(context).textTheme.medium));
                }
              } else {
                return const SizedBox();
              }
            }));
  }
}
