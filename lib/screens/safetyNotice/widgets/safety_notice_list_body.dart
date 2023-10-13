import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../../blocs/safetyNotice/safety_notice_events.dart';
import '../../../blocs/safetyNotice/safety_notice_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../safety_notice_screen.dart';
import 'safety_notice_list_card.dart';

class SafetyNoticeListBody extends StatelessWidget {
  const SafetyNoticeListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SafetyNoticeBloc, SafetyNoticeStates>(
      buildWhen: (previousState, currentState) =>
          (currentState is FetchingSafetyNotices &&
              SafetyNoticeScreen.pageNo == 1) ||
          (currentState is SafetyNoticesFetched),
      listener: (context, state) {
        if (state is SafetyNoticesFetched &&
            context.read<SafetyNoticeBloc>().safetyNoticeListReachedMax) {
          showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
        }
      },
      builder: (context, state) {
        if (state is FetchingSafetyNotices) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is SafetyNoticesFetched) {
          if (state.noticesDatum.isNotEmpty) {
            return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (context
                            .read<SafetyNoticeBloc>()
                            .safetyNoticeListReachedMax)
                        ? state.noticesDatum.length
                        : state.noticesDatum.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.noticesDatum.length) {
                        return SafetyNoticeListCard(
                            noticesDatum: state.noticesDatum[index]);
                      } else {
                        SafetyNoticeScreen.pageNo++;
                        context.read<SafetyNoticeBloc>().add(FetchSafetyNotices(
                            pageNo: SafetyNoticeScreen.pageNo,
                            isFromHomeScreen: false));
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinySpacing);
                    }));
          } else {
            return NoRecordsText(
                text: DatabaseUtil.getText('no_records_found'));
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
