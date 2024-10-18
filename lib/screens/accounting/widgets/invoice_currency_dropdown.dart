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
  final void Function(String currency) onInvoiceCurrencySelected;
  final Map manageInvoiceMap;
  final String initialCurrency;
  final String initialOtherCurrencyName;
  final String initialOtherCurrency;
  const InvoiceCurrencyDropdown(
      {super.key,
      required this.onInvoiceCurrencySelected,
      required this.manageInvoiceMap,
      this.initialCurrency = '',
      this.initialOtherCurrencyName = '',
      this.initialOtherCurrency = ''});

  @override
  Widget build(BuildContext context) {
    context
        .read<AccountingBloc>()
        .add(SelectInvoiceCurrency(selectedCurrency: initialCurrency));
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
                                          context
                                                      .read<AccountingBloc>()
                                                      .manageIncomingInvoiceMap[
                                                  'other'] =
                                              invoiceCurrency[index].name;
                                          context.read<AccountingBloc>().add(
                                              SelectInvoiceCurrency(
                                                  selectedCurrency:
                                                      invoiceCurrency[index]
                                                          .name));
                                          onInvoiceCurrencySelected(
                                              invoiceCurrency[index].name);
                                        });
                                  })
                            ])),
                    if (state.selectedCurrency == 'Other')
                      CurrencyDropdown(
                          onCurrencySelected: (String currency) {
                            manageInvoiceMap['othercurrency'] = currency;
                          },
                          initialOtherCurrencyName: initialOtherCurrencyName,
                          initialOtherCurrency: initialOtherCurrency)
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
