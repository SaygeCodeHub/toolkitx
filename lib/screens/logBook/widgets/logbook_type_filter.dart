import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';

class LogbookTypeFilter extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map logbookFilterMap;

  const LogbookTypeFilter(
      {super.key, required this.data, required this.logbookFilterMap});

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(SelectLogBookTypeFilter(
        selectTypeList: (logbookFilterMap['types'] == null)
            ? []
            : logbookFilterMap['types']
                .toString()
                .replaceAll(' ', '')
                .split(','),
        typesName: ''));
    return Wrap(spacing: kFilterTags, children: [
      for (var item in data[2])
        BlocBuilder<LogbookBloc, LogbookStates>(
            buildWhen: (previousState, currentState) =>
                currentState is LogBookFilterTypesSelected,
            builder: (context, state) {
              if (state is LogBookFilterTypesSelected) {
                logbookFilterMap['types'] = state.selectedTypesList
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '');
                return FilterChip(
                    backgroundColor:
                        (state.selectedTypesList.contains(item.flagname))
                            ? AppColor.green
                            : AppColor.lightestGrey,
                    label: Text(item.flagname,
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      context.read<LogbookBloc>().add(SelectLogBookTypeFilter(
                          selectTypeList: state.selectedTypesList,
                          typesName: item.flagname));
                    });
              } else {
                return const SizedBox.shrink();
              }
            })
    ]);
  }
}
