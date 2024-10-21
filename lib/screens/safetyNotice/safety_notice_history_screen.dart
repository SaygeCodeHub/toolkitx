import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_bloc.dart';
import 'package:toolkit/blocs/safetyNotice/safety_notice_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'safety_notice_details_screen.dart';

class SafetyNoticeHistoryScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeHistoryScreen';

  const SafetyNoticeHistoryScreen({super.key});

  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<SafetyNoticeBloc>().noticesHistoryDatum.clear();
    context.read<SafetyNoticeBloc>().safetyNoticeHistoryListReachedMax = false;
    context
        .read<SafetyNoticeBloc>()
        .add(FetchSafetyNoticeHistoryList(pageNo: pageNo));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('SafetyNotice')),
      body: BlocConsumer<SafetyNoticeBloc, SafetyNoticeStates>(
        buildWhen: (previousState, currentState) =>
            (currentState is FetchingSafetyNoticeHistoryList && pageNo == 1) ||
            (currentState is SafetyNoticeHistoryListFetched),
        listener: (context, state) {
          if (state is SafetyNoticeHistoryListFetched &&
              context
                  .read<SafetyNoticeBloc>()
                  .safetyNoticeHistoryListReachedMax) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        },
        builder: (context, state) {
          if (state is FetchingSafetyNoticeHistoryList) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SafetyNoticeHistoryListFetched) {
            if (state.historyDatum.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: xxTinierSpacing),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (context
                            .read<SafetyNoticeBloc>()
                            .safetyNoticeHistoryListReachedMax)
                        ? state.historyDatum.length
                        : state.historyDatum.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.historyDatum.length) {
                        return CustomCard(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context,
                                      SafetyNoticeDetailsScreen.routeName,
                                      arguments: state.historyDatum[index].id)
                                  .then((value) {
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(context,
                                      SafetyNoticeHistoryScreen.routeName);
                                }
                              });
                            },
                            contentPadding:
                                const EdgeInsets.all(xxTinierSpacing),
                            title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: xxTinierSpacing),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.historyDatum[index].refno,
                                          style: Theme.of(context)
                                              .textTheme
                                              .small
                                              .copyWith(
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w600)),
                                      const SizedBox(width: tinierSpacing),
                                      Text(state.historyDatum[index].status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xxSmall
                                              .copyWith(
                                                  color: AppColor.deepBlue))
                                    ])),
                            subtitle: Text(state.historyDatum[index].notice,
                                style: Theme.of(context).textTheme.xSmall),
                          ),
                        );
                      } else {
                        pageNo++;
                        context
                            .read<SafetyNoticeBloc>()
                            .add(FetchSafetyNoticeHistoryList(pageNo: pageNo));
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinySpacing);
                    }),
              );
            } else if (state is SafetyNoticeHistoryListNotFetched) {
              return NoRecordsText(
                  text: DatabaseUtil.getText('no_records_found'));
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
