import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_spacing.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../checklist/workforce/widgets/upload_image_section.dart';
import 'expense_add_item_currency_list_tile.dart';
import 'expense_added_image_count_widget.dart';

class ExpenseAddItemFormTwo extends StatelessWidget {
  const ExpenseAddItemFormTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExpenseAddItemCurrencyListTile(),
          Text(DatabaseUtil.getText('Amount'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              maxLength: 20,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              onTextFieldChanged: (String textField) {}),
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
              onTextFieldChanged: (String textField) {}),
          const SizedBox(height: xxTinySpacing),
          const ExpenseAddedImageCountWidget(),
          const SizedBox(height: xxTinierSpacing),
          UploadImageMenu(
              isUpload: true, onUploadImageResponse: (List uploadImageList) {}),
        ],
      ),
    );
  }
}
