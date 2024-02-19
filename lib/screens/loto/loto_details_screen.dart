import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/loto/widgets/loto_custom_timeline.dart';
import 'package:toolkit/screens/loto/loto_view_checklist_tab.dart';
import 'package:toolkit/screens/loto/widgets/loto_details.dart';
import 'package:toolkit/screens/loto/widgets/loto_image_tab.dart';
import 'package:toolkit/screens/loto/widgets/loto_pop_up_menu_button.dart';
import 'package:toolkit/screens/loto/widgets/loto_remove_checklist_tab.dart';
import 'package:toolkit/screens/loto/widgets/loto_tab_six_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/loto_util.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/status_tag.dart';

class LotoDetailsScreen extends StatelessWidget {
  static const routeName = 'LotoDetailsScreen';

  const LotoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LotoDetailsBloc>().add(FetchLotoDetails(lotoTabIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
              buildWhen: (previousState, currentState) =>
                  currentState is LotoDetailsFetching ||
                  currentState is LotoDetailsFetched,
              builder: (context, state) {
                if (state is LotoDetailsFetched) {
                  if (state.showPopUpMenu == true) {
                    return LotoPopupMenuButton(
                      popUpMenuItems: state.lotoPopUpMenuList,
                      fetchLotoDetailsModel: state.fetchLotoDetailsModel,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              })
        ]),
        body: BlocConsumer<LotoDetailsBloc, LotoDetailsState>(
            listener: (context, state) {
              if (state is LotoWorkforceDeleting) {
                ProgressBar.show(context);
              } else if (state is LotoWorkforceDeleted) {
                ProgressBar.dismiss(context);
                Navigator.pushReplacementNamed(
                    context, LotoDetailsScreen.routeName);
                showCustomSnackBar(
                    context, StringConstants.kWorkforceDeleted, '');
              } else if (state is LotoWorkforceNotDeleted) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
            buildWhen: (previousState, currentState) =>
                currentState is LotoDetailsFetching ||
                currentState is LotoDetailsFetched,
            builder: (context, state) {
              if (state is LotoDetailsFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LotoDetailsFetched) {
                var data = state.fetchLotoDetailsModel.data;
                return Padding(
                    padding: const EdgeInsets.only(top: xxTinierSpacing),
                    child: Column(children: [
                      Card(
                          color: AppColor.white,
                          elevation: kCardElevation,
                          child: ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: xxTinierSpacing),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.loto),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: data.statustext,
                                              bgColor: AppColor.deepBlue)
                                        ])
                                      ])))),
                      const SizedBox(height: xxTinierSpacing),
                      const Divider(
                          height: kDividerHeight, thickness: kDividerWidth),
                      const SizedBox(height: xxTinierSpacing),
                      CustomTabBarView(
                          lengthOfTabs: 6,
                          tabBarViewIcons: LotoUtil().tabBarViewIcons,
                          initialIndex:
                              context.read<LotoDetailsBloc>().lotoTabIndex,
                          tabBarViewWidgets: [
                            LotoDetails(
                                fetchLotoDetailsModel:
                                    state.fetchLotoDetailsModel,
                                lotoTabIndex: context
                                    .read<LotoDetailsBloc>()
                                    .lotoTabIndex,
                                clientId: state.clientId),
                            LotoImageTab(data: data, clientId: state.clientId),
                            LotoViewChecklistTab(
                                data: state.fetchLotoDetailsModel.data),
                            LotoRemoveChecklistTab(
                                data: state.fetchLotoDetailsModel.data),
                            LotoCustomTimeLine(
                                fetchLotoDetailsModel:
                                    state.fetchLotoDetailsModel),
                            LotoTabSixScreen(
                                fetchLotoDetailsModel:
                                    state.fetchLotoDetailsModel)
                          ])
                    ]));
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
