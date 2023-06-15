import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_event.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_schedule_dates_section.dart';
import 'package:toolkit/screens/checklist/widgets/checklist_app_bar.dart';
import '../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_bloc.dart';
import '../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_states.dart';

class SystemUserScheduleDatesScreen extends StatelessWidget {
  static const routeName = 'SystemUserScheduleDatesScreen';
  final String checkListId;

  const SystemUserScheduleDatesScreen({Key? key, required this.checkListId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<ScheduleDatesBloc>()
        .add(FetchScheduleDatesList(checklistId: checkListId));
    return Scaffold(
        appBar: ChecklistAppBar(title:
            BlocBuilder<ScheduleDatesBloc, ScheduleDatesStates>(
                builder: (context, state) {
          if (state is DatesScheduled) {
            return Text(
                state.checklistScheduledByDatesModel.data![0].checklistname);
          } else {
            return const SizedBox();
          }
        })),
        body: ScheduleDatesSection(checklistId: checkListId));
  }
}
