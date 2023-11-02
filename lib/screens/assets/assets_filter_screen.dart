import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/assets_list_screen.dart';
import 'package:toolkit/screens/assets/widgets/assets_location_filter.dart';
import 'package:toolkit/screens/assets/widgets/assets_site_filter.dart';
import 'package:toolkit/screens/assets/widgets/assets_status_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';

class AssetsFilterScreen extends StatelessWidget {
  static const routeName = "AssetsFilterScreen";
  AssetsFilterScreen({super.key});

  static Map assetsFilterMap = {};
  final List assetsLocation = [];
  final String selectLocationName = '';

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsMaster());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocConsumer<AssetsBloc, AssetsState>(
              buildWhen: (previousState, currentState) =>
                  currentState is AssetsMasterFetching ||
                  currentState is AssetsMasterFetched ||
                  currentState is AssetsMasterError,
              listener: (context, state) {
                if (state is AssetsMasterError) {
                  Navigator.pop(context);
                  showCustomSnackBar(
                      context,
                      DatabaseUtil.getText(
                          'some_unknown_error_please_try_again'),
                      '');
                }
              },
              builder: (context, state) {
                if (state is AssetsMasterFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AssetsMasterFetched) {
                  assetsFilterMap.addAll(state.assetsMasterMap);
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DatabaseUtil.getText('Name'),
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            TextFieldWidget(onTextFieldChanged: (textField) {
                              assetsFilterMap["name"] = textField;
                            }),
                            const SizedBox(height: tinierSpacing),
                            AssetsLocationFilter(
                                assetsFilterMap: assetsFilterMap,
                                assetsLocationList:
                                    state.fetchAssetsMasterModel.data),
                            const SizedBox(height: tinierSpacing),
                            Text(DatabaseUtil.getText('Site'),
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            AssetsSiteFilter(
                                assetsFilterMap: assetsFilterMap,
                                data: state.fetchAssetsMasterModel.data),
                            const SizedBox(height: tinierSpacing),
                            Text(DatabaseUtil.getText('Status'),
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            AssetsStatusFilter(
                                assetsFilterMap: assetsFilterMap,
                                data: state.fetchAssetsMasterModel.data),
                            const SizedBox(height: mediumSpacing),
                            PrimaryButton(
                                onPressed: () {
                                  context.read<AssetsBloc>().add(
                                      ApplyAssetsFilter(
                                          assetsFilterMap: assetsFilterMap));
                                  context.read<AssetsBloc>().assetsDatum = [];
                                  context.read<AssetsBloc>().hasReachedMax =
                                      false;
                                  AssetsListScreen.pageNo = 1;
                                  context.read<AssetsBloc>().add(
                                      FetchAssetsList(
                                          pageNo: 1, isFromHome: false));
                                  Navigator.pop(context);
                                },
                                textValue: StringConstants.kApply)
                          ]));
                } else {
                  return const SizedBox.shrink();
                }
              },
            )));
  }
}
