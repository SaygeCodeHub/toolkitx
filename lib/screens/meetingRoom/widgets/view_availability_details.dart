import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MeetingRoomBloc>().add(
            FetchRoomAvailability(roomId: widget.roomId, date: widget.date));
        _showAvailabilityDialog(context);
      },
      child: Text(DatabaseUtil.getText('viewDetail'),
          style: Theme.of(context)
              .textTheme
              .xxSmall
              .copyWith(color: AppColor.deepBlue, fontWeight: FontWeight.w400)),
    );
  }

  Future<dynamic> _showAvailabilityDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
              buildWhen: (previousState, currentState) =>
                  currentState is RoomAvailabilityFetched,
              builder: (context, state) {
                if (state is RoomAvailabilityFetching) {
                  return const Text(StringConstants.kLoading);
                } else if (state is RoomAvailabilityFetched) {
                  var data = state.fetchRoomAvailabilityModel.data;
                  return SizedBox(
                      height: kViewAvailabilityCardHeight,
                      width: kViewAvailabilityCardHeight,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: tiniestSpacing,
                            crossAxisSpacing: tiniestSpacing,
                            childAspectRatio: 3,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                                color: data[index].status == '1'
                                    ? AppColor.errorRed
                                    : AppColor.green,
                                child: Center(
                                    child: Text(
                                  data[index].slots,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500),
                                )));
                          }));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            actions: [
              TextButton(
                  child: Text(DatabaseUtil.getText('Close')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]);
      },
    );
  }
}
