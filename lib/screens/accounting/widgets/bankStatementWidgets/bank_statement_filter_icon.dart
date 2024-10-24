import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/screens/accounting/bank_statement_filter_screen.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';

class BankStatementFilterIcon extends StatelessWidget {
  const BankStatementFilterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) {
        if (currentState is FetchingBankStatements) {
          return true;
        } else if (currentState is BankStatementsFetched) {
          return true;
        } else if (currentState is NoRecordsFoundForFilter) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is BankStatementsFetched) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(
                    context, BankStatementFilterScreen.routeName);
              },
              secondaryVisible: false,
              clearVisible: context
                  .read<AccountingBloc>()
                  .bankStatementFilterMap
                  .isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().bankStatementFilterMap.clear();
                context.read<AccountingBloc>().bankStatementsReachedMax = false;
                context
                    .read<AccountingBloc>()
                    .add(FetchBankStatements(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else if (state is NoRecordsFoundForFilter) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(
                    context, BankStatementFilterScreen.routeName);
              },
              secondaryVisible: false,
              clearVisible: context
                  .read<AccountingBloc>()
                  .bankStatementFilterMap
                  .isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().bankStatementFilterMap.clear();
                context.read<AccountingBloc>().bankStatementsReachedMax = false;
                context
                    .read<AccountingBloc>()
                    .add(FetchBankStatements(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
