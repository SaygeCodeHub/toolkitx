import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/%20meetingRoom/fetch_search_for_rooms_model.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class MeetingViewRoomCheckboxTile extends StatefulWidget {
  const MeetingViewRoomCheckboxTile(
      {super.key,
      required this.searchForRoomsDatum,
      required this.viewRoomMap});

  final SearchForRoomsDatum searchForRoomsDatum;
  final Map viewRoomMap;

  @override
  State<MeetingViewRoomCheckboxTile> createState() =>
      _MeetingViewRoomCheckboxTileState();
}

class _MeetingViewRoomCheckboxTileState
    extends State<MeetingViewRoomCheckboxTile> {
  String selectedValue = '';
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: AppColor.deepBlue,
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(widget.searchForRoomsDatum.roomname,
            style: Theme.of(context)
                .textTheme
                .small
                .copyWith(fontWeight: FontWeight.w500, color: AppColor.black)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(widget.searchForRoomsDatum.location,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w400, color: AppColor.grey)),
            const SizedBox(height: tiniestSpacing),
            Text("Capacity Upto ${widget.searchForRoomsDatum.capacity} People",
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w400, color: AppColor.grey)),
            const SizedBox(height: tiniestSpacing),
            Text(widget.searchForRoomsDatum.facilityname,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w400, color: AppColor.grey)),
            const SizedBox(height: tiniestSpacing),
          ],
        ),
        value: isCheck,
        onChanged: (isChecked) {
          setState(() {
            isCheck = isChecked!;
            widget.viewRoomMap['location'] =
                widget.searchForRoomsDatum.location;
            widget.viewRoomMap['roomname'] =
                widget.searchForRoomsDatum.roomname;
            selectedValue = widget.searchForRoomsDatum.roomid;
            widget.viewRoomMap['roomid'] = widget.searchForRoomsDatum.roomid;
          });
        });
  }
}
