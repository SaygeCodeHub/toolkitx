import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/accounting/accounting_bloc.dart';
import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/enums/accounting/accounting_bank_payment_mode_enum.dart';
import '../../../../utils/constants/string_constants.dart';
import 'credit_card_dropdown.dart';

class ModeOfPaymentDropdown extends StatelessWidget {
  final void Function(String paymentMode) onPaymentModeSelected;

  const ModeOfPaymentDropdown({super.key, required this.onPaymentModeSelected});

  @override
  Widget build(BuildContext context) {
    context
        .read<AccountingBloc>()
        .add(SelectPaymentMode(paymentModeId: '', paymentMode: ''));
    return BlocBuilder<AccountingBloc, AccountingState>(
        buildWhen: (previousState, currentState) =>
            currentState is PaymentModeSelected,
        builder: (context, state) {
          if (state is PaymentModeSelected) {
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
                              (state.paymentMode.isEmpty)
                                  ? StringConstants.kSelect
                                  : state.paymentMode,
                              style: Theme.of(context).textTheme.xSmall),
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    AccountingBankPaymentEnum.values.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: xxxTinierSpacing),
                                      title: Text(
                                          AccountingBankPaymentEnum
                                              .values[index].paymentMode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall),
                                      onTap: () {
                                        context.read<AccountingBloc>().add(
                                            SelectPaymentMode(
                                                paymentModeId:
                                                    AccountingBankPaymentEnum
                                                        .values[index]
                                                        .paymentModeId,
                                                paymentMode:
                                                    AccountingBankPaymentEnum
                                                        .values[index]
                                                        .paymentMode));
                                        onPaymentModeSelected(
                                            AccountingBankPaymentEnum
                                                .values[index].paymentModeId);
                                      });
                                })
                          ])),
                  if (state.paymentModeId == '2')
                    CreditCardDropdown(onCreditCardSelected: (String cardId) {
                      context
                          .read<AccountingBloc>()
                          .manageIncomingInvoiceMap['creditcard'] = cardId;
                    })
                ]);
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
