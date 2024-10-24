import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/view_bank_statement_file.dart';
import 'package:toolkit/screens/accounting/widgets/custom_month_picker_dropdown.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_year_picker_dropdown.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';

class ManageBankStatementBody extends StatelessWidget {
  final bool isFromEdit;

  const ManageBankStatementBody({super.key, required this.isFromEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: leftRightMargin, right: leftRightMargin, top: xxTinySpacing),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kEntity,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            AccountingEntityDropdown(
                isFromEdit: isFromEdit,
                onEntityChanged: (String entity) {
                  context
                      .read<AccountingBloc>()
                      .manageBankStatementMap['entity'] = entity;
                },
                selectedEntity: context
                        .read<AccountingBloc>()
                        .manageBankStatementMap['entity'] ??
                    ''),
            const SizedBox(height: xxTinySpacing),
            BankDropdown(onBankChanged: (String selectedBank) {
              context.read<AccountingBloc>().manageBankStatementMap['bank'] =
                  selectedBank;
            }),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kStatementMonth,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            CustomMonthPickerDropdown(
                onMonthChanged: (String month) {
                  context
                      .read<AccountingBloc>()
                      .manageBankStatementMap['month'] = month;
                },
                defaultMonth: context
                        .read<AccountingBloc>()
                        .manageBankStatementMap['month'] ??
                    ''),
            const SizedBox(height: xxTinySpacing),
            Text(StringConstants.kStatementYear,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: xxxTinierSpacing),
            CustomYearPickerDropdown(
                onYearChanged: (String value) {
                  context
                      .read<AccountingBloc>()
                      .manageBankStatementMap['year'] = value;
                },
                defaultYear: context
                        .read<AccountingBloc>()
                        .manageBankStatementMap['year'] ??
                    ''),
            const SizedBox(height: xxTinySpacing),
            if (isFromEdit) const ViewBankStatementFile(),
            AttachDocumentWidget(
                onUploadDocument: (List<dynamic> uploadDocList) {
                  context
                      .read<AccountingBloc>()
                      .manageBankStatementMap['files'] = uploadDocList;
                },
                imagePickerBloc: ImagePickerBloc())
          ],
        ),
      ),
    );
  }
}
