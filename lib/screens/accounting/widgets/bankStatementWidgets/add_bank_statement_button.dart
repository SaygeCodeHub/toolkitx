import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../manage_bank_statement_screen.dart';

class AddBankStatementButton extends StatelessWidget {
  const AddBankStatementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          context.read<AccountingBloc>().manageBankStatementMap.clear();
          Navigator.pushNamed(context, ManageBankStatementScreen.routeName,
              arguments: false);
        },
        child: const Icon(Icons.add));
  }
}
