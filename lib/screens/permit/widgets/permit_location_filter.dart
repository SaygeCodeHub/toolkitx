import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_dimensions.dart';
import '../../../data/models/permit/permit_get_master_model.dart';
import '../select_location_screen.dart';

class PermitLocationFilter extends StatefulWidget {
  final List<List<PermitMasterDatum>> permitMasterDatum;
  final Map permitFilterMap;
  final List location;

  const PermitLocationFilter(
      {super.key,
      required this.permitMasterDatum,
      required this.permitFilterMap,
      required this.location});

  @override
  State<PermitLocationFilter> createState() => _PermitLocationFilterState();
}

class _PermitLocationFilterState extends State<PermitLocationFilter> {
  List selectLocation = [];

  @override
  void initState() {
    (widget.permitFilterMap['locs'] == null)
        ? null
        : selectLocation = widget.permitFilterMap['locs'].toString().split(',');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () async {
          List? locationSelected = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectPermitLocation(
                      permitMasterDatum: widget.permitMasterDatum,
                      locationSelected: List.from(widget.location))));
          if (locationSelected != null) {
            if (locationSelected.isNotEmpty) {
              widget.location.clear();
              selectLocation.clear();
              setState(() {
                for (int i = 0; i < locationSelected.length; i++) {
                  selectLocation.add(locationSelected[i].location);
                  widget.location.add(locationSelected[i]);
                }
                widget.permitFilterMap['locs'] = selectLocation
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '');
              });
            }
          } else {
            null;
          }
        },
        title: Text(DatabaseUtil.getText('Location'),
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(fontWeight: FontWeight.w600)),
        subtitle: (selectLocation.toString() == '[]')
            ? null
            : Text(selectLocation
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', '')),
        trailing: const Icon(Icons.navigate_next_rounded, size: kIconSize));
  }
}
