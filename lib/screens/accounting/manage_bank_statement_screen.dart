import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/attach_document_widget.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/bank_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/bankStatementWidgets/manage_bank_statement_button.dart';
import 'package:toolkit/screens/accounting/widgets/custom_month_picker_dropdown.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_year_picker_dropdown.dart';

import '../../blocs/accounting/accounting_bloc.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../widgets/generic_app_bar.dart';

class ManageBankStatementScreen extends StatelessWidget {
  static const routeName = 'ManageBankStatementScreen';

  const ManageBankStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().isInitialUpload = true;
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kAddBankStatement),
        bottomNavigationBar: const ManageBankStatementButton(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
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
                          onEntityChanged: (String entity) {
                            context
                                .read<AccountingBloc>()
                                .manageBankStatementMap['entity'] = entity;
                          },
                          selectedEntity: ''),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kBank,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      BankDropdown(onBankChanged: (String selectedBank) {
                        context
                            .read<AccountingBloc>()
                            .manageBankStatementMap['bank'] = selectedBank;
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
                          defaultMonth: ''),
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
                          defaultYear: ''),
                      const SizedBox(height: xxTinySpacing),
                      AttachDocumentWidget(
                          onUploadDocument: (List<dynamic> uploadDocList) {
                            context
                                    .read<AccountingBloc>()
                                    .manageBankStatementMap['files'] =
                                uploadDocList;
                          },
                          imagePickerBloc: ImagePickerBloc())
                    ]))));
  }
}
