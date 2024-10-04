import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_event.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../widgets/custom_icon_button_row.dart';
import '../../accounting_filter_screen.dart';

class IncomingInvoiceFilterIcon extends StatelessWidget {
  const IncomingInvoiceFilterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) {
        if (currentState is FetchingIncomingInvoices) {
          return true;
        } else if (currentState is IncomingInvoicesFetched) {
          return true;
        } else if (currentState is IncomingInvoicesWithNoData) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is IncomingInvoicesFetched) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, AccountingFilterScreen.routeName);
              },
              secondaryVisible: false,
              clearVisible:
                  context.read<AccountingBloc>().accountingFilterMap.isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().accountingFilterMap.clear();
                context.read<AccountingBloc>().incomingInvoicesReachedMax =
                    false;
                context
                    .read<AccountingBloc>()
                    .add(FetchIncomingInvoices(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else if (state is IncomingInvoicesWithNoData) {
          return CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, AccountingFilterScreen.routeName);
              },
              secondaryVisible: false,
              clearVisible:
                  context.read<AccountingBloc>().accountingFilterMap.isNotEmpty,
              clearOnPress: () {
                context.read<AccountingBloc>().accountingFilterMap.clear();
                context
                    .read<AccountingBloc>()
                    .add(FetchIncomingInvoices(pageNo: 1));
              },
              secondaryOnPress: () {});
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
