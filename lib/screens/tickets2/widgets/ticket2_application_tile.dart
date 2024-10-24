import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/expansion_tile_border.dart';

class Ticket2ApplicationTile extends StatefulWidget {
  const Ticket2ApplicationTile(
      {super.key, required this.saveTicketMap, required this.appList});

  final Map saveTicketMap;
  final List appList;

  @override
  State<Ticket2ApplicationTile> createState() => _Ticket2ApplicationTileState();
}

class _Ticket2ApplicationTileState extends State<Ticket2ApplicationTile> {
  String appType = '';

  @override
  void initState() {
    if (widget.saveTicketMap['application'] != null) {
      var element = widget.appList.firstWhere(
          (element) =>
              element.id == int.parse(widget.saveTicketMap['application']),
          orElse: () => Ticket2MasterDatum(
              id: 0,
              name: '',
              priorityname: '',
              listname: '',
              emailaddress: '',
              active: 0,
              text: ''));

      if (element != null) {
        appType = element.name;
      }
    }
    super.initState();
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
            title: Text(appType, style: Theme.of(context).textTheme.bodyMedium),
            children: [
              SizedBox(
                height: kPermitEditSwitchingExpansionTileHeight,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.appList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 16, right: 8),
                          activeColor: AppColor.blue,
                          title: Text(widget.appList[index].name,
                              style: Theme.of(context).textTheme.bodyMedium),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: widget.appList[index].name,
                          groupValue: appType,
                          onChanged: (value) {
                            setState(() {
                              appType = widget.appList[index].name;
                              widget.saveTicketMap['application'] =
                                  widget.appList[index].id;
                            });
                          });
                    }),
              )
            ]));
  }
}
