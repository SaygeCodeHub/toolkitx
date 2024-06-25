import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../data/models/permit/permit_get_master_model.dart';

class SelectPermitLocation extends StatefulWidget {
  static const routeName = 'SelectPermitLocation';
  final List locationSelected;

  final List<List<PermitMasterDatum>> permitMasterDatum;

  const SelectPermitLocation(
      {super.key,
      required this.permitMasterDatum,
      required this.locationSelected});

  @override
  State<SelectPermitLocation> createState() => _SelectPermitLocationState();
}

class _SelectPermitLocationState extends State<SelectPermitLocation> {
  List selectLocation = [];

  @override
  void initState() {
    if (widget.locationSelected.toString() != '[]') {
      for (int i = 0; i < widget.locationSelected.length; i++) {
        checkBoxChange(
            true,
            widget.permitMasterDatum[1][widget.permitMasterDatum[1].indexWhere(
                (element) =>
                    element.location == widget.locationSelected[i].location)]);
      }
    }
    super.initState();
  }

  void checkBoxChange(isSelected, location) {
    setState(() {
      if (isSelected) {
        selectLocation.add(location);
      } else {
        selectLocation.remove(location);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Location')),
        bottomNavigationBar: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context, selectLocation);
                },
                textValue: DatabaseUtil.getText('nextButtonText'))),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin, right: leftRightMargin),
                child: Column(children: [
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.permitMasterDatum[1].length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                            checkColor: AppColor.white,
                            activeColor: AppColor.deepBlue,
                            contentPadding: EdgeInsets.zero,
                            value: selectLocation
                                .contains(widget.permitMasterDatum[1][index]),
                            title: Text(
                                widget.permitMasterDatum[1][index].location!,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(fontWeight: FontWeight.w600)),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (isChecked) {
                              checkBoxChange(isChecked!,
                                  widget.permitMasterDatum[1][index]);
                            });
                      })
                ]))));
  }
}
