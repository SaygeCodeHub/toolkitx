import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';

import '../../../blocs/accounting/accounting_bloc.dart';
import '../../../blocs/accounting/accounting_event.dart';
import '../../../blocs/accounting/accounting_state.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import 'currency_dropdown.dart';

class InvoiceCurrencyDropdown extends StatelessWidget {
  final void Function(String currency) onCurrencySelected;

  const InvoiceCurrencyDropdown({super.key, required this.onCurrencySelected});

  @override
  Widget build(BuildContext context) {
    context
        .read<AccountingBloc>()
        .add(SelectInvoiceCurrency(selectedCurrency: ''));
    return BlocBuilder<AccountingBloc, AccountingState>(
        buildWhen: (previousState, currentState) =>
            currentState is InvoiceCurrencySelected,
        builder: (context, state) {
          if (state is InvoiceCurrencySelected) {
            if (context
                    .read<AccountingBloc>()
                    .fetchIAccountingMasterModel
                    .data !=
                null) {
              List<AccountingMasterDatum> invoiceCurrency = context
                  .read<AccountingBloc>()
                  .fetchIAccountingMasterModel
                  .data![3];
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: AppColor.transparent),
                        child: ExpansionTile(
                            maintainState: true,
                            key: GlobalKey(),
                            title: Text(
                                (state.selectedCurrency.isEmpty)
                                    ? StringConstants.kSelect
                                    : state.selectedCurrency,
                                style: Theme.of(context).textTheme.xSmall),
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: invoiceCurrency.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: xxxTinierSpacing),
                                        title: Text(invoiceCurrency[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                        onTap: () {
                                          context.read<AccountingBloc>().add(
                                              SelectInvoiceCurrency(
                                                  selectedCurrency:
                                                      invoiceCurrency[index]
                                                          .name));
                                          onCurrencySelected(
                                              invoiceCurrency[index].name);
                                        });
                                  })
                            ])),
                    if (state.selectedCurrency == 'Other')
                      CurrencyDropdown(onCurrencySelected: (String currency) {
                        context
                                .read<AccountingBloc>()
                                .manageIncomingInvoiceMap['othercurrency'] =
                            currency;
                        context
                                .read<AccountingBloc>()
                                .manageIncomingInvoiceMap['other'] =
                            state.selectedCurrency;
                      })
                  ]);
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
