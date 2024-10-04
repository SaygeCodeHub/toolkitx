import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_year_picker_dropdown.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'widgets/accounting_client_dropdown.dart';
import 'widgets/incomingInvoicesWidgets/accounting_entity_dropdown.dart';

class AccountingFilterScreen extends StatelessWidget {
  static const routeName = 'IncomingInvoicesFilterScreen';

  const AccountingFilterScreen({super.key});

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
                        context
                            .read<AccountingBloc>()
                            .accountingFilterMap['year'] = year;
                      },
                      defaultYear: context
                              .read<AccountingBloc>()
                              .accountingFilterMap['year'] ??
                          ''),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('StartDate'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  DatePickerTextField(
                      editDate: context
                              .read<AccountingBloc>()
                              .accountingFilterMap['st'] ??
                          '',
                      hintText: StringConstants.kSelectStartDate,
                      onDateChanged: (String date) {
                        context
                            .read<AccountingBloc>()
                            .accountingFilterMap['st'] = date;
                      }),
                  const SizedBox(height: xxTinySpacing),
                  Text(DatabaseUtil.getText('EndDate'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  DatePickerTextField(
                      editDate: context
                              .read<AccountingBloc>()
                              .accountingFilterMap['et'] ??
                          '',
                      hintText: StringConstants.kSelectEndDate,
                      onDateChanged: (String date) {
                        context
                            .read<AccountingBloc>()
                            .accountingFilterMap['et'] = date;
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
                        context
                            .read<AccountingBloc>()
                            .accountingFilterMap['entity'] = entityId;
                      },
                      selectedEntity: context
                              .read<AccountingBloc>()
                              .accountingFilterMap['entity'] ??
                          ''),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kClient,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  AccountingClientDropdown(
                      onClientChanged: (String clientId) {
                        context
                            .read<AccountingBloc>()
                            .accountingFilterMap['client'] = clientId;
                      },
                      selectedClient: context
                              .read<AccountingBloc>()
                              .accountingFilterMap['client'] ??
                          ''),
                  const SizedBox(height: xxxSmallerSpacing),
                  PrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<AccountingBloc>()
                            .add(FetchIncomingInvoices(pageNo: 1));
                      },
                      textValue: DatabaseUtil.getText('Apply'))
                ])),
      ),
    );
  }
}
