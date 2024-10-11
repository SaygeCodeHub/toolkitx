import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_statement_filter_icon.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../blocs/accounting/accounting_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'manage_bank_statement_screen.dart';

class BankStatementScreen extends StatelessWidget {
  static const routeName = 'BankStatementScreen';

  const BankStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(FetchBankStatements(pageNo: 1));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kBankStatementList),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageBankStatementScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              const BankStatementFilterIcon(),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<AccountingBloc, AccountingState>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingBankStatements &&
                          currentState.pageNo == 1) ||
                      (currentState is BankStatementsFetched) ||
                      (currentState is BankStatementsWithNoData) ||
                      (currentState is NoRecordsFoundForFilter) ||
                      (currentState is FailedToFetchBankStatements),
                  listener: (context, state) {
                    if (state is BankStatementsFetched &&
                        context
                            .read<AccountingBloc>()
                            .bankStatementsReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingBankStatements) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()));
                    } else if (state is BankStatementsFetched) {
                      return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (context
                                      .read<AccountingBloc>()
                                      .bankStatementsReachedMax)
                                  ? state.bankStatements.length
                                  : state.bankStatements.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.bankStatements.length) {
                                  return CustomCard(
                                      child: ListTile(
                                          contentPadding: const EdgeInsets.all(
                                              xxTinierSpacing),
                                          title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: xxTinierSpacing),
                                              child: Text(
                                                  state.bankStatements[index]
                                                      .entity,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .small
                                                      .copyWith(
                                                          color: AppColor.black,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                          subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state.bankStatements[index]
                                                        .bank,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color:
                                                                AppColor.grey)),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Row(children: [
                                                  Image.asset(
                                                      "assets/icons/calendar.png",
                                                      height: kIconSize,
                                                      width: kIconSize),
                                                  const SizedBox(
                                                      width: tiniestSpacing),
                                                  Text(
                                                      state
                                                          .bankStatements[index]
                                                          .date,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .xSmall
                                                          .copyWith(
                                                              color: AppColor
                                                                  .grey))
                                                ]),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Text(
                                                    state.bankStatements[index]
                                                        .file,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color:
                                                                AppColor.grey))
                                              ]),
                                          onTap: () {}));
                                } else {
                                  context.read<AccountingBloc>().add(
                                      FetchBankStatements(
                                          pageNo: state.pageNo + 1));
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: xxTinySpacing);
                              }));
                    } else if (state is BankStatementsWithNoData) {
                      return NoRecordsText(text: state.message);
                    } else if (state is NoRecordsFoundForFilter) {
                      return Expanded(
                          child: Center(child: Text(state.message)));
                    } else if (state is FailedToFetchBankStatements) {
                      return Expanded(
                          child: Center(child: Text(state.errorMessage)));
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
