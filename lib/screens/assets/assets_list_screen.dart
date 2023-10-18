import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/assets/widgets/assets_list_body.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/text_button.dart';
import 'assets_filter_screen.dart';

class AssetsListScreen extends StatelessWidget {
  static const routeName = 'AssetsListScreen';
  static int pageNo = 1;

  const AssetsListScreen({super.key, this.isFromHome = false});

  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context
        .read<AssetsBloc>()
        .add(FetchAssetsList(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Assets')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: leftRightMargin),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<AssetsBloc, AssetsState>(
                    buildWhen: (previousState, currentState) =>
                        (currentState is AssetsListFetching && pageNo == 1) ||
                        (currentState is AssetsListFetched),
                    builder: (context, state) {
                      if (state is AssetsListFetched) {
                        return Visibility(
                            visible:
                                context.read<AssetsBloc>().filters.isNotEmpty,
                            child: CustomTextButton(
                                onPressed: () {
                                  context.read<AssetsBloc>().assetsDatum = [];
                                  context
                                      .read<AssetsBloc>()
                                      .selectLocationName = '';
                                  context.read<AssetsBloc>().filters = {};
                                  context.read<AssetsBloc>().hasReachedMax =
                                      false;
                                  pageNo = 1;
                                  context
                                      .read<AssetsBloc>()
                                      .add(ClearAssetsFilter());
                                  AssetsFilterScreen.assetsFilterMap = {};
                                  context.read<AssetsBloc>().add(
                                      FetchAssetsList(
                                          pageNo: 1, isFromHome: isFromHome));
                                },
                                textValue: DatabaseUtil.getText('Clear')));
                      } else {
                        return const SizedBox();
                      }
                    }),
                CustomIconButtonRow(
                    primaryOnPress: () {
                      Navigator.pushNamed(
                          context, AssetsFilterScreen.routeName);
                    },
                    secondaryVisible: false,
                    isEnabled: true,
                    secondaryOnPress: () {},
                    clearOnPress: () {})
              ]),
              const SizedBox(height: xxTinierSpacing),
              const AssetsListBody(),
            ])));
  }
}
