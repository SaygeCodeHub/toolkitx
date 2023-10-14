import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/assets_details_screen.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';

class AssetsListScreen extends StatelessWidget {
  static const routeName = 'AssetsListScreen';
  static int pageNo = 1;

  const AssetsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsList(pageNo: pageNo));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Assets')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: leftRightMargin),
            child: BlocBuilder<AssetsBloc, AssetsState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AssetsListFetching ||
                    currentState is AssetsListFetched ||
                    currentState is AssetsListError,
                builder: (context, state) {
                  if (state is AssetsListFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetsListFetched) {
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.fetchAssetsListModel.data.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Column(children: [
                            ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AssetsDetailsScreen.routeName,
                                      arguments: state
                                          .fetchAssetsListModel.data[index].id);
                                },
                                title: Text(
                                    state.fetchAssetsListModel.data[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.black)),
                                subtitle: Text(
                                  state.fetchAssetsListModel.data[index].tag,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.grey),
                                ),
                                trailing: Text(
                                  state.fetchAssetsListModel.data[index].status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.deepBlue),
                                ))
                          ]));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
