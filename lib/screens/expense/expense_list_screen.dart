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
import 'widgets/expense_list_body.dart';

class ExpenseListScreen extends StatelessWidget {
  static const routeName = 'ExpenseListScreen';

  const ExpenseListScreen({Key? key}) : super(key: key);
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<ExpenseBloc>().expenseListReachedMax = false;
    context.read<ExpenseBloc>().add(FetchExpenseList(pageNo: pageNo));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ExpenseReport')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            CustomIconButtonRow(
                primaryOnPress: () {},
                secondaryOnPress: () {},
                secondaryVisible: false,
                clearOnPress: () {}),
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
                    return Center(
                      child: NoRecordsText(
                          text: DatabaseUtil.getText('no_records_found')),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
