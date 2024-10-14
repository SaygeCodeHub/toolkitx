import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/accounting/widgets/accounting_entity_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/invoice_currency_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/client_dropdown.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/edit_outgoing_invoice_section.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/project_dropdown.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class EditOutgoingInvoiceScreen extends StatelessWidget {
  static const routeName = 'EditOutgoingInvoiceScreen';

  const EditOutgoingInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
String clientId ="";

    return Scaffold(
        appBar: const GenericAppBar(title: 'Edit Outgoing Invoice'),
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
                    if (context
                        .read<AccountingBloc>()
                        .manageOutgoingInvoiceMap['entity'].isNotEmpty &&
                        context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap["client"].isNotEmpty &&
                        context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap['project'].isNotEmpty &&
                        context
                            .read<AccountingBloc>()
                            .manageOutgoingInvoiceMap["date"].isNotEmpty

                    ) {
                      Navigator.pushNamed(
                          context, EditOutgoingInvoiceSection.routeName,
                          arguments: clientId);
                    } else {
                      showCustomSnackBar(
                          context,
                          StringConstants
                              .kEntityClientProjectInvoiceDateCanNotBeEmpty,
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
              child: BlocBuilder<AccountingBloc, AccountingState>(
                buildWhen: (previousState, currentState) =>
                    (currentState is FetchingOutgoingInvoice) ||
                    (currentState is OutgoingInvoiceFetched) ||
                    (currentState is FailedToFetchOutgoingInvoice),
                builder: (context, state) {
                  if (state is FetchingOutgoingInvoice) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.5),
                      child: const CircularProgressIndicator(),
                    ));
                  } else if (state is OutgoingInvoiceFetched) {
                     clientId = state.clientId;
                    return Column(
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
                                .manageOutgoingInvoiceMap['entity'] = entity;
                          },
                          selectedEntity:  context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['entity']?? '',
                        ),
                        const SizedBox(height: xxTinySpacing),
                        Text(StringConstants.kClient,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        ClientDropdown(
                          onClientChanged: (String client) {
                            context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap['client'] = client;
                          },
                          initialValue: context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['clientname']?? '',
                        ),
                        const SizedBox(height: xxTinySpacing),
                        Text('Project',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        ProjectDropdown(
                          onProjectChanged: (String project) {
                            context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap['project'] = project;
                          },
                          initialValue:  context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['projectname']?? '',
                        ),
                        const SizedBox(height: xxTinySpacing),
                        Text('Invoice Date',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        DatePickerTextField(
                          onDateChanged: (String date) {
                            context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap['date'] = date;
                          },
                          editDate: context
                              .read<AccountingBloc>()
                              .manageOutgoingInvoiceMap['date']?? '',
                        ),
                        const SizedBox(height: xxTinySpacing),
                        Text('Invoice Currency',
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        InvoiceCurrencyDropdown(
                            onInvoiceCurrencySelected: (String currency) {
                              context
                                      .read<AccountingBloc>()
                                      .manageOutgoingInvoiceMap[
                                  'othercurrency'] = currency;
                            },
                            manageInvoiceMap: context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap,
                            initialCurrency:
                            context.read<AccountingBloc>().manageOutgoingInvoiceMap[
                            'othercurrencyname'] == "" ?
                            context.read<AccountingBloc>().manageOutgoingInvoiceMap[
                            'defaultcurrency'] : 'Other',
                            initialOtherCurrencyName:
                            context.read<AccountingBloc>().manageOutgoingInvoiceMap[
                            'othercurrencyname'] ??
                                '',
                            initialOtherCurrency: context
                                .read<AccountingBloc>()
                                .manageOutgoingInvoiceMap[
                            'othercurrencyname']?? ''),
                      ],
                    );
                  } else if (state is FailedToFetchOutgoingInvoice) {
                    return Expanded(
                        child: Center(child: Text(state.errorMessage)));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ));
  }
}
