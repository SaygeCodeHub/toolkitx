import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/screens/accounting/widgets/incomingInvoicesWidgets/manage_incoming_invoice_bottom_bar.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/manage_accounting_incoming_invoice_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../blocs/accounting/accounting_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class ManageAccountingIncomingInvoiceScreen extends StatelessWidget {
  static const routeName = 'AccountingAddIncomingInvoice';
  final bool isFromEdit;
  const ManageAccountingIncomingInvoiceScreen(
      {super.key, required this.isFromEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: isFromEdit
                ? StringConstants.kEditIncomingInvoice
                : StringConstants.kAddIncomingInvoice),
        bottomNavigationBar:
            ManageIncomingInvoiceBottomBar(isFromEdit: isFromEdit),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinySpacing),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<AccountingBloc, AccountingState>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingIncomingInvoice) ||
                      (currentState is IncomingInvoiceFetched) ||
                      (currentState is FailedToFetchIncomingInvoice),
                  builder: (context, state) {
                    if (state is FetchingIncomingInvoice) {
                      return Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: const CircularProgressIndicator(),
                      ));
                    }
                    if (state is IncomingInvoiceFetched) {
                      return const ManageAccountingIncomingInvoiceBody(
                          isFromEdit: true);
                    } else if (state is FailedToFetchIncomingInvoice) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return const ManageAccountingIncomingInvoiceBody(
                        isFromEdit: false,
                      );
                    }
                  },
                ))));
  }
}
