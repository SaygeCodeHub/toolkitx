import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/manage_accounting_outgoing_invoice.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/outgoing_invoice_filter_icon.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/outgoing_list_tile_subtitle.dart';
import 'package:toolkit/screens/accounting/widgets/outgoingInvoiceWidgets/outgoing_list_tile_title.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class OutgoingListScreen extends StatelessWidget {
  const OutgoingListScreen({super.key});

  static const routeName = 'OutGoingListScreen';

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(FetchOutgoingInvoices(pageNo: 1));
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kOutGoingInvoiceList),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<AccountingBloc>().manageOutgoingInvoiceMap.clear();
              Navigator.pushNamed(
                  context, ManageAccountingIOutgoingInvoice.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              const OutgoingInvoiceFilterIcon(
                  routeName: OutgoingListScreen.routeName),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<AccountingBloc, AccountingState>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is FetchingOutgoingInvoices &&
                          currentState.pageNo == 1) ||
                      (currentState is OutgoingInvoicesFetched) ||
                      (currentState is FailedToFetchOutgoingInvoices) ||
                      (currentState is OutgoingInvoicesWithNoData) ||
                      (currentState is NoRecordsFoundForFilter),
                  listener: (context, state) {
                    if (state is OutgoingInvoicesFetched &&
                        context
                            .read<AccountingBloc>()
                            .outgoingInvoicesReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }

                    if (state is DeletingOutgoingInvoice) {
                      ProgressBar.show(context);
                    } else if (state is OutgoingInvoiceDeleted) {
                      ProgressBar.dismiss(context);
                      context.read<AccountingBloc>().outgoingInvoices.clear();
                      context
                          .read<AccountingBloc>()
                          .add(FetchOutgoingInvoices(pageNo: 1));
                    } else if (state is FailedToDeleteOutgoingInvoice) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingOutgoingInvoices) {
                      return Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: const CircularProgressIndicator(),
                      ));
                    } else if (state is OutgoingInvoicesFetched) {
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: context
                                  .read<AccountingBloc>()
                                  .outgoingInvoicesReachedMax
                              ? state.outgoingInvoices.length
                              : state.outgoingInvoices.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.outgoingInvoices.length) {
                              return CustomCard(
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.all(xxTinierSpacing),
                                  title: OutgoingListTileTitle(
                                    outgoingInvoices:
                                        state.outgoingInvoices[index],
                                  ),
                                  subtitle: OutgoingListTileSubtitle(
                                      outgoingInvoices:
                                          state.outgoingInvoices[index]),
                                  onTap: () {
                                    // print('Selected ID: ${data['id']}');
                                  },
                                ),
                              );
                            } else {
                              context.read<AccountingBloc>().add(
                                  FetchOutgoingInvoices(
                                      pageNo: state.pageNo + 1));
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: xxTinierSpacing);
                          },
                        ),
                      );
                    } else if (state is OutgoingInvoicesWithNoData) {
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
