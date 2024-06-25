import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import 'widgtes/apply_for_leave_body.dart';

class ApplyForLeaveScreen extends StatelessWidget {
  static const routeName = 'ApplyForLeaveScreen';

  ApplyForLeaveScreen({Key? key}) : super(key: key);
  final Map applyForLeaveMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(FetchLeavesAndHolidaysMaster());
    return Scaffold(
      appBar: GenericAppBar(
        title: DatabaseUtil.getText('ApplyForLeave'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textValue: DatabaseUtil.getText('buttonBack')),
            ),
            const SizedBox(width: xxTinierSpacing),
            BlocListener<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
              listener: (context, state) {
                if (state is ApplyingForLeave) {
                  ProgressBar.show(context);
                } else if (state is ApplyForLeaveManagerConfirmationNeeded) {
                  ProgressBar.dismiss(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AndroidPopUp(
                          isNoVisible: false,
                          textValue: StringConstants.kOk,
                          titleValue: StringConstants.kAlert,
                          contentValue: state.confirmationMessage,
                          onPrimaryButton: () {
                            Navigator.pop(context);
                          },
                        );
                      });
                } else if (state is AppliedForLeave) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  context
                      .read<LeavesAndHolidaysBloc>()
                      .add(FetchLeavesDetails(page: 1));
                } else if (state is CouldNotApplyForLeave) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.couldNotApplyForLeave, '');
                }
              },
              child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      context.read<LeavesAndHolidaysBloc>().add(
                          ApplyForLeave(applyForLeaveMap: applyForLeaveMap));
                    },
                    textValue: DatabaseUtil.getText('buttonSave')),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingLeavesAndHolidaysMaster ||
              currentState is LeavesAndHolidaysMasterFetched ||
              currentState is LeavesAndHolidaysMasterNotFetched,
          builder: (context, state) {
            if (state is FetchingLeavesAndHolidaysMaster) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LeavesAndHolidaysMasterFetched) {
              return ApplyForLeaveBody(
                  applyForLeaveMap: applyForLeaveMap,
                  data: state.fetchLeavesAndHolidaysMasterModel.data[0]);
            } else if (state is LeavesAndHolidaysMasterNotFetched) {
              return Center(
                child: GenericReloadButton(
                    onPressed: () {
                      context
                          .read<LeavesAndHolidaysBloc>()
                          .add(FetchLeavesAndHolidaysMaster());
                    },
                    textValue: StringConstants.kReload),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
