import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';

class RegisterNewLogBookTypeExpansionTile extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map reportNewLogBookMap;

  const RegisterNewLogBookTypeExpansionTile(
      {Key? key, required this.data, required this.reportNewLogBookMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<LogbookBloc>()
        .add(SelectLogBookType(typeNameList: [], typeName: ''));
    return BlocBuilder<LogbookBloc, LogbookStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LogBookTypeSelected,
        builder: (context, state) {
          if (state is LogBookTypeSelected) {
            reportNewLogBookMap['flags'] = state.typeNameList
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
            return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(
                      left: kExpansionTileMargin, right: kExpansionTileMargin),
                  collapsedBackgroundColor: AppColor.white,
                  maintainState: true,
                  iconColor: AppColor.deepBlue,
                  textColor: AppColor.black,
                  title: Text(
                      (reportNewLogBookMap['flags'] == '')
                          ? DatabaseUtil.getText('select_item')
                          : reportNewLogBookMap['flags'],
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data[2].length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                              checkColor: AppColor.white,
                              activeColor: AppColor.deepBlue,
                              contentPadding: EdgeInsets.zero,
                              value: state.typeNameList
                                  .contains(data[2][index].flagname),
                              title: Text(data[2][index].flagname),
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (value) {
                                context.read<LogbookBloc>().add(
                                    SelectLogBookType(
                                        typeNameList: state.typeNameList,
                                        typeName: data[2][index].flagname));
                              });
                        }),
                  ]),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
