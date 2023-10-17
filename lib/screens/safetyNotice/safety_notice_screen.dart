import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_spacing.dart';
import 'add_and_edit_safety_notice_screen.dart';
import 'safety_notice_history_screen.dart';
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
            CustomIconButtonRow(
                primaryOnPress: () {},
                secondaryOnPress: () {
                  Navigator.pushNamed(
                      context, SafetyNoticeHistoryScreen.routeName);
                },
                secondaryIcon: Icons.history,
                clearOnPress: () {}),
            const SizedBox(height: xxTinierSpacing),
            const SafetyNoticeListBody()
          ],
        ),
      ),
    );
  }
}
