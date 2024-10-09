import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';

class CreditCardDropdown extends StatelessWidget {
  final void Function(String cardId) onCreditCardSelected;

  const CreditCardDropdown({super.key, required this.onCreditCardSelected});

  @override
  Widget build(BuildContext context) {
    context
        .read<AccountingBloc>()
        .add(SelectCreditCard(cardName: '', cardId: ''));
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) =>
          currentState is CreditCardSelected,
      builder: (context, state) {
        if (state is CreditCardSelected) {
          if (context.read<AccountingBloc>().creditCardsList.isNotEmpty) {
            List<ClientDatum> creditCards =
                context.read<AccountingBloc>().creditCardsList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: xxTinySpacing),
                Text('Credit Card',
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
                            (state.cardName.isEmpty)
                                ? StringConstants.kSelect
                                : state.cardName,
                            style: Theme.of(context).textTheme.xSmall),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: creditCards.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxxTinierSpacing),
                                    title: Text(
                                        creditCards[index].cardname ?? '',
                                        style:
                                            Theme.of(context).textTheme.xSmall),
                                    onTap: () {
                                      context.read<AccountingBloc>().add(
                                          SelectCreditCard(
                                              cardName:
                                                  creditCards[index].cardname ??
                                                      '',
                                              cardId: creditCards[index]
                                                  .id
                                                  .toString()));
                                      onCreditCardSelected(
                                          creditCards[index].id.toString());
                                    });
                              })
                        ]))
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
