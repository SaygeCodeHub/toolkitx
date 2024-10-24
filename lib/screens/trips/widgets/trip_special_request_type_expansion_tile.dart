import 'package:flutter/material.dart';
import 'package:toolkit/data/models/trips/fetch_trip_master_model.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class TripSpecialRequestTypeExpansionTile extends StatefulWidget {
  const TripSpecialRequestTypeExpansionTile({
    super.key,
    required this.specialRequestMap,
    required this.masterDatum,
    required this.editName,
    required this.editValue,
  });

  final Map specialRequestMap;
  final List<MasterDatum> masterDatum;
  final String editName;
  final String editValue;

  @override
  State<TripSpecialRequestTypeExpansionTile> createState() =>
      _TripSpecialRequestTypeExpansionTileState();
}

class _TripSpecialRequestTypeExpansionTileState
    extends State<TripSpecialRequestTypeExpansionTile> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.editName;
    widget.specialRequestMap['specialrequesttype'] = widget.editValue;
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
              MediaQuery(
                  data: MediaQuery.of(context).removePadding(removeTop: true),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.masterDatum.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: xxTinierSpacing),
                            title: Text(widget.masterDatum[index].name),
                            onTap: () {
                              setState(() {
                                selectedValue = widget.masterDatum[index].name;
                                widget.specialRequestMap['specialrequesttype'] =
                                    widget.masterDatum[index].id;
                              });
                            });
                      }))
            ]));
  }
}
