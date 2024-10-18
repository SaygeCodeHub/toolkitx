import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_no_records_text.dart';
import '../../../../widgets/progress_bar.dart';
import 'bank_statement_list_body.dart';

class BankStatementListSection extends StatelessWidget {
  const BankStatementListSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(FetchBankStatements(pageNo: 1));
    return BlocConsumer<AccountingBloc, AccountingState>(
        buildWhen: (previousState, currentState) =>
            (currentState is FetchingBankStatements &&
                currentState.pageNo == 1) ||
            (currentState is BankStatementsFetched) ||
            (currentState is BankStatementsWithNoData) ||
            (currentState is NoRecordsFoundForFilter) ||
            (currentState is FailedToFetchBankStatements),
        listener: (context, state) {
          if (state is BankStatementsFetched &&
              context.read<AccountingBloc>().bankStatementsReachedMax) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }

          if (state is DeletingBankStatement) {
            ProgressBar.show(context);
          } else if (state is BankStatementDeleted) {
            ProgressBar.dismiss(context);
            context.read<AccountingBloc>().bankStatements.clear();
            context.read<AccountingBloc>().add(FetchBankStatements(pageNo: 1));
          } else if (state is FailedToDeleteBankStatement) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.errorMessage, '');
          }
        },
        builder: (context, state) {
          if (state is FetchingBankStatements) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is BankStatementsFetched) {
            return BankStatementListBody(
                bankStatements: state.bankStatements, pageNo: state.pageNo);
          } else if (state is BankStatementsWithNoData) {
            return NoRecordsText(text: state.message);
          } else if (state is NoRecordsFoundForFilter) {
            return Expanded(child: Center(child: Text(state.message)));
          } else if (state is FailedToFetchBankStatements) {
            return Expanded(child: Center(child: Text(state.errorMessage)));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
