import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/assets/widgets/assets_codes_tab.dart';
import 'package:toolkit/screens/assets/widgets/assets_cost_and_depreciation_tab.dart';
import 'package:toolkit/screens/assets/widgets/assets_description_tab.dart';
import 'package:toolkit/screens/assets/widgets/assets_details_tab.dart';
import 'package:toolkit/screens/assets/widgets/assets_popup_menu_button.dart';
import 'package:toolkit/utils/asset_util.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'widgets/assets_it_info_tab.dart';
import 'widgets/assets_warranty_tab.dart';

class AssetsDetailsScreen extends StatelessWidget {
  static const routeName = 'AssetsDetailsScreen';

  const AssetsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsDetails(
        assetId: context.read<AssetsBloc>().assetId, assetTabIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<AssetsBloc, AssetsState>(
              buildWhen: (previousState, currentState) =>
                  currentState is AssetsDetailsFetching ||
                  currentState is AssetsDetailsFetched,
              builder: (context, state) {
                if (state is AssetsDetailsFetched) {
                  if (state.showPopUpMenu == true) {
                    return AssetsPopUpMenuButton(
                        popUpMenuItems: state.assetsPopUpMenu,
                        assetsDetailsModel: state.fetchAssetsDetailsModel);
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              })
        ]),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: leftRightMargin),
            child: BlocBuilder<AssetsBloc, AssetsState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AssetsDetailsFetching ||
                    currentState is AssetsDetailsFetched ||
                    currentState is AssetsDetailsError,
                builder: (context, state) {
                  if (state is AssetsDetailsFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetsDetailsFetched) {
                    return Padding(
                        padding: const EdgeInsets.only(top: xxTinierSpacing),
                        child: Column(children: [
                          Card(
                              color: AppColor.white,
                              elevation: kCardElevation,
                              child: ListTile(
                                  title: Padding(
                                      padding: const EdgeInsets.only(
                                          top: xxxTinierSpacing),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(state.fetchAssetsDetailsModel
                                                .data.name),
                                            StatusTag(tags: [
                                              StatusTagModel(
                                                  title: state
                                                      .fetchAssetsDetailsModel
                                                      .data
                                                      .status,
                                                  bgColor: AppColor.deepBlue)
                                            ])
                                          ])))),
                          const SizedBox(height: xxTinierSpacing),
                          const Divider(
                              height: kDividerHeight, thickness: kDividerWidth),
                          const SizedBox(height: xxTinierSpacing),
                          CustomTabBarView(
                              lengthOfTabs: 6,
                              tabBarViewIcons: AssetUtil().tabBarViewIcons,
                              initialIndex:
                                  context.read<AssetsBloc>().assetTabIndex,
                              tabBarViewWidgets: [
                                AssetsDetailsTab(
                                    data: state.fetchAssetsDetailsModel.data),
                                AssetsWarrantyTab(
                                    data: state.fetchAssetsDetailsModel.data),
                                AssetsITInfoTab(
                                    data: state.fetchAssetsDetailsModel.data),
                                AssetsCodesTab(
                                    data: state.fetchAssetsDetailsModel.data),
                                AssetsCostAndDepreciationTab(
                                    data: state.fetchAssetsDetailsModel.data,
                                    fetchAssetsDetailsModel:
                                        state.fetchAssetsDetailsModel),
                                AssetsDescriptionTab(
                                    data: state.fetchAssetsDetailsModel.data)
                              ])
                        ]));
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
