import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/expense/expense_state.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/android_pop_up.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';
import '../../../checklist/workforce/widgets/upload_image_section.dart';
import '../../expense_details_screen.dart';
import 'expense_add_item_currency_list_tile.dart';
import 'expense_edit_items_screen.dart';

class ExpenseEditFormThree extends StatelessWidget {
  static const routeName = 'ExpenseEditFormThree';

  const ExpenseEditFormThree({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseEditItemsScreen.editExpenseMap['amount'] =
        ExpenseEditItemsScreen.editExpenseMap['item_details_model'].amount ??
            '';
    ExpenseEditItemsScreen.editExpenseMap['description'] =
        ExpenseEditItemsScreen
                .editExpenseMap['item_details_model'].description ??
            '';
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEditItem),
      bottomNavigationBar: BlocListener<ExpenseBloc, ExpenseStates>(
        listener: (context, state) {
          if (state is SavingExpenseItem) {
            ProgressBar.show(context);
          } else if (state is ExpenseItemSaved) {
            ProgressBar.dismiss(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
                context, ExpenseDetailsScreen.routeName,
                arguments: state.expenseId);
          } else if (state is ExpenseItemCouldNotSave) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.itemNotSaved, '');
          }
        },
        child: BottomAppBar(
          child: PrimaryButton(
            onPressed: () {
              if (ExpenseEditItemsScreen.editExpenseMap.keys
                      .contains('workingatnumber') ==
                  false) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AndroidPopUp(
                          titleValue: StringConstants.kExpenseWorkingAtNumber,
                          contentValue: '',
                          textValue: StringConstants.kGoBack,
                          isNoVisible: false,
                          onPrimaryButton: () {
                            Navigator.pop(context);
                            context.read<ExpenseBloc>().add(FetchExpenseDetails(
                                tabIndex: 2,
                                expenseId: ExpenseEditItemsScreen
                                    .editExpenseMap['details_model'].id));
                          });
                    });
              } else {
                context.read<ExpenseBloc>().add(SaveExpenseItem(
                    expenseItemMap: ExpenseEditItemsScreen.editExpenseMap));
              }
            },
            textValue: DatabaseUtil.getText('buttonSave'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpenseAddItemCurrencyListTile(
                  expenseDetailsData:
                      ExpenseEditItemsScreen.editExpenseMap['details_model']),
              Text(DatabaseUtil.getText('Amount'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: ExpenseEditItemsScreen
                          .editExpenseMap['item_details_model'].amount ??
                      '',
                  maxLength: 20,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  onTextFieldChanged: (String textField) {
                    ExpenseEditItemsScreen.editExpenseMap['amount'] = textField;
                  }),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Description'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: ExpenseEditItemsScreen
                          .editExpenseMap['item_details_model'].description ??
                      '',
                  maxLength: 70,
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  onTextFieldChanged: (String textField) {
                    ExpenseEditItemsScreen.editExpenseMap['description'] =
                        textField;
                  }),
              const SizedBox(height: xxTinySpacing),
              UploadImageMenu(
                  isUpload: true,
                  onUploadImageResponse: (List uploadImageList) {
                    ExpenseEditItemsScreen.editExpenseMap['filenames'] =
                        uploadImageList
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
