import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../blocs/expense/expense_bloc.dart';
import '../../blocs/expense/expense_event.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/expense_tabs_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/status_tag.dart';
import 'expense_list_screen.dart';
import 'expense_details_tab_two.dart';
import 'expense_pop_up_menu_screen.dart';
import 'widgets/expense_details_tab_one.dart';
import 'widgets/expense_item_details_tab.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  static const routeName = 'ExpenseDetailsScreen';
  final String expenseId;

  const ExpenseDetailsScreen({Key? key, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(FetchExpenseDetails(tabIndex: 0, expenseId: expenseId));
    return Scaffold(
        appBar: GenericAppBar(
          actions: [
            BlocBuilder<ExpenseBloc, ExpenseStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is ExpenseDetailsFetched,
                builder: (context, state) {
                  if (state is ExpenseDetailsFetched) {
                    return ExpensePopUpMenuScreen(
                        popUpMenuOptions: state.popUpMenuList,
                        manageExpenseMap: state.manageExpenseMap);
                  } else {
                    return const SizedBox.shrink();
                  }
                })
          ],
        ),
        body: BlocConsumer<ExpenseBloc, ExpenseStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingExpenseDetails ||
              currentState is ExpenseDetailsFetched,
          listener: (context, state) {
            if (state is SubmittingExpenseForApproval) {
              ProgressBar.show(context);
            } else if (state is ExpenseForApprovalSubmitted) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, ExpenseListScreen.routeName,
                  arguments: false);
            } else if (state is ExpenseForApprovalFailedToSubmit) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.approvalFailedToSubmit, '');
            }
            if (state is ApprovingExpense) {
              ProgressBar.show(context);
            } else if (state is ExpenseApproved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, ExpenseListScreen.routeName,
                  arguments: false);
            } else if (state is ExpenseNotApproved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.notApproved, '');
            }
            if (state is ClosingExpense) {
              ProgressBar.show(context);
            } else if (State is ExpenseClosed) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, ExpenseListScreen.routeName,
                  arguments: false);
            } else if (state is ExpenseNotClosed) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.notClosed, '');
            }
            if (state is DeletingExpenseItem) {
              ProgressBar.show(context);
            } else if (state is ExpenseItemDeleted) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context
                  .read<ExpenseBloc>()
                  .add(FetchExpenseDetails(tabIndex: 2, expenseId: expenseId));
            } else if (state is ExpenseItemNotDeleted) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.itemNotDeleted, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingExpenseDetails) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExpenseDetailsFetched) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: xxTinierSpacing),
                  child: Column(children: [
                    Card(
                        color: AppColor.white,
                        elevation: kCardElevation,
                        child: ListTile(
                            title: Padding(
                                padding:
                                    const EdgeInsets.only(top: xxTinierSpacing),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          state.fetchExpenseDetailsModel.data
                                              .ref,
                                          style: Theme.of(context)
                                              .textTheme
                                              .medium),
                                      StatusTag(tags: [
                                        StatusTagModel(
                                            title: state
                                                .fetchExpenseDetailsModel
                                                .data
                                                .statustext,
                                            bgColor: AppColor.deepBlue)
                                      ])
                                    ])))),
                    const SizedBox(height: xxTinierSpacing),
                    const SizedBox(height: xxTinierSpacing),
                    (state.fetchExpenseDetailsModel.data.isdraft == '1')
                        ? Text(StringConstants.kExpenseDraftText,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.deepBlue))
                        : const SizedBox.shrink(),
                    const SizedBox(height: xxTinierSpacing),
                    const Divider(
                        height: kDividerHeight, thickness: kDividerWidth),
                    CustomTabBarView(
                        lengthOfTabs: 3,
                        tabBarViewIcons: ExpenseTabsUtil().tabBarViewIcons,
                        initialIndex: context.read<ExpenseBloc>().tabIndex,
                        tabBarViewWidgets: [
                          ExpenseDetailsTabOne(
                              tabIndex: 0,
                              expenseDetailsData:
                                  state.fetchExpenseDetailsModel.data,
                              expenseId: expenseId),
                          ExpenseDetailsTabTwo(
                              tabIndex: 1,
                              expenseDetailsData:
                                  state.fetchExpenseDetailsModel.data),
                          ExpenseItemDetailTab(
                              tabIndex: 2,
                              expenseDetailsData:
                                  state.fetchExpenseDetailsModel.data,
                              expenseId: expenseId)
                        ])
                  ]));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
