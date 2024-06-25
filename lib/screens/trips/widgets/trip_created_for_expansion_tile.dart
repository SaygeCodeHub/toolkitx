import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/trips/fetch_trip_passengers_crew_list_model.dart';
import '../../../widgets/expansion_tile_border.dart';

class TripCreatedForExpansionTile extends StatefulWidget {
  const TripCreatedForExpansionTile({
    super.key,
    required this.specialReportMap,
    required this.passengerCrewDatum,
  });

  final Map specialReportMap;
  final List<PassengerCrewDatum> passengerCrewDatum;

  @override
  State<TripCreatedForExpansionTile> createState() =>
      _TripCreatedForExpansionTileState();
}

class _TripCreatedForExpansionTileState
    extends State<TripCreatedForExpansionTile> {
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
                      itemCount: widget.passengerCrewDatum.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: xxTinierSpacing),
                            title: Text(widget.passengerCrewDatum[index].name),
                            onTap: () {
                              setState(() {
                                selectedValue =
                                    widget.passengerCrewDatum[index].name;
                                widget.specialReportMap['createdfor'] =
                                    widget.passengerCrewDatum[index].id;
                              });
                            });
                      }))
            ]));
  }
}
