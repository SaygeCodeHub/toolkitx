import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/screens/permit/permit_switching_schedule_table_screen.dart';
import 'package:toolkit/screens/permit/widgets/edit_mulitselect_switching_schedule_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';

class EditMultiSelectSwitchingScheduleScreen extends StatelessWidget {
  static const routeName = 'EditMultiSelectSwitchingScheduleScreen';

  const EditMultiSelectSwitchingScheduleScreen({
    super.key,
    required this.scheduleId,
    required this.instructionIds,
  });

  final String instructionIds;
  final String scheduleId;

  @override
  Widget build(BuildContext context) {
    print('instructionIds========>$instructionIds');
    context.read<PermitBloc>().add(const FetchPermitMaster());
    Map switchingScheduleMap = {};
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<PermitBloc, PermitStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingPermitMaster ||
                  currentState is PermitMasterFetched ||
                  currentState is CouldNotFetchPermitMaster,
              builder: (context, state) {
                if (state is FetchingPermitMaster) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.5),
                        child: const CircularProgressIndicator()),
                  );
                } else if (state is PermitMasterFetched) {
                  return EditMultiSelectSwitchingInstructionBody(
                    switchingScheduleMap: switchingScheduleMap,
                    permitGetMasterModel: state.permitGetMasterModel,
                  );
                } else if (state is CouldNotFetchPermitMaster) {
                  return const Center(
                      child: Text(StringConstants.kNoRecordsFound));
                }
                return const SizedBox.shrink();
              },
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<PermitBloc, PermitStates>(
          listener: (context, state) {
            if (state is PermitSwitchingScheduleUpdating) {
              ProgressBar.show(context);
            } else if (state is PermitSwitchingScheduleUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, PermitSwitchingScheduleTableScreen.routeName,
                  arguments: scheduleId);
            } else if (state is PermitSwitchingScheduleNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                switchingScheduleMap['instructionid'] = instructionIds;
                context.read<PermitBloc>().add(UpdatePermitSwitchingSchedule(
                    editSwitchingScheduleMap: switchingScheduleMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
