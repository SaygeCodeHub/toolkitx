import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/constants/string_constants.dart';

class CreditCardDropdown extends StatelessWidget {
  final void Function(String cardId) onCreditCardSelected;
  final String initialCreditCardName;
  final String initialCreditCardId;
  final bool isFromEdit;

  const CreditCardDropdown({
    super.key,
    required this.onCreditCardSelected,
    required this.isFromEdit,
    required this.initialCreditCardName,
    required this.initialCreditCardId,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(
          SelectCreditCard(
              cardName: initialCreditCardName, cardId: initialCreditCardId),
        );

    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previousState, currentState) =>
          currentState is CreditCardSelected ||
          currentState is AccountingNewEntitySelected,
      builder: (context, state) {
        if (state is AccountingNewEntitySelected ||
            state is CreditCardSelected) {
          final creditCardsList =
              context.read<AccountingBloc>().creditCardsList;

          if (creditCardsList.isNotEmpty) {
            final selectedCardName =
                state is CreditCardSelected && state.cardName.isNotEmpty
                    ? state.cardName
                    : initialCreditCardName;

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
                      selectedCardName.isEmpty
                          ? StringConstants.kSelect
                          : selectedCardName,
                      style: Theme.of(context).textTheme.xSmall,
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: creditCardsList.length,
                        itemBuilder: (context, index) {
                          final card = creditCardsList[index];
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: xxxTinierSpacing),
                            title: Text(
                              card.cardname ?? '',
                              style: Theme.of(context).textTheme.xSmall,
                            ),
                            selected: card.id.toString() == initialCreditCardId,
                            onTap: () {
                              context.read<AccountingBloc>().add(
                                    SelectCreditCard(
                                      cardName: card.cardname ?? '',
                                      cardId: card.id.toString(),
                                    ),
                                  );
                              onCreditCardSelected(card.id.toString());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
