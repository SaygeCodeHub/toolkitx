import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/expansion_tile_border.dart';

import '../../../data/models/permit/fetch_data_for_open_permit_model.dart';

typedef LocationSelectedCallBack = Function(List<String>? selectedLocation);

class PlannedLocationDropdown extends StatefulWidget {
  final FetchDataForOpenPermitModel fetchDataForOpenPermitModel;
  final LocationSelectedCallBack onLocationSelected;
  static String selectedLocation = '';

  const PlannedLocationDropdown(
      {super.key,
      required this.fetchDataForOpenPermitModel,
      required this.onLocationSelected});

  @override
  State<PlannedLocationDropdown> createState() =>
      _PlannedLocationDropdownState();
}

class _PlannedLocationDropdownState extends State<PlannedLocationDropdown> {
  List<String>? selectedLocationList = [];
  String selectedLocation =
      (PlannedLocationDropdown.selectedLocation.isNotEmpty)
          ? PlannedLocationDropdown.selectedLocation
          : StringConstants.kPermitSelectLocation;

  void _checkboxChange(isSelected, location) {
    if (isSelected) {
      selectedLocationList?.add(location);
      selectedLocation = location;
      widget.onLocationSelected(selectedLocationList);
    } else {
      selectedLocationList?.remove(location);
      widget.onLocationSelected(selectedLocationList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
      child: ExpansionTile(
        collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
        collapsedBackgroundColor: AppColor.white,
        backgroundColor: AppColor.white,
        shape: ExpansionTileBorder().buildOutlineInputBorder(),
        maintainState: true,
        key: GlobalKey(),
        title: Text((selectedLocation)),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.fetchDataForOpenPermitModel.data?.location
                  ?.split(',')
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                List<String>? locationList = widget
                    .fetchDataForOpenPermitModel.data?.location
                    ?.split(',')
                    .toList();
                selectedLocationList = locationList;
                return CheckboxListTile(
                    contentPadding: const EdgeInsets.all(xxTiniestSpacing),
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(locationList![index],
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black)),
                    value: selectedLocationList?.contains(locationList[index]),
                    onChanged: (isChecked) {
                      setState(() {
                        _checkboxChange(isChecked, locationList[index]);
                      });
                    });
              })
        ],
      ),
    );
  }
}
