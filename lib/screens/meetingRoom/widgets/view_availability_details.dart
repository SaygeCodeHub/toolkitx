import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';

class ViewAvailabilityDetails extends StatefulWidget {
  const ViewAvailabilityDetails(
      {super.key, required this.roomId, required this.date});

  final String roomId;
  final String date;

  @override
  State<ViewAvailabilityDetails> createState() =>
      _ViewAvailabilityDetailsState();
}

class _ViewAvailabilityDetailsState extends State<ViewAvailabilityDetails> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      replacement: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
        buildWhen: (previousState, currentState) =>
            currentState is RoomAvailabilityFetched,
        builder: (context, state) {
          if (state is RoomAvailabilityFetched) {
            var data = state.fetchRoomAvailabilityModel.data;
            return SizedBox(
              height: 100.0, // Adjust the height as needed
              child: GridView.builder(
                // scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: tiniestSpacing,
                  crossAxisSpacing: tiniestSpacing,
                  childAspectRatio: 2, // Adjust the aspect ratio as needed
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      color: data[index].status == '1'
                          ? AppColor.errorRed
                          : AppColor.green,
                      child: Center(
                        child: Text(
                          data[index].slots,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isVisible = false;
          });
          context.read<MeetingRoomBloc>().add(
              FetchRoomAvailability(roomId: widget.roomId, date: widget.date));
        },
        child: Text(DatabaseUtil.getText('viewDetail'),
            style: Theme.of(context).textTheme.xxSmall.copyWith(
                color: AppColor.deepBlue, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
