import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_event.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';

class BankDropdown extends StatefulWidget {
  final void Function(String selectedBank) onBankChanged;

  const BankDropdown({super.key, required this.onBankChanged});

  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  String selectedText = '';
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                (selectedText.isEmpty) ? StringConstants.kSelect : selectedText,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              BlocBuilder<AccountingBloc, AccountingState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AccountingNewEntitySelecting ||
                    currentState is AccountingNewEntitySelected ||
                    currentState is AccountingNewEntityNotSelected,
                builder: (context, state) {
                  if (state is AccountingNewEntitySelecting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AccountingNewEntitySelected) {
                    var flattenedData = state.fetchMasterDataEntryModel.data
                        .expand((clientList) => clientList)
                        .toList();
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: flattenedData.length,
                        itemBuilder: (context, index) {
                          var clientDatum = flattenedData[index];
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxxTinierSpacing),
                              title: Text(
                                  clientDatum.bankname ?? 'Unknown Bank',
                                  style: Theme.of(context).textTheme.xSmall),
                              onTap: () {
                                setState(() {
                                  selectedText =
                                      clientDatum.bankname ?? 'Unknown Bank';
                                  selectedValue = clientDatum.id.toString();
                                  context.read<AccountingBloc>().add(
                                      SelectClientId(clientId: clientDatum.id));
                                });
                                widget.onBankChanged(selectedValue);
                              });
                        });
                  } else if (state is AccountingNewEntityNotSelected) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ]));
  }
}
