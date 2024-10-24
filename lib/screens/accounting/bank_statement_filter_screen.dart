import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_dropdown.dart';
import 'package:toolkit/widgets/custom_year_picker_dropdown.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';

class BankStatementFilterScreen extends StatelessWidget {
  static const routeName = 'BankStatementFilterScreen';

  const BankStatementFilterScreen({super.key});

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
                            .bankStatementFilterMap['entity'] = entityId;
                      },
                      selectedEntity: context
                              .read<AccountingBloc>()
                              .bankStatementFilterMap['entity'] ??
                          ''),
                  const SizedBox(height: xxTinySpacing),
                  BankDropdown(
                    onBankChanged: (String selectedBank) {
                      context
                          .read<AccountingBloc>()
                          .bankStatementFilterMap['bank'] = selectedBank;
                    },
                  ),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kYear,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxTinierSpacing),
                  CustomYearPickerDropdown(
                      onYearChanged: (String year) {
                        context
                            .read<AccountingBloc>()
                            .bankStatementFilterMap['year'] = year;
                      },
                      defaultYear: context
                              .read<AccountingBloc>()
                              .bankStatementFilterMap['year'] ??
                          ''),
                  const SizedBox(height: xxTinySpacing),
                  const SizedBox(height: xxxSmallerSpacing),
                  PrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<AccountingBloc>().bankStatements.clear();
                        context.read<AccountingBloc>().add(FetchBankStatements(
                            pageNo: 1, isFilterEnabled: true));
                      },
                      textValue: DatabaseUtil.getText('Apply'))
                ])),
      ),
    );
  }
}
