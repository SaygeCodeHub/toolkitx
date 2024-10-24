import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../../widgets/expansion_tile_border.dart';

class Ticket2DistributionTile extends StatefulWidget {
  final List distList;
  final Map saveTicketMap;

  const Ticket2DistributionTile(
      {super.key, required this.saveTicketMap, required this.distList});

  @override
  State<Ticket2DistributionTile> createState() =>
      _Ticket2DistributionTileState();
}

class _Ticket2DistributionTileState extends State<Ticket2DistributionTile> {
  bool _isExpanded = false;
  List selectedNameList = [];
  List selectedValueList = [];
  String name = '';

  @override
  void initState() {
    if (widget.saveTicketMap['distlist'] != null) {
      for (var item in widget.saveTicketMap['distlist'].toString().split(';')) {
        var element = widget.distList.firstWhere(
            (element) => element.id == int.parse(item),
            orElse: () => Ticket2MasterDatum(
                id: 0,
                name: '',
                priorityname: '',
                listname: '',
                emailaddress: '',
                active: 0,
                text: ''));

        if (element != null) {
          selectedValueList.add(element.id);
          selectedNameList.add(element.listname);
        }
      }
    }
    super.initState();
  }

  checkboxSelected(isChecked, name, value) {
    if (isChecked) {
      selectedNameList.add(name);
      selectedValueList.add(value);
      widget.saveTicketMap['distlist'] = selectedValueList.join(';');
    } else {
      selectedNameList.remove(name);
      selectedValueList.remove(value);
      widget.saveTicketMap['distlist'] = selectedValueList.join(';');
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
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Text(selectedNameList.join(', '),
                style: Theme.of(context).textTheme.bodyMedium),
            children: [
              SizedBox(
                height: kPermitEditSwitchingExpansionTileHeight,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.distList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: tinierSpacing),
                        child: CheckboxListTile(
                            checkColor: AppColor.white,
                            activeColor: AppColor.deepBlue,
                            contentPadding: EdgeInsets.zero,
                            value: selectedValueList
                                .contains(widget.distList[index].id),
                            title: Text(widget.distList[index].listname,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(fontWeight: FontWeight.w600)),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (isChecked) {
                              checkboxSelected(
                                  isChecked,
                                  widget.distList[index].listname,
                                  widget.distList[index].id);
                              setState(() {});
                            }),
                      );
                    }),
              )
            ]));
  }
}
