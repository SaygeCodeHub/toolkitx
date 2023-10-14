import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/asset_util.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';

class AssetsDetailsScreen extends StatelessWidget {
  static const routeName = 'AssetsDetailsScreen';

  const AssetsDetailsScreen({super.key, required this.assetId});

  final String assetId;

  @override
  Widget build(BuildContext context) {
    context
        .read<AssetsBloc>()
        .add(FetchAssetsDetails(assetId: assetId, assetTabIndex: 0));
    return Scaffold(
        appBar: const GenericAppBar(),
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
                            tabBarViewWidgets: const [
                              Text("Tab 1"),
                              Text("Tab 2"),
                              Text("Tab 3"),
                              Text("Tab 4"),
                              Text("Tab 5"),
                              Text("Tab 6"),
                            ])
                      ]));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )));
  }
}
