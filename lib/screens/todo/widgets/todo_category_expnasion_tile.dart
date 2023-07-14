import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/todo_category_enum.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class ToDoCategoryExpansionTile extends StatefulWidget {
  final Map todoMap;

  const ToDoCategoryExpansionTile({Key? key, required this.todoMap})
      : super(key: key);
  static String categoryName = '';

  @override
  State<ToDoCategoryExpansionTile> createState() =>
      _ToDoCategoryExpansionTileState();
}

class _ToDoCategoryExpansionTileState extends State<ToDoCategoryExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: kExpansionTileMargin, right: kExpansionTileMargin),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(
                ToDoCategoryExpansionTile.categoryName == ''
                    ? 'Select'
                    : ToDoCategoryExpansionTile.categoryName,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ToDoCategoryEnum.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding:
                            const EdgeInsets.only(left: xxxTinierSpacing),
                        activeColor: AppColor.deepBlue,
                        title: Text(
                            ToDoCategoryEnum.values.elementAt(index).status,
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: ToDoCategoryEnum.values.elementAt(index).status,
                        groupValue: ToDoCategoryExpansionTile.categoryName,
                        onChanged: (value) {
                          setState(() {
                            value =
                                ToDoCategoryEnum.values.elementAt(index).status;
                            ToDoCategoryExpansionTile.categoryName = value!;
                            widget.todoMap['categoryid'] =
                                ToDoCategoryEnum.values.elementAt(index).value;
                          });
                        });
                  })
            ]));
  }
}
