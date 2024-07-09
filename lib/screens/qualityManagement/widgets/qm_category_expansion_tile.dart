import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class QMCategoryExpansionTile extends StatefulWidget {
  const QMCategoryExpansionTile({
    super.key,
    required this.categoryList,
    required this.categoryMap,
    this.editValue,
  });

  final List categoryList;
  final Map categoryMap;
  final String? editValue;

  @override
  State<QMCategoryExpansionTile> createState() =>
      QMCategoryExpansionTileState();
}

class QMCategoryExpansionTileState extends State<QMCategoryExpansionTile> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.editValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            shape: ExpansionTileBorder().buildOutlineInputBorder(),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
            key: GlobalKey(),
            title: Text(selectedValue),
            children: [
              SizedBox(
                height: kPermitEditSwitchingExpansionTileHeight,
                child: MediaQuery(
                    data: MediaQuery.of(context).removePadding(removeTop: true),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.categoryList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxTinierSpacing),
                              title: Text(widget.categoryList[index].name),
                              onTap: () {
                                setState(() {
                                  selectedValue =
                                      widget.categoryList[index].name;
                                  widget.categoryMap['categoryid'] =
                                      widget.categoryList[index].id;
                                });
                              });
                        })),
              )
            ]));
  }
}
