import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';

class MeetingDetailsScreen extends StatelessWidget {
  static const routeName = 'MeetingDetailsScreen';

  const MeetingDetailsScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    context
        .read<MeetingRoomBloc>()
        .add(FetchMeetingDetails(bookingId: bookingId));
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kBusinessRoom,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
          builder: (context, state) {
            if (state is MeetingDetailsFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MeetingDetailsFetched) {
              var data = state.fetchMeetingDetailsModel.data;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.location),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kDate,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    Text('${data.startdatetime} - ${data.enddatetime}'),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kShortAgenda,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    Text(data.shortagenda),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kLongAgenda,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    Text(data.longagenda),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kOwner,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    Text(data.owner),
                    const SizedBox(height: xxxSmallestSpacing),
                    Text(StringConstants.kParticipants,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: tiniestSpacing),
                    Text(data.participantname),
                  ]);
            } else if (state is MeetingDetailsNotFetched) {
              return const Center(
                child: NoRecordsText(text: StringConstants.kNoRecordsFound),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
