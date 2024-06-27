import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/enums/meeting_room_repeat_enum.dart';
import '../../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class MeetingRepeatExpansionTile extends StatefulWidget {
  const MeetingRepeatExpansionTile({
    super.key,
    required this.bookRoomMap,
  });

  final Map bookRoomMap;

  @override
  State<MeetingRepeatExpansionTile> createState() =>
      MeetingRepeatExpansionTileState();
}

class MeetingRepeatExpansionTileState
    extends State<MeetingRepeatExpansionTile> {
  String? selectedValue;

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
            title: Text(selectedValue ?? MeetingRoomRepeatEnum.noRecord.status),
            children: [
              MediaQuery(
                  data: MediaQuery.of(context).removePadding(removeTop: true),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: MeetingRoomRepeatEnum.values.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: xxTinierSpacing),
                            title: Text(
                                MeetingRoomRepeatEnum.values[index].status),
                            onTap: () {
                              setState(() {
                                selectedValue =
                                    MeetingRoomRepeatEnum.values[index].status;
                                widget.bookRoomMap["repeat"] =
                                    MeetingRoomRepeatEnum.values[index].value;
                                context.read<MeetingRoomBloc>().add(
                                    SelectRepeatValue(
                                        repeat: widget.bookRoomMap["repeat"]));
                              });
                            });
                      }))
            ]));
  }
}
