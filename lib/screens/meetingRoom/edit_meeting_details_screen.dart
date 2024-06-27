import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/meetingRoom/meeting_details_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/edit_meeting_details_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/ meetingRoom/fetch_meeting_details_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';

class EditMeetingDetailsScreen extends StatelessWidget {
  static const routeName = "EditMeetingDetailsScreen";

  const EditMeetingDetailsScreen({super.key, required this.meetingDetailsData});

  final MeetingDetailsData meetingDetailsData;

  @override
  Widget build(BuildContext context) {
    List locationList = meetingDetailsData.location.split(' - ').toList();
    Map editDetailsMap = {
      "roomid": meetingDetailsData.roomid,
      "shortagenda": meetingDetailsData.shortagenda,
      "longagenda": meetingDetailsData.longagenda,
      "participant": meetingDetailsData.participant,
    };
    context.read<MeetingRoomBloc>().add(FetchMeetingMaster());
    return Scaffold(
        appBar: GenericAppBar(title: meetingDetailsData.roomname),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: BlocBuilder<MeetingRoomBloc, MeetingRoomState>(
                buildWhen: (previousState, currentState) =>
                    currentState is MeetingMasterFetching ||
                    currentState is MeetingMasterFetched ||
                    currentState is MeetingMasterNotFetched,
                builder: (context, state) {
                  if (state is MeetingMasterFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MeetingMasterFetched) {
                    return EditMeetingDetailsBody(
                      meetingDetailsData: meetingDetailsData,
                      locationList: locationList,
                      editDetailsMap: editDetailsMap,
                      participantList: state.fetchMeetingMasterModel.data[0],
                    );
                  } else if (state is MeetingMasterNotFetched) {
                    return const Center(
                      child: Text(StringConstants.kNoRecordsFound),
                    );
                  }
                  return const SizedBox.shrink();
                })),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
                listener: (context, state) {
                  if (state is BookingDetailsUpdating) {
                    ProgressBar.show(context);
                  } else if (state is BookingDetailsUpdated) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, MeetingDetailsScreen.routeName,
                        arguments: context.read<MeetingRoomBloc>().bookingId);
                  }
                  if (state is BookingDetailsNotUpdated) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                child: PrimaryButton(
                    onPressed: () {
                      context.read<MeetingRoomBloc>().add(
                          UpdateBookingDetails(editDetailsMap: editDetailsMap));
                    },
                    textValue: DatabaseUtil.getText('buttonSave')))));
  }
}
