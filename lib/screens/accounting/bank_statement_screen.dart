import 'package:flutter/material.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/add_bank_statement_button.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_statement_filter_icon.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_statement_list_section.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';

class BankStatementScreen extends StatelessWidget {
  static const routeName = 'BankStatementScreen';

  const BankStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenericAppBar(title: StringConstants.kBankStatementList),
      floatingActionButton: AddBankStatementButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: leftRightMargin, vertical: xxTinierSpacing),
        child: Column(
          children: [
            BankStatementFilterIcon(),
            SizedBox(height: xxTinierSpacing),
            BankStatementListSection()
          ],
        ),
      ),
    );
  }
}
