import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../blocs/expense/expense_event.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import 'expense_filter_screen.dart';
import 'manage_expense_form_screen.dart';
import 'widgets/expense_list_body.dart';

class ExpenseListScreen extends StatelessWidget {
  static const routeName = 'ExpenseListScreen';
  final bool isFromHome;

  const ExpenseListScreen({super.key, this.isFromHome = false});
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<ExpenseBloc>().expenseListReachedMax = false;
    context.read<ExpenseBloc>().expenseListData.clear();
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseList(pageNo: 1, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ExpenseReport')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              ManageExpenseFormScreen.isFromEditOption = false;
              Navigator.pushNamed(context, ManageExpenseFormScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<ExpenseBloc, ExpenseStates>(
                buildWhen: (previousState, currentState) {
                  if (currentState is FetchingExpenses && isFromHome == true) {
                    return true;
                  } else if (currentState is ExpensesFetched) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is ExpensesFetched) {
                    return CustomIconButtonRow(
                        primaryOnPress: () {
                          Navigator.pushNamed(
                              context, ExpenseFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        secondaryVisible: false,
                        clearVisible:
                            state.filtersMap.isNotEmpty && isFromHome != true,
                        clearOnPress: () {
                          pageNo = 1;
                          context.read<ExpenseBloc>().expenseListReachedMax =
                              false;
                          context.read<ExpenseBloc>().expenseListData.clear();
                          context.read<ExpenseBloc>().add(ExpenseClearFilter());
                          context.read<ExpenseBloc>().add(FetchExpenseList(
                              pageNo: 1, isFromHome: isFromHome));
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<ExpenseBloc, ExpenseStates>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingExpenses && pageNo == 1) ||
                      (currentState is ExpensesFetched),
                  listener: (context, state) {
                    if (state is ExpensesFetched &&
                        context.read<ExpenseBloc>().expenseListReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingExpenses) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is ExpensesFetched) {
                      if (state.expenseListDatum.isNotEmpty) {
                        return ExpenseListBody(
                            expenseListDatum: state.expenseListDatum);
                      } else {
                        return NoRecordsText(
                            text: DatabaseUtil.getText('no_records_found'));
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
            ])));
  }
}
