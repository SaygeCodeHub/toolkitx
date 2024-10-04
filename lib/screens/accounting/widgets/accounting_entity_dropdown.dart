import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/accounting/fetch_accounting_master_model.dart';

class AccountingEntityDropdown extends StatefulWidget {
  final void Function(String entityId) onEntityChanged;
  final String selectedEntity;

  const AccountingEntityDropdown(
      {super.key, required this.onEntityChanged, required this.selectedEntity});

  @override
  State<AccountingEntityDropdown> createState() =>
      _AccountingEntityDropdownState();
}

class _AccountingEntityDropdownState extends State<AccountingEntityDropdown> {
  List entityList = [];
  String selectedEntity = StringConstants.kSelectEntity;
  String selectedEntityId = '';

  getEntityName(String entity, List entityList) {
    if (entity.isNotEmpty) {
      var element = entityList.firstWhere(
          (element) => element.id == int.parse(entity),
          orElse: () => AccountingMasterDatum(
              id: 0, name: '', purpose: '', currency: ''));

      if (element != null) {
        selectedEntityId = entity;
        selectedEntity = element.name;
      }
    }
  }

  @override
  void initState() {
    if (context.read<AccountingBloc>().fetchIAccountingMasterModel.data !=
        null) {
      entityList =
          context.read<AccountingBloc>().fetchIAccountingMasterModel.data![0];
      getEntityName(widget.selectedEntity, entityList);
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
                Text(selectedEntity, style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: entityList.length,
                  itemBuilder: (context, index) {
                    if (entityList.isNotEmpty) {
                      return ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: xxxTinierSpacing),
                          title: Text(entityList[index].name,
                              style: Theme.of(context).textTheme.xSmall),
                          onTap: () {
                            setState(() {
                              selectedEntity = entityList[index].name;
                              selectedEntityId =
                                  entityList[index].id.toString();
                            });
                            widget.onEntityChanged(selectedEntityId);
                          });
                    } else {
                      return const NoRecordsText(
                          text: StringConstants.kNoRecordsFound);
                    }
                  })
            ]));
  }
}
