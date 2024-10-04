import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/accounting/accounting_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/accounting/fetch_accounting_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_no_records_text.dart';

class AccountingClientDropdown extends StatefulWidget {
  final void Function(String clientId) onClientChanged;
  final String selectedClient;

  const AccountingClientDropdown(
      {super.key, required this.onClientChanged, required this.selectedClient});

  @override
  State<AccountingClientDropdown> createState() =>
      _AccountingClientDropdownState();
}

class _AccountingClientDropdownState extends State<AccountingClientDropdown> {
  List clientList = [];
  String selectedClient = StringConstants.kSelectClient;
  String selectedClientId = '';

  getClientName(String client, List clientList) {
    if (client.isNotEmpty) {
      var element = clientList.firstWhere(
          (element) => element.id == int.parse(client),
          orElse: () => AccountingMasterDatum(
              id: 0, name: '', purpose: '', currency: ''));

      if (element != null) {
        selectedClientId = client;
        selectedClient = element.name;
      }
    }
  }

  @override
  void initState() {
    if (context.read<AccountingBloc>().fetchIAccountingMasterModel.data !=
        null) {
      clientList = [];
      getClientName(widget.selectedClient, clientList);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title:
                Text(selectedClient, style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: clientList.length,
                  itemBuilder: (context, index) {
                    if (clientList.isNotEmpty) {
                      return ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: xxxTinierSpacing),
                          title: Text(clientList[index].name,
                              style: Theme.of(context).textTheme.xSmall),
                          onTap: () {
                            setState(() {
                              selectedClient = clientList[index].name;
                              selectedClientId =
                                  clientList[index].id.toString();
                            });
                            widget.onClientChanged(selectedClientId);
                          });
                    } else {
                      return const NoRecordsText(
                          text: StringConstants.kNoRecordsFound);
                    }
                  })
            ]));
  }
}
