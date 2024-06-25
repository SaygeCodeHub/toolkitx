import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_spacing.dart';
import '../../../../data/models/expense/fetch_expense_details_model.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../checklist/workforce/widgets/upload_image_section.dart';
import '../expense_details_tab_one.dart';
import 'expense_add_item_currency_list_tile.dart';

class ExpenseAddItemFormTwo extends StatelessWidget {
  final ExpenseDetailsData expenseDetailsData;

  const ExpenseAddItemFormTwo({Key? key, required this.expenseDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpenseAddItemCurrencyListTile(
              expenseDetailsData: expenseDetailsData),
          Text(DatabaseUtil.getText('Amount'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              maxLength: 20,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              onTextFieldChanged: (String textField) {
                ExpenseDetailsTabOne.manageItemsMap['amount'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          Text(DatabaseUtil.getText('Description'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              maxLength: 70,
              maxLines: 2,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              onTextFieldChanged: (String textField) {
                ExpenseDetailsTabOne.manageItemsMap['description'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          UploadImageMenu(
              isUpload: true,
              onUploadImageResponse: (List uploadImageList) {
                ExpenseDetailsTabOne.manageItemsMap['pickedImage'] =
                    uploadImageList;
              }),
        ],
      ),
    );
  }
}
