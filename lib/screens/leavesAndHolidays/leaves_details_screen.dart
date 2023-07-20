import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../blocs/leavesAndHolidays/leaves_and_holidays_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import 'apply_for_leave_screen.dart';
import 'widgtes/leaves_details_card.dart';

class LeavesDetailsScreen extends StatefulWidget {
  static const routeName = 'LeavesDetailsScreen';

  const LeavesDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LeavesDetailsScreen> createState() => _LeavesDetailsScreenState();
}

class _LeavesDetailsScreenState extends State<LeavesDetailsScreen> {
  ScrollController controller = ScrollController();
  int page = 1;
  List leavesDetailsData = [];
  bool waitForData = false;
  bool noMoreData = false;

  @override
  void initState() {
    page = 1;
    noMoreData = false;
    leavesDetailsData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<LeavesAndHolidaysBloc>().add(FetchLeavesDetails(page: 1));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kLeaveDetails),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, ApplyForLeaveScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: BlocConsumer<LeavesAndHolidaysBloc, LeavesAndHolidaysStates>(
          buildWhen: (previousState, currentState) =>
              ((currentState is LeavesDetailsFetched && noMoreData != true) ||
                  (currentState is FetchingLeavesDetails && page == 1)),
          listener: (context, state) {
            if (state is LeavesDetailsFetched) {
              if (state.fetchLeavesDetailsModel.status == 204 &&
                  leavesDetailsData.isNotEmpty) {
                noMoreData = true;
                showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
              }
            }
          },
          builder: (context, state) {
            if (state is LeavesDetailsFetched) {
              if (state.fetchLeavesDetailsModel.data.isNotEmpty) {
                if (page == 1) {
                  leavesDetailsData = state.fetchLeavesDetailsModel.data;
                } else {
                  for (var item in state.fetchLeavesDetailsModel.data) {
                    leavesDetailsData.add(item);
                  }
                }
                waitForData = false;
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinierSpacing),
                    child: ListView.separated(
                        controller: controller
                          ..addListener(() {
                            if (noMoreData != true && waitForData == false) {
                              if (controller.position.extentAfter < 500) {
                                page++;
                                context
                                    .read<LeavesAndHolidaysBloc>()
                                    .add(FetchLeavesDetails(page: page));
                                waitForData = true;
                              }
                            }
                          }),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: leavesDetailsData.length,
                        itemBuilder: (context, index) {
                          return LeavesDetailsCard(
                              detailsData: leavesDetailsData[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        }));
              } else {
                return Center(
                    child: Text(DatabaseUtil.getText('no_records_found')));
              }
            } else if (state is FetchingLeavesDetails) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
