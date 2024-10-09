import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';

import '../../blocs/accounting/accounting_event.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'manage_accounting_incoming_invoice_screen.dart';
import 'widgets/incomingInvoicesWidgets/incoming_invoice_filter_icon.dart';
import 'widgets/incomingInvoicesWidgets/incoming_invoices_subtitle.dart';
import 'widgets/incomingInvoicesWidgets/incoming_invoices_title.dart';

class IncomingInvoicesScreen extends StatelessWidget {
  static const routeName = 'IncomingInvoicesScreen';

  const IncomingInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(FetchIncomingInvoices(pageNo: 1));
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kIncomingInvoiceList),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, ManageAccountingIncomingInvoiceScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              const IncomingInvoiceFilterIcon(
                  routeName: IncomingInvoicesScreen.routeName),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<AccountingBloc, AccountingState>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingIncomingInvoices &&
                          currentState.pageNo == 1) ||
                      (currentState is IncomingInvoicesFetched) ||
                      (currentState is IncomingInvoicesWithNoData) ||
                      (currentState is NoRecordsFoundForFilter) ||
                      (currentState is FailedToFetchIncomingInvoices),
                  listener: (context, state) {
                    if (state is IncomingInvoicesFetched &&
                        context
                            .read<AccountingBloc>()
                            .incomingInvoicesReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingIncomingInvoices) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()));
                    } else if (state is IncomingInvoicesFetched) {
                      return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (context
                                      .read<AccountingBloc>()
                                      .incomingInvoicesReachedMax)
                                  ? state.incomingInvoices.length
                                  : state.incomingInvoices.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.incomingInvoices.length) {
                                  return CustomCard(
                                      child: ListTile(
                                          contentPadding: const EdgeInsets.all(
                                              xxTinierSpacing),
                                          title: IncomingInvoicesTitle(
                                              incomingInvoices: state
                                                  .incomingInvoices[index]),
                                          subtitle: IncomingInvoicesSubtitle(
                                              incomingInvoices: state
                                                  .incomingInvoices[index]),
                                          onTap: () {}));
                                } else {
                                  context.read<AccountingBloc>().add(
                                      FetchIncomingInvoices(
                                          pageNo: state.pageNo + 1));
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: xxTinySpacing);
                              }));
                    } else if (state is IncomingInvoicesWithNoData) {
                      return NoRecordsText(text: state.message);
                    } else if (state is NoRecordsFoundForFilter) {
                      return Expanded(
                          child: Center(child: Text(state.message)));
                    } else if (state is FailedToFetchIncomingInvoices) {
                      return Expanded(
                          child: Center(child: Text(state.errorMessage)));
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
