import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/logBook/widgets/logbook_list.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/LogBook/logbook_bloc.dart';
import '../../blocs/LogBook/logbook_events.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import 'add_logbook_screen.dart';

class LogbookListScreen extends StatelessWidget {
  static const routeName = 'LogbookListScreen';
  static List logbookData = [];

  const LogbookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(FetchLogbookList(pageNo: 1));
    return Scaffold(
      appBar: GenericAppBar(
        title: DatabaseUtil.getText('ReportaLog'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddLogBookScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconButtonRow(
              isEnabled: true,
              primaryOnPress: () {},
              secondaryVisible: false,
              clearVisible: false,
              secondaryOnPress: () {},
              clearOnPress: () {},
            ),
            LogbookList(logbookData: logbookData),
          ],
        ),
      ),
    );
  }
}
