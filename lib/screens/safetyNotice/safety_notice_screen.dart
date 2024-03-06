import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_bloc.dart';
import 'package:toolkit/blocs/imagePickerBloc/image_picker_event.dart';
import 'package:toolkit/screens/safetyNotice/safety_notice_history_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../blocs/safetyNotice/safety_notice_states.dart';
import '../../configs/app_spacing.dart';
import 'add_and_edit_safety_notice_screen.dart';
import 'safety_notice_filter_screen.dart';
import 'widgets/safety_notice_list_body.dart';

class SafetyNoticeScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeScreen';
  static int pageNo = 1;
  final bool isFromHomeScreen;

  const SafetyNoticeScreen({Key? key, this.isFromHomeScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<SafetyNoticeBloc>().noticesDatum.clear();
    context.read<SafetyNoticeBloc>().safetyNoticeListReachedMax = false;
    context.read<SafetyNoticeBloc>().add(
        FetchSafetyNotices(pageNo: pageNo, isFromHomeScreen: isFromHomeScreen));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('SafetyNotice')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddAndEditSafetyNoticeScreen.isFromEditOption = false;
            context.read<ImagePickerBloc>().pickedImagesList.clear();
            context.read<ImagePickerBloc>().add(PickImageInitial());
            Navigator.pushNamed(
                context, AddAndEditSafetyNoticeScreen.routeName);
          },
          child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            BlocBuilder<SafetyNoticeBloc, SafetyNoticeStates>(
              buildWhen: (previousState, currentState) {
                if (currentState is FetchingSafetyNotices &&
                    isFromHomeScreen == true) {
                  return true;
                } else if (currentState is SafetyNoticesFetched) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SafetyNoticesFetched) {
                  return CustomIconButtonRow(
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, SafetyNoticeFilterScreen.routeName);
                      },
                      secondaryOnPress: () {
                        Navigator.pushNamed(
                                context, SafetyNoticeHistoryScreen.routeName)
                            .then((value) => context
                                .read<SafetyNoticeBloc>()
                                .add(FetchSafetyNotices(
                                    pageNo: 1, isFromHomeScreen: false)));
                      },
                      secondaryIcon: Icons.history,
                      clearVisible: state.safetyNoticeFilterMap.isNotEmpty &&
                          isFromHomeScreen != true,
                      clearOnPress: () {
                        state.safetyNoticeFilterMap.clear();
                        pageNo = 1;
                        context.read<SafetyNoticeBloc>().noticesDatum.clear();
                        context
                            .read<SafetyNoticeBloc>()
                            .safetyNoticeListReachedMax = false;
                        context.read<SafetyNoticeBloc>().add(FetchSafetyNotices(
                            pageNo: pageNo,
                            isFromHomeScreen: isFromHomeScreen));
                      });
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: xxTinierSpacing),
            const SafetyNoticeListBody()
          ],
        ),
      ),
    );
  }
}
