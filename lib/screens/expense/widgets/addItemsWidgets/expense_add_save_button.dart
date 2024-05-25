import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/expense/expense_state.dart';

import '../../../../blocs/expense/expense_bloc.dart';
import '../../../../blocs/expense/expense_event.dart';
import '../../../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_bloc.dart';
import '../../../../blocs/uploadImage/upload_image_event.dart';
import '../../../../blocs/uploadImage/upload_image_state.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/generic_loading_popup.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/progress_bar.dart';
import '../expense_details_tab_one.dart';
import 'expense_item_list.dart';

class AddExpenseSaveButton extends StatelessWidget {
  const AddExpenseSaveButton({
    super.key,
    required this.expenseId,
  });

  final String expenseId;

  @override
  Widget build(BuildContext context) {
    ExpenseDetailsTabOne.manageItemsMap['itemid'] = ExpenseItemList.itemId;
    return MultiBlocListener(
      listeners: [
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (context, state) {
            if (state is UploadingImage) {
              GenericLoadingPopUp.show(context, StringConstants.kUploadFiles);
            } else if (state is ImageUploaded) {
              GenericLoadingPopUp.dismiss(context);
              ExpenseDetailsTabOne.manageItemsMap['filenames'] = state.images
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(' ', '');
              context.read<ExpenseBloc>().add(SaveExpenseItem(
                  expenseItemMap: ExpenseDetailsTabOne.manageItemsMap));
            } else if (state is ImageCouldNotUpload) {
              GenericLoadingPopUp.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
        ),
        BlocListener<ExpenseBloc, ExpenseStates>(
          listener: (context, state) {
            if (state is SavingExpenseItem) {
              ProgressBar.show(context);
            } else if (state is ExpenseItemSaved) {
              ProgressBar.dismiss(context);
              context.read<ExpenseBloc>().expenseListData.clear();
              context
                  .read<ExpenseBloc>()
                  .add(FetchExpenseDetails(tabIndex: 0, expenseId: expenseId));
            } else if (state is ExpenseItemCouldNotSave) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.itemNotSaved, '');
            }
          },
        ),
      ],
      child: PrimaryButton(
          onPressed: () {
            if (ExpenseDetailsTabOne.manageItemsMap['pickedImage'] != null &&
                ExpenseDetailsTabOne.manageItemsMap['pickedImage'].isNotEmpty) {
              context.read<UploadImageBloc>().add(UploadImage(
                  images: ExpenseDetailsTabOne.manageItemsMap['pickedImage'],
                  imageLength:
                      context.read<ImagePickerBloc>().lengthOfImageList));
            } else {
              context.read<ExpenseBloc>().add(SaveExpenseItem(
                  expenseItemMap: ExpenseDetailsTabOne.manageItemsMap));
            }
          },
          textValue: DatabaseUtil.getText('buttonSave')),
    );
  }
}
