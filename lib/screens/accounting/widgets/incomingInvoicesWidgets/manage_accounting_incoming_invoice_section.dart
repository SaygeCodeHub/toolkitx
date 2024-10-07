import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../../widgets/primary_button.dart';
import 'billable_dropdown.dart';

class ManageAccountingIncomingInvoiceSection extends StatelessWidget {
  static const routeName = 'ManageAccountingIncomingInvoiceSection';

  const ManageAccountingIncomingInvoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: 'Add Incoming Invoice'),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textValue: StringConstants.kBack),
          ),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
            child: PrimaryButton(
                onPressed: () {}, textValue: StringConstants.kSave),
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Currency',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              BillableDropdown(onBillableChanged: (String selectedValue) {}),
              const SizedBox(height: xxTinySpacing),
              Text('Amount(EUR)',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(onTextFieldChanged: (String value) {}),
              const SizedBox(height: xxTinySpacing),
              Text('Currency',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              BillableDropdown(onBillableChanged: (String selectedValue) {}),
              const SizedBox(height: xxTinySpacing),
              Text('Amount(Other)',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(onTextFieldChanged: (String value) {}),
              const SizedBox(height: xxTinySpacing),
              Text('Comments',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  maxLines: 5, onTextFieldChanged: (String value) {}),
              const SizedBox(height: xxTinySpacing),
              Text('Attached Documents',
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              // UploadImageMenu(
              //     onUploadImageResponse: (List<dynamic> uploadImageList) {},
              //     imagePickerBloc: context.read<ImagePickerBloc>()),
              const SizedBox(height: xxTinySpacing)
            ],
          ),
        ),
      ),
    );
  }
}
