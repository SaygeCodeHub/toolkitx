import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/bank_statement_list_screen.dart';
import 'package:toolkit/screens/accounting/incoming_invoices_screen.dart';
import 'package:toolkit/screens/accounting/out_going_list_screen.dart';
import 'package:toolkit/utils/accounting_util.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/accounting/accounting_bloc.dart';

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  static const routeName = 'AccountingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAccounting),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 16 / 9,
                    crossAxisCount: 2,
                    crossAxisSpacing: leftRightMargin,
                    mainAxisSpacing: leftRightMargin),
                itemCount: accounting.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                      onTap: () {
                        _navigateToEquipmentModule(
                            accounting[index].accountingModuleName, context);
                      },
                      child: CustomCard(
                          color: AppColor.blueGrey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(accounting[index].icon,
                                    size: kAccountingModuleIconSize),
                                const SizedBox(
                                  height: xxTinierSpacing,
                                ),
                                Text(accounting[index].accountingModuleName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w700))
                              ])));
                })));
  }

  void _navigateToEquipmentModule(
      String equipmentModuleName, BuildContext context) {
    switch (equipmentModuleName) {
      case StringConstants.kOutGoingInvoice:
        Navigator.pushNamed(context, OutGoingListScreen.routeName,
            arguments: true);
        break;
      case StringConstants.kInComingInvoice:
        context.read<AccountingBloc>().accountingFilterMap.clear();
        context.read<AccountingBloc>().incomingInvoices.clear();
        Navigator.pushNamed(context, IncomingInvoicesScreen.routeName);
        break;
      case StringConstants.kBankStatement:
        Navigator.pushNamed(context, BankStatementListScreen.routeName);
        break;
    }
  }
}
