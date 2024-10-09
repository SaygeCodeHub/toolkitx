import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/invoice_currency_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/client_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/manage_accounting_outgoing_invoice_section.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/project_dropdown.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class ManageAccountingIOutgoingInvoice extends StatelessWidget {
  static const routeName = 'AccountingAddOutgoingInvoice';

  const ManageAccountingIOutgoingInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String selectedEntity = '';
    String selectedClient = '';
    String selectedProject = '';
    String selectedDate = '';
    return Scaffold(
        appBar: const GenericAppBar(title: 'Add Outgoing Invoice'),
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (selectedEntity.isNotEmpty &&
                        selectedClient.isNotEmpty &&
                        selectedProject.isNotEmpty &&
                        selectedDate.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        ManageAccountingOutgoingInvoiceSection.routeName,
                      );
                    } else {
                      showCustomSnackBar(
                          context,
                          StringConstants
                              .kEntityClientProjectInvoiceDAteCanNotBeEmpty,
                          '');
                    }
                  }
                },
                textValue: StringConstants.kNext,
              ),
            ),
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinySpacing),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
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
                      selectedEntity = entity;
                      context
                          .read<AccountingBloc>()
                          .manageOutgoingInvoiceMap['entity'] = entity;
                    },
                    selectedEntity: '',
                  ),
                  const SizedBox(height: xxTinySpacing),
                  Text(StringConstants.kClient,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  ClientDropdown(onClientChanged: (String client) {
                    selectedClient = client;
                    context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['client'] = client;
                  }),
                  const SizedBox(height: xxTinySpacing),
                  Text('Project',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  ProjectDropdown(onProjectChanged: (String project) {
                    selectedProject = project;
                    context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['project'] = project;
                  }),
                  const SizedBox(height: xxTinySpacing),
                  Text('Invoice Date',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  DatePickerTextField(
                    onDateChanged: (String date) {
                      selectedDate = date;
                      context
                          .read<AccountingBloc>()
                          .manageOutgoingInvoiceMap['date'] = date;
                    },
                  ),
                  const SizedBox(height: xxTinySpacing),
                  Text('Invoice Currency',
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: xxxTinierSpacing),
                  InvoiceCurrencyDropdown(
                    onCurrencySelected: (String currency) {
                      context
                          .read<AccountingBloc>()
                          .manageOutgoingInvoiceMap['othercurrency'] = currency;
                    },
                    manageInvoiceMap:
                        context.read<AccountingBloc>().manageOutgoingInvoiceMap,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
