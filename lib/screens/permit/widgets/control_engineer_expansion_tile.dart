import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class ControlEngineerExpansionTile extends StatefulWidget {
  const ControlEngineerExpansionTile({
    super.key,
  });


  @override
  State<ControlEngineerExpansionTile> createState() =>
      ControlEngineerExpansionTileState();
}

class ControlEngineerExpansionTileState
    extends State<ControlEngineerExpansionTile> {
  String selectedValue = '';

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
              MediaQuery(
                  data: MediaQuery.of(context).removePadding(removeTop: true),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding:
                            const EdgeInsets.only(left: xxTinierSpacing),
                            title: Text(''),
                            onTap: () {
                              setState(() {});
                            });
                      }))
            ]));
  }
}
