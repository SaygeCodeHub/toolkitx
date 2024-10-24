import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/accounting/fetch_bank_statements_model.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/custom_card.dart';
import 'bank_statement_list_subtitle.dart';
import 'bank_statement_list_title.dart';

class BankStatementListBody extends StatelessWidget {
  final List<BankStatementsDatum> bankStatements;
  final int pageNo;

  const BankStatementListBody(
      {super.key, required this.bankStatements, required this.pageNo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: (context.read<AccountingBloc>().bankStatementsReachedMax)
                ? bankStatements.length
                : bankStatements.length + 1,
            itemBuilder: (context, index) {
              if (index < bankStatements.length) {
                return CustomCard(
                    child: ListTile(
                        contentPadding: const EdgeInsets.all(xxTinierSpacing),
                        title: BankStatementListTitle(
                            bankStatement: bankStatements[index]),
                        subtitle: BankStatementListSubtitle(
                            bankStatement: bankStatements[index])));
              } else {
                context
                    .read<AccountingBloc>()
                    .add(FetchBankStatements(pageNo: pageNo + 1));
                return const Center(child: CircularProgressIndicator());
              }
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinySpacing);
            }));
  }
}
