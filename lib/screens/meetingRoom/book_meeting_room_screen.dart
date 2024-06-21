import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/meetingRoom/my_meetings_screen.dart';
import 'package:toolkit/screens/meetingRoom/search_rooms_screen.dart';
import 'package:toolkit/screens/meetingRoom/widgets/book_meeting_room_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/meetingRoom/meeting_room_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';

class BookMeetingRoomScreen extends StatelessWidget {
  static const routeName = "BookMeetingRoomScreen";

  const BookMeetingRoomScreen({super.key, required this.bookRoomMap});

  final Map bookRoomMap;

  @override
  Widget build(BuildContext context) {
    context.read<MeetingRoomBloc>().add(FetchMeetingMaster());
    bookRoomMap['endson'] = '';
    bookRoomMap['repeat'] = '0';
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('BookMeetingRoom')),
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
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BookMeetingRoomBody(
                  bookRoomMap: bookRoomMap,
                  participantList: state.fetchMeetingMasterModel.data[0],
                ),
              );
            } else if (state is MeetingMasterNotFetched) {
              return const Center(
                child: Text(StringConstants.kNoRecordsFound),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
          listener: (context, state) {
            if (state is SearchForRoomsFetching) {
              ProgressBar.show(context);
            } else if (state is SearchForRoomsFetched) {
              ProgressBar.dismiss(context);
              // Navigator.pushNamed(context, ViewAvailableRoomsScreen.routeName,
              //     arguments: state.fetchSearchForRoomsModel.data);
            }
            if (state is SearchForRoomsNotFetched) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: DatabaseUtil.getText('buttonBack')),
              ),
              const SizedBox(width: xxxSmallestSpacing),
              Expanded(
                child: BlocListener<MeetingRoomBloc, MeetingRoomState>(
                  listener: (context, state) {
                    if (state is MeetingRoomBooking) {
                      ProgressBar.show(context);
                    } else if (state is MeetingRoomBooked) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, MyMeetingsScreen.routeName);
                    }
                    if (state is MeetingRoomNotBooked) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.errorMessage, '');
                    }
                  },
                  child: PrimaryButton(
                      onPressed: () {
                        bookRoomMap['startdate'] =
                            SearchRoomsScreen.searchRoomMap['st'];
                        bookRoomMap['enddate'] =
                            SearchRoomsScreen.searchRoomMap['et'];
                        print('bookRoomMap=============>$bookRoomMap');
                        context
                            .read<MeetingRoomBloc>()
                            .add(BookMeetingRoom(bookMeetingMap: bookRoomMap));
                      },
                      textValue: DatabaseUtil.getText('buttonSave')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
