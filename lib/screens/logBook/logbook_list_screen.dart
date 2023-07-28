import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/screens/logBook/widgets/logbook_list.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/LogBook/logbook_bloc.dart';
import '../../blocs/LogBook/logbook_events.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/text_button.dart';
import 'add_logbook_screen.dart';
import 'logbook_filter_screen.dart';

class LogbookListScreen extends StatelessWidget {
  static const routeName = 'LogbookListScreen';
  static List logbookData = [];
  final bool isFromHome;

  const LogbookListScreen({Key? key, required this.isFromHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<LogbookBloc>()
        .add(FetchLogbookList(pageNo: 1, isFromHome: isFromHome));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<LogbookBloc, LogbookStates>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is FetchingLogbookList &&
                      isFromHome == true) {
                    return true;
                  } else if (currentState is LogbookListFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is LogbookListFetched) {
                    return Visibility(
                        visible: state.filtersMap.isNotEmpty,
                        child: CustomTextButton(
                            onPressed: () {
                              LogbookList.page = 1;
                              logbookData.clear();
                              LogbookList.noMoreData = false;
                              context
                                  .read<LogbookBloc>()
                                  .add(ClearLogBookFilter());
                              context.read<LogbookBloc>().add(FetchLogbookList(
                                  isFromHome: isFromHome, pageNo: 1));
                            },
                            textValue: DatabaseUtil.getText('Clear')));
                  } else {
                    return const SizedBox();
                  }
                }),
                CustomIconButtonRow(
                  isEnabled: true,
                  primaryOnPress: () {
                    Navigator.pushNamed(context, LogBookFilterScreen.routeName);
                  },
                  secondaryVisible: false,
                  clearVisible: false,
                  secondaryOnPress: () {},
                  clearOnPress: () {},
                ),
              ],
            ),
            LogbookList(logbookData: logbookData),
          ],
        ),
      ),
    );
  }
}
