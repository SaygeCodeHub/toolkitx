import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class BankDropdown extends StatefulWidget {
  final void Function(String selectedBank) onBankChanged;

  const BankDropdown({super.key, required this.onBankChanged});

  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(SelectBank(bankName: '', bankId: ''));
    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previous, current) => current is BankSelected,
      builder: (context, state) {
        if (state is BankSelected) {
          if (context.read<AccountingBloc>().bankList.isEmpty) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (state.bankName.isEmpty)
                            ? StringConstants.kSelect
                            : state.bankName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              context.read<AccountingBloc>().bankList.length,
                          itemBuilder: (context, index) {
                            var bank =
                                context.read<AccountingBloc>().bankList[index];
                            return ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                title: Text(bank.bankname ?? '',
                                    style: Theme.of(context).textTheme.xSmall),
                                onTap: () {
                                  context.read<AccountingBloc>().add(SelectBank(
                                      bankName: bank.bankname ?? '',
                                      bankId: bank.id.toString()));
                                  widget.onBankChanged(bank.id.toString());
                                });
                          })
                    ]));
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
