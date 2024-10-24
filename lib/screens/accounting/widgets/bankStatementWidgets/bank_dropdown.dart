import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../../blocs/accounting/accounting_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';

class BankDropdown extends StatelessWidget {
  final void Function(String selectedBank) onBankChanged;
  final String initialBank;

  const BankDropdown({
    super.key,
    required this.onBankChanged,
    required this.initialBank,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AccountingBloc>().add(SelectBank(
        bankName: '',
        bankId: context.read<AccountingBloc>().manageBankStatementMap['bank'] ??
            ''));

    return BlocBuilder<AccountingBloc, AccountingState>(
      buildWhen: (previous, current) =>
          current is AccountingNewEntitySelected || current is BankSelected,
      builder: (context, state) {
        final bankList = context.read<AccountingBloc>().bankList;
        final initialSelectedBank = (initialBank.isNotEmpty &&
                bankList.isNotEmpty)
            ? bankList.firstWhere((bank) => bank.id.toString() == initialBank,
                orElse: () => ClientDatum(
                      id: 0,
                      name: '',
                      projects: [],
                      cardname: '',
                      bankname: '',
                    ))
            : null;

        final selectedBankName =
            (state is BankSelected && state.bankName.isNotEmpty)
                ? state.bankName
                : (initialSelectedBank?.bankname ?? StringConstants.kSelect);

        if (state is BankSelected || state is AccountingNewEntitySelected) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringConstants.kBank,
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
                  title: Text(selectedBankName,
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: bankList.length,
                      itemBuilder: (context, index) {
                        var bank = bankList[index];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: xxxTinierSpacing),
                          title: Text(bank.bankname ?? '',
                              style: Theme.of(context).textTheme.xSmall),
                          onTap: () {
                            context.read<AccountingBloc>().add(SelectBank(
                                bankName: bank.bankname ?? '',
                                bankId: bank.id.toString()));
                            onBankChanged(bank.id.toString());
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
      },
    );
  }
}
