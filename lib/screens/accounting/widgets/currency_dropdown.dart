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

class CurrencyDropdown extends StatelessWidget {
  final void Function(String currency) onCurrencySelected;
  final String initialOtherCurrencyName;
  final String initialOtherCurrency;

  const CurrencyDropdown({super.key, required this.onCurrencySelected,  this.initialOtherCurrencyName='',  this.initialOtherCurrency=''});

  @override
  Widget build(BuildContext context) {
    context
        .read<AccountingBloc>()
        .add(SelectCurrency(currency: initialOtherCurrencyName, currencyId: initialOtherCurrency));
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) =>
          currentState is CurrencySelected,
      builder: (context, state) {
        if (state is CurrencySelected) {
          if (context.read<AccountingBloc>().fetchIAccountingMasterModel.data !=
              null) {
            List<AccountingMasterDatum> currency = context
                .read<AccountingBloc>()
                .fetchIAccountingMasterModel
                .data![2];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: xxTinySpacing),
                Text('Currency',
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxxTinierSpacing),
                Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: AppColor.transparent),
                    child: ExpansionTile(
                        maintainState: true,
                        key: GlobalKey(),
                        title: Text(
                            (state.currency.isEmpty)
                                ? StringConstants.kSelect
                                : state.currency,
                            style: Theme.of(context).textTheme.xSmall),
                        children: [
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currency.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxxTinierSpacing),
                                    title: Text(currency[index].currency,
                                        style:
                                            Theme.of(context).textTheme.xSmall),
                                    onTap: () {
                                      context.read<AccountingBloc>().add(
                                          SelectCurrency(
                                              currency:
                                                  currency[index].currency,
                                              currencyId: currency[index]
                                                  .id
                                                  .toString()));
                                      onCurrencySelected(
                                          currency[index].id.toString());
                                    });
                              })
                        ])),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
