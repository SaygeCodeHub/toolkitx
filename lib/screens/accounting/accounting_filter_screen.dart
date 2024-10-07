import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_year_picker_dropdown.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'widgets/accounting_client_dropdown.dart';
import 'widgets/accounting_entity_dropdown.dart';

class AccountingFilterScreen extends StatelessWidget {
  static const routeName = 'AccountingFilterScreen';

  const AccountingFilterScreen(
      {super.key,
      required this.accountingFilterMap,
      required this.currentRouteName});

  final Map accountingFilterMap;
  final String currentRouteName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kApplyFilter),
      body: SingleChildScrollView(
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
                  Text(StringConstants.kInvoiceYear,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  CustomYearPickerDropdown(
                      onYearChanged: (String year) {
                        accountingFilterMap['year'] = year;
                      },
                      defaultYear: accountingFilterMap['year'] ?? ''),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('StartDate'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  DatePickerTextField(
                      editDate: accountingFilterMap['st'] ?? '',
                      hintText: StringConstants.kSelectStartDate,
                      onDateChanged: (String date) {
                        accountingFilterMap['st'] = date;
                      }),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('EndDate'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  DatePickerTextField(
                      editDate: accountingFilterMap['et'] ?? '',
                      hintText: StringConstants.kSelectEndDate,
                      onDateChanged: (String date) {
                        accountingFilterMap['et'] = date;
                      }),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kEntity,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  AccountingEntityDropdown(
                      onEntityChanged: (String entityId) {
                        accountingFilterMap['entity'] = entityId;
                      },
                      selectedEntity: accountingFilterMap['entity'] ?? ''),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kClient,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  AccountingClientDropdown(
                      onClientChanged: (String clientId) {
                        accountingFilterMap['client'] = clientId;
                      },
                      selectedClient: accountingFilterMap['client'] ?? ''),
                  const SizedBox(height: xxxSmallerSpacing),
                  PrimaryButton(
                      onPressed: () {
                        final startDate = accountingFilterMap['st'] ?? '';
                        final endDate = accountingFilterMap['et'] ?? '';

                        if (startDate.isNotEmpty &&
                            endDate.isNotEmpty &&
                            endDate.compareTo(startDate) <= 0) {
                          showCustomSnackBar(context,
                              'End date must be greater than start date.', '');
                        } else {
                          Navigator.pop(context);
                          switch (currentRouteName) {
                            case 'IncomingInvoicesScreen':
                              context.read<AccountingBloc>().incomingInvoices.clear();
                              context.read<AccountingBloc>().add(
                                  FetchIncomingInvoices(
                                      pageNo: 1, isFilterEnabled: true),
                              );
                              break;
                            case 'OutGoingListScreen':
                              context.read<AccountingBloc>().outgoingInvoices.clear();
                              context
                                  .read<AccountingBloc>()
                                  .add(FetchOutgoingInvoices(pageNo: 1));
                              break;
                          }
                        }

                      },
                      textValue: DatabaseUtil.getText('Apply'))
                ])),
      ),
    );
  }
}
