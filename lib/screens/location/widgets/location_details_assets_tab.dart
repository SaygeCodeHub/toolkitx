import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../assets/assets_filter_screen.dart';
import 'location_details_assets_body.dart';

class LocationDetailsAssetsTab extends StatelessWidget {
  final int selectedTabIndex;
  final String expenseId;
  static int pageNo = 1;

  const LocationDetailsAssetsTab(
      {Key? key, required this.selectedTabIndex, required this.expenseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocationAssets(pageNo: 1));
    context.read<LocationBloc>().locationAssets.clear();
    context.read<LocationBloc>().locationAssetsListReachedMax = false;
    return Column(
      children: [
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationAssetsFetched) {
              return CustomIconButtonRow(
                  primaryOnPress: () {
                    AssetsFilterScreen.isFromLocation = true;
                    AssetsFilterScreen.expenseId = expenseId;
                    Navigator.pushNamed(context, AssetsFilterScreen.routeName);
                  },
                  secondaryOnPress: () {},
                  clearVisible: state.filterMap.isNotEmpty,
                  secondaryVisible: false,
                  clearOnPress: () {
                    pageNo = 1;
                    state.filterMap.clear();
                    AssetsFilterScreen.assetsFilterMap.clear();
                    context.read<LocationBloc>().assetsFilterMap.clear();
                    context.read<LocationBloc>().locationAssets.clear();
                    context.read<LocationBloc>().locationAssetsListReachedMax =
                        false;
                    context
                        .read<LocationBloc>()
                        .add(FetchLocationAssets(pageNo: pageNo));
                  });
            } else if (state is LocationAssetsNotFetched) {
              return CustomIconButtonRow(
                  primaryOnPress: () {
                    AssetsFilterScreen.isFromLocation = true;
                    AssetsFilterScreen.expenseId = expenseId;
                    Navigator.pushNamed(context, AssetsFilterScreen.routeName);
                  },
                  secondaryOnPress: () {},
                  clearVisible: state.filterMap.isNotEmpty,
                  secondaryVisible: false,
                  clearOnPress: () {
                    pageNo = 1;
                    state.filterMap.clear();
                    AssetsFilterScreen.assetsFilterMap.clear();
                    context.read<LocationBloc>().assetsFilterMap.clear();
                    context.read<LocationBloc>().locationAssets.clear();
                    context.read<LocationBloc>().locationAssetsListReachedMax =
                        false;
                    context
                        .read<LocationBloc>()
                        .add(FetchLocationAssets(pageNo: pageNo));
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: xxTinierSpacing),
        BlocConsumer<LocationBloc, LocationState>(
          buildWhen: (previousState, currentState) =>
              (currentState is FetchingLocationAssets && pageNo == 1) ||
              currentState is LocationAssetsFetched ||
              currentState is LocationAssetsNotFetched,
          listener: (context, state) {
            if (state is LocationLoToFetched &&
                state.locationLoToListReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          builder: (context, state) {
            if (state is FetchingLocationAssets) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is LocationAssetsFetched) {
              return LocationDetailsAssetsBody(
                  locationAssets: state.locationAssets,
                  locationAssetsListReachedMax:
                      state.locationAssetsListReachedMax);
            } else if (state is LocationAssetsNotFetched) {
              if (context.read<LocationBloc>().assetsFilterMap.isNotEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
