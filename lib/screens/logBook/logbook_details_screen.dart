import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/LogBook/logbook_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';

class LogBookDetailsScreen extends StatelessWidget {
  static const routeName = 'LogBookDetailsScreen';
  final String logId;

  const LogBookDetailsScreen({super.key, required this.logId});

  @override
  Widget build(BuildContext context) {
    context.read<LogbookBloc>().add(FetchLogBookDetails(logId: logId));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('LogDetails')),
      body: BlocBuilder<LogbookBloc, LogbookStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingLogBookDetails ||
              currentState is LogBookDetailsFetched ||
              currentState is LogBookDetailsNotFetched,
          builder: (context, state) {
            if (state is FetchingLogBookDetails) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LogBookDetailsFetched) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: tiniestSpacing),
                        Text(
                          state.fetchLogBookDetailsModel.data.logbookname,
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: tinySpacing),
                        Text(
                          StringConstants.kDate,
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(state.fetchLogBookDetailsModel.data.createddate,
                            style: Theme.of(context).textTheme.small),
                        const SizedBox(height: tinySpacing),
                        Text(
                          DatabaseUtil.getText('Component'),
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(state.fetchLogBookDetailsModel.data.component,
                            style: Theme.of(context).textTheme.small),
                        const SizedBox(height: tinySpacing),
                        Text(
                          DatabaseUtil.getText('Location'),
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(state.fetchLogBookDetailsModel.data.locationname,
                            style: Theme.of(context).textTheme.small),
                        const SizedBox(height: tinySpacing),
                        Text(
                          DatabaseUtil.getText('Activity'),
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(state.fetchLogBookDetailsModel.data.activityname,
                            style: Theme.of(context).textTheme.small),
                        const SizedBox(height: tinySpacing),
                        Text(
                          DatabaseUtil.getText('Details'),
                          style: Theme.of(context).textTheme.medium,
                        ),
                        const SizedBox(height: xxTinierSpacing),
                        Text(state.fetchLogBookDetailsModel.data.description,
                            style: Theme.of(context).textTheme.small),
                      ],
                    )),
              );
            } else if (state is LogBookDetailsNotFetched) {
              return GenericReloadButton(
                  onPressed: () {
                    context
                        .read<LogbookBloc>()
                        .add(FetchLogBookDetails(logId: logId));
                  },
                  textValue: StringConstants.kReload);
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
