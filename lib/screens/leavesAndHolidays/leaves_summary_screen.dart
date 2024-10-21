import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';
import 'widgtes/leaves_summary_subtitle.dart';

class LeavesSummaryScreen extends StatelessWidget {
  static const routeName = 'LeavesSummaryScreen';

  const LeavesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(FetchLeavesSummary());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('leave_summary')),
      body: BlocBuilder<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
          builder: (context, state) {
        if (state is FetchingLeavesSummary) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeavesSummaryFetched) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.fetchLeavesSummaryModel.data.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: Padding(
                            padding: const EdgeInsets.only(top: tinierSpacing),
                            child: ListTile(
                                title: Text(
                                    state.fetchLeavesSummaryModel.data[index]
                                        .name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.black)),
                                subtitle: LeavesSummarySubtitle(
                                    data: state.fetchLeavesSummaryModel
                                        .data[index]))));
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: kGridViewMainAxisExtent,
                      crossAxisSpacing: tinierSpacing,
                      mainAxisSpacing: tinierSpacing),
                )),
          );
        } else if (state is LeavesSummaryNotFetched) {
          return GenericReloadButton(
              onPressed: () {
                context.read<LeavesAndHolidaysBloc>().add(FetchLeavesSummary());
              },
              textValue: StringConstants.kReload);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
