import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/manage_bank_statement_body.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/manage_bank_statement_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../blocs/accounting/accounting_state.dart';
import '../../widgets/generic_app_bar.dart';

class ManageBankStatementScreen extends StatelessWidget {
  static const routeName = 'ManageBankStatementScreen';
  final bool isFromEdit;

  const ManageBankStatementScreen({super.key, this.isFromEdit = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAddBankStatement),
        bottomNavigationBar: ManageBankStatementButton(isFromEdit: isFromEdit),
        body: BlocBuilder<AccountingBloc, AccountingState>(
          buildWhen: (previous, current) =>
              (current is FetchingBankStatement) ||
              (current is BankStatementFetched) ||
              (current is BankStatementNotFetched),
          builder: (context, state) {
            if (state is FetchingBankStatement) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).width / 1.2),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is BankStatementFetched) {
              return ManageBankStatementBody(isFromEdit: isFromEdit);
            } else if (state is BankStatementNotFetched) {
              return Center(child: Text(state.errorMessage));
            } else {
              return ManageBankStatementBody(isFromEdit: isFromEdit);
            }
          },
        ));
  }
}
