import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/blocs/workorder/workorder_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/workorder/workorder_events.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/primary_button.dart';

class WorkOrderFilterScreen extends StatelessWidget {
  static const routeName = 'WorkOrderFilterScreen';

  const WorkOrderFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderBloc>().add(FetchWorkOrderMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filter')),
        body: BlocBuilder<WorkOrderBloc, WorkOrderStates>(
            builder: (context, state) {
          if (state is FetchingWorkOrderMaster) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkOrderMasterFetched) {
            return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(DatabaseUtil.getText('DateRange'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxTinySpacing),
                      const SizedBox(height: xxTinySpacing),
                      Text(DatabaseUtil.getText('Status'),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxTinySpacing),
                      const SizedBox(height: xxxSmallerSpacing),
                      PrimaryButton(
                          onPressed: () {},
                          textValue: DatabaseUtil.getText('Apply'))
                    ]));
          } else if (state is WorkOrderMasterNotFetched) {
            return GenericReloadButton(
                onPressed: () {}, textValue: StringConstants.kReload);
          } else {
            return const SizedBox.shrink();
          }
        }));
  }
}
