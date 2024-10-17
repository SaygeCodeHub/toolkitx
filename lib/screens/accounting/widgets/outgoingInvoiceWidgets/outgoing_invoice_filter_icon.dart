import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/screens/accounting/accounting_filter_screen.dart';
import 'package:toolkit/screens/accounting/outgoing_list_screen.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';

class OutgoingInvoiceFilterIcon extends StatelessWidget {
  final String routeName;

  const OutgoingInvoiceFilterIcon({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) {
        if (currentState is FetchingOutgoingInvoices) {
          return true;
        } else if (currentState is OutgoingInvoicesFetched) {
          return true;
        } else if (currentState is OutgoingInvoicesWithNoData) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is OutgoingInvoicesFetched) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, AccountingFilterScreen.routeName,
                    arguments: [
                      context.read<AccountingBloc>().outgoingFilterMap,
                      OutgoingListScreen.routeName
                    ]);
              },
              secondaryVisible: false,
              clearVisible:
                  context.read<AccountingBloc>().outgoingFilterMap.isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().outgoingFilterMap.clear();
                context.read<AccountingBloc>().outgoingInvoicesReachedMax =
                    false;
                context
                    .read<AccountingBloc>()
                    .add(FetchOutgoingInvoices(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else if (state is OutgoingInvoicesWithNoData) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, AccountingFilterScreen.routeName,
                    arguments: [
                      context.read<AccountingBloc>().outgoingFilterMap,
                      OutgoingListScreen.routeName
                    ]);
              },
              secondaryVisible: false,
              clearVisible:
                  context.read<AccountingBloc>().outgoingFilterMap.isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().outgoingFilterMap.clear();
                context
                    .read<AccountingBloc>()
                    .add(FetchOutgoingInvoices(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
