import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/status_tag.dart';

import '../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../blocs/safetyNotice/safety_notice_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_card.dart';

class SafetyNoticeScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeScreen';

  const SafetyNoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SafetyNoticeBloc>().add(FetchSafetyNotices());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('SafetyNotice')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            CustomIconButtonRow(
                primaryOnPress: () {},
                secondaryOnPress: () {},
                secondaryIcon: Icons.history,
                clearOnPress: () {}),
            const SizedBox(height: xxTinierSpacing),
            BlocBuilder<SafetyNoticeBloc, SafetyNoticeStates>(
                builder: (context, state) {
              if (state is FetchingSafetyNotices) {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: const CircularProgressIndicator()));
              } else if (state is SafetyNoticesFetched) {
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.fetchSafetyNoticesModel.data.notices.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            child: ListTile(
                              onTap: () {},
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
                                        Text(
                                            state.fetchSafetyNoticesModel.data
                                                .notices[index].refno,
                                            style: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        const SizedBox(width: tinierSpacing),
                                        Text(
                                            state.fetchSafetyNoticesModel.data
                                                .notices[index].status,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xxSmall
                                                .copyWith(
                                                    color: AppColor.deepBlue))
                                      ])),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      state.fetchSafetyNoticesModel.data
                                          .notices[index].notice,
                                      style:
                                          Theme.of(context).textTheme.xSmall),
                                  const SizedBox(height: tinierSpacing),
                                  StatusTag(tags: [
                                    StatusTagModel(
                                        title: state
                                                    .fetchSafetyNoticesModel
                                                    .data
                                                    .notices[index]
                                                    .isexpired ==
                                                '0'
                                            ? DatabaseUtil.getText('Issued')
                                            : DatabaseUtil.getText('Expired'),
                                        bgColor: state
                                                    .fetchSafetyNoticesModel
                                                    .data
                                                    .notices[index]
                                                    .isexpired ==
                                                '0'
                                            ? AppColor.deepBlue
                                            : AppColor.errorRed)
                                  ])
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: xxTinySpacing);
                        }));
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ),
      ),
    );
  }
}
