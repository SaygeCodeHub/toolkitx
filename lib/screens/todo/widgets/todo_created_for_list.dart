import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_master_model.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';

typedef CreatedForListCallBack = Function(List id);

class ToDoCreatedForList extends StatefulWidget {
  final List<ToDoMasterDatum> todoMasterDatum;
  final CreatedForListCallBack onCreatedForChanged;

  const ToDoCreatedForList(
      {Key? key,
      required this.todoMasterDatum,
      required this.onCreatedForChanged})
      : super(key: key);

  @override
  State<ToDoCreatedForList> createState() => _ToDoCreatedForListState();
}

class _ToDoCreatedForListState extends State<ToDoCreatedForList> {
  List selectedCreatedForIdList = [];
  List selectedCreatedForNameList = [];

  void checkBoxChange(isSelected, createdForId, createdForName) {
    setState(() {
      if (isSelected) {
        selectedCreatedForIdList.add(createdForId);
        selectedCreatedForNameList.add(createdForName);
        widget.onCreatedForChanged(selectedCreatedForIdList);
      } else {
        selectedCreatedForIdList.remove(createdForId);
        selectedCreatedForNameList.remove(createdForName);
        widget.onCreatedForChanged(selectedCreatedForIdList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('select_item')),
        bottomNavigationBar: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context, selectedCreatedForNameList);
                },
                textValue: DatabaseUtil.getText('nextButtonText'))),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SearchableList(
              autoFocusOnSearch: false,
              initialList: widget.todoMasterDatum,
              builder: (List<ToDoMasterDatum> todoDatumList, index,
                  ToDoMasterDatum todoMasterDatum) {
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(todoMasterDatum.name),
                    value:
                    selectedCreatedForIdList.contains(todoMasterDatum.id),
                    onChanged: (isChecked) {
                      setState(() {
                        checkBoxChange(isChecked!, todoMasterDatum.id,
                            todoMasterDatum.name);
                      });
                    });
              },
              emptyWidget: Text(DatabaseUtil.getText('no_records_found')),
              filter: (value) => widget.todoMasterDatum
                  .where((element) => element.name
                      .toLowerCase()
                      .contains(value.toLowerCase().trim()))
                  .toList(),
              inputDecoration: InputDecoration(
                  suffix: const SizedBox(),
                  suffixIcon: const Icon(Icons.search_sharp, size: kIconSize),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.grey),
                  hintText: StringConstants.kSearch,
                  contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.lightGrey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.lightGrey)),
                  filled: true,
                  fillColor: AppColor.white)),
        ));
  }
}
