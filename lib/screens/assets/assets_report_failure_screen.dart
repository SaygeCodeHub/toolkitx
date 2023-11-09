import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/widgets/assets_failure_code_chips.dart';
import 'package:toolkit/screens/assets/widgets/assets_location_filter.dart';
import 'package:toolkit/screens/assets/widgets/assets_site_filter.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/primary_button.dart';

class AssetsReportFailureScreen extends StatelessWidget {
  static const routeName = "AssetsReportFailureScreen";

  AssetsReportFailureScreen({super.key});

  static Map assetsReportFailureMap = {};
  final List reportFailureLocation = [];
  final String selectLocationName = '';

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsMaster());
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kReportFailure,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<AssetsBloc, AssetsState>(
            buildWhen: (previousState, currentState) =>
                currentState is AssetsMasterFetching ||
                currentState is AssetsMasterFetched ||
                currentState is AssetsMasterError,
            builder: (context, state) {
              if (state is AssetsMasterFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssetsMasterFetched) {
                // assetsReportFailureMap.addAll(state.assetsMasterMap);
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AssetsLocationFilter(
                              assetsFilterMap: assetsReportFailureMap,
                              assetsLocationList:
                                  state.fetchAssetsMasterModel.data),
                          const SizedBox(height: tinierSpacing),
                          Text(StringConstants.kFailureCode,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black)),
                          AssetsFailureCodeChips(
                              data: state.fetchAssetsMasterModel.data,
                              assetsReportFailureMap: assetsReportFailureMap),
                          const SizedBox(height: tinierSpacing),
                          PrimaryButton(
                              onPressed: () {
                                context.read<AssetsBloc>().add(
                                    ApplyAssetsFilter(
                                        assetsFilterMap:
                                            assetsReportFailureMap));
                              },
                              textValue: StringConstants.kApply)
                        ]));
              } else {
                return const SizedBox.shrink();
              }
            },
          )),
    );
  }
}
