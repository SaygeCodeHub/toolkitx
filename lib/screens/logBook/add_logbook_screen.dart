import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/LogBook/logbook_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/error_section.dart';
import 'report_new_logbook_screen.dart';

class AddLogBookScreen extends StatelessWidget {
  static const routeName = 'AddLogBookScreen';

  const AddLogBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(FetchLogBookMaster());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('LogBook')),
      body: BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is LogBookFetchingMaster ||
              currentState is LogBookMasterFetched ||
              currentState is LogBookMasterNotFetched,
          builder: (context, state) {
            if (state is LogBookFetchingMaster) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LogBookMasterFetched) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: xxTinierSpacing),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.logBookFetchMasterModel.data.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              onTap: () {
                                Map addLogbookMap = {
                                  'logbookName': state.logBookFetchMasterModel
                                      .data[0][index].name,
                                  'logbookId': state
                                      .logBookFetchMasterModel.data[0][index].id
                                };
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ReportNewLogBookScreen(
                                            data: state
                                                .logBookFetchMasterModel.data,
                                            addLogbookMap: addLogbookMap)));
                              },
                              title: Text(
                                  state.logBookFetchMasterModel.data[0][index]
                                      .name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black)),
                              trailing: const Icon(Icons.navigate_next)));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: tinierSpacing);
                    },
                  ));
            } else if (state is LogBookMasterNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context.read<LogbookBloc>().add(FetchLogBookMaster());
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
