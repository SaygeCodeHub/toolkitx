import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../../blocs/expense/expense_bloc.dart';
import '../../../blocs/expense/expense_event.dart';
import '../../../blocs/expense/expense_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import 'addItemsWidgets/expense_item_list.dart';
import 'expense_details_tab_one.dart';

class ExpenseAddItemBottomBar extends StatelessWidget {
  final String expenseId;
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseAddItemBottomBar(
      {Key? key, required this.expenseId, required this.expenseDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseStates>(
      listener: (context, state) {
        if (state is SavingExpenseItem) {
          ProgressBar.show(context);
        } else if (state is ExpenseItemSaved) {
          ProgressBar.dismiss(context);
          context
              .read<ExpenseBloc>()
              .add(FetchExpenseDetails(tabIndex: 0, expenseId: expenseId));
        } else if (state is ExpenseItemCouldNotSave) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, state.itemNotSaved, '');
        }
      },
      buildWhen: (previousState, currentState) =>
          currentState is FetchingExpenseItemMaster ||
          currentState is ExpenseItemMasterFetched,
      builder: (context, state) {
        if (state is ExpenseItemMasterFetched) {
          if (state.isScreenChange == true) {
            return BottomAppBar(
              child: Row(children: [
                Expanded(
                    child: PrimaryButton(
                  onPressed: () {
                    if (ExpenseDetailsTabOne.manageItemsMap['itemid'] == '') {
                      context
                          .read<ExpenseBloc>()
                          .add(FetchExpenseItemMaster(isScreenChange: true));
                      ExpenseDetailsTabOne.manageItemsMap['itemid'] =
                          ExpenseItemList.itemId;
                      context
                          .read<ExpenseBloc>()
                          .add(FetchExpenseItemCustomFields(customFieldsMap: {
                            "itemid":
                                ExpenseDetailsTabOne.manageItemsMap['itemid'],
                            "expenseitemid": expenseDetailsData.id
                          }));
                    } else {
                      context
                          .read<ExpenseBloc>()
                          .add(FetchExpenseItemMaster(isScreenChange: false));
                    }
                  },
                  textValue: DatabaseUtil.getText('buttonBack'),
                )),
                const SizedBox(width: xxTinierSpacing),
                (ExpenseDetailsTabOne.manageItemsMap['itemid'] == '6' ||
                        ExpenseDetailsTabOne.manageItemsMap['itemid'] == '3')
                    ? Expanded(
                        child: PrimaryButton(
                            onPressed: () {
                              ExpenseDetailsTabOne.manageItemsMap['itemid'] =
                                  '';
                              context.read<ExpenseBloc>().add(
                                  FetchExpenseItemMaster(isScreenChange: true));
                            },
                            textValue: DatabaseUtil.getText('nextButtonText')))
                    : Expanded(
                        child: PrimaryButton(
                            onPressed: () {
                              if (ExpenseDetailsTabOne.manageItemsMap.keys
                                      .contains('workingatnumber') ==
                                  false) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AndroidPopUp(
                                          titleValue: StringConstants
                                              .kExpenseWorkingAtNumber,
                                          contentValue: '',
                                          textValue: StringConstants.kGoBack,
                                          isNoVisible: false,
                                          onPrimaryButton: () {
                                            Navigator.pop(context);
                                            context.read<ExpenseBloc>().add(
                                                FetchExpenseDetails(
                                                    tabIndex: 0,
                                                    expenseId: expenseId));
                                          });
                                    });
                              } else {
                                ExpenseDetailsTabOne.manageItemsMap['itemid'] =
                                    ExpenseItemList.itemId;
                                context.read<ExpenseBloc>().add(SaveExpenseItem(
                                    expenseItemMap:
                                        ExpenseDetailsTabOne.manageItemsMap));
                              }
                            },
                            textValue: DatabaseUtil.getText('buttonSave')))
              ]),
            );
          } else {
            return BottomAppBar(
              child: Row(children: [
                Expanded(
                    child: PrimaryButton(
                  onPressed: () {
                    context.read<ExpenseBloc>().add(
                        FetchExpenseDetails(tabIndex: 0, expenseId: expenseId));
                  },
                  textValue: DatabaseUtil.getText('buttonBack'),
                )),
                const SizedBox(width: xxTinierSpacing),
                Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          if (ExpenseDetailsTabOne.manageItemsMap['date'] ==
                                  null &&
                              ExpenseDetailsTabOne.manageItemsMap['itemid'] ==
                                  null) {
                            showCustomSnackBar(
                                context,
                                StringConstants
                                    .kExpenseAddItemDateAndItemValidation,
                                '');
                          } else {
                            if (ExpenseDetailsTabOne.manageItemsMap['itemid'] ==
                                '3') {
                              context.read<ExpenseBloc>().add(
                                  FetchExpenseItemMaster(isScreenChange: true));
                              context.read<ExpenseBloc>().add(
                                      FetchExpenseItemCustomFields(
                                          customFieldsMap: {
                                        "itemid": ExpenseDetailsTabOne
                                                .manageItemsMap['itemid'] ??
                                            '',
                                        "expenseitemid": expenseDetailsData.id
                                      }));
                            } else if (ExpenseDetailsTabOne
                                    .manageItemsMap['itemid'] ==
                                '6') {
                              context.read<ExpenseBloc>().add(
                                  FetchExpenseItemMaster(isScreenChange: true));
                              context.read<ExpenseBloc>().add(
                                      FetchExpenseItemCustomFields(
                                          customFieldsMap: {
                                        "itemid": ExpenseDetailsTabOne
                                                .manageItemsMap['itemid'] ??
                                            '',
                                        "expenseitemid": expenseDetailsData.id
                                      }));
                            } else {
                              context.read<ExpenseBloc>().add(
                                  FetchExpenseItemMaster(isScreenChange: true));
                            }
                          }
                        },
                        textValue: DatabaseUtil.getText('nextButtonText')))
              ]),
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
