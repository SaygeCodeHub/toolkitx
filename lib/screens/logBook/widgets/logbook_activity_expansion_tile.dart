import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/expansion_tile_border.dart';

class LogBookActivityExpansionTile extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map reportNewLogBookMap;

  const LogBookActivityExpansionTile(
      {Key? key, required this.data, required this.reportNewLogBookMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookActivity(activityName: ''));
    String activityId = '';
    return BlocBuilder<LogbookBloc, LogbookStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LogBookActivitySelected,
        builder: (context, state) {
          if (state is LogBookActivitySelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text((state.activityName == '')
                        ? DatabaseUtil.getText('select_item')
                        : state.activityName),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data[3].length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: kExpansionTileMargin,
                                    right: kExpansionTileMargin),
                                activeColor: AppColor.deepBlue,
                                title: Text(data[3][index].activityname,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: data[3][index].activityname,
                                groupValue: state.activityName,
                                onChanged: (value) {
                                  value = data[3][index].activityname;
                                  activityId = data[3][index].id.toString();
                                  reportNewLogBookMap['activity'] = activityId;
                                  context.read<LogbookBloc>().add(
                                      SelectLogBookActivity(
                                          activityName: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
