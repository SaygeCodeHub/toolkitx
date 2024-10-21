import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/LogBook/logbook_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../../utils/database_utils.dart';
import 'logbook_location_list.dart';

class LogBookLocationListTile extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map reportNewLogBookMap;

  const LogBookLocationListTile(
      {super.key, required this.data, required this.reportNewLogBookMap});

  @override
  Widget build(BuildContext context) {
    context
        .read<LogbookBloc>()
        .add(SelectLogBookLocation(locationId: '', locationName: ''));
    return BlocBuilder<LogbookBloc, LogbookStates>(
        buildWhen: (previousState, currentState) =>
            currentState is LogBookLocationSelected,
        builder: (context, state) {
          if (state is LogBookLocationSelected) {
            reportNewLogBookMap['loc'] = state.locationId;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LogBookLocationList(
                              data: data, locationName: state.locationName)));
                },
                title: Text(DatabaseUtil.getText('Location'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                subtitle: (state.locationName == '')
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(top: xxxTinierSpacing),
                        child: Text(state.locationName,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.black)),
                      ),
                trailing:
                    const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
