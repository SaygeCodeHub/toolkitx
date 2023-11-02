import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/assets/assets_list_screen.dart';
import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import 'aasets_list_card.dart';

class AssetsListBody extends StatelessWidget {
  const AssetsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
            currentState is AssetsListFetched ||
            (currentState is AssetsListFetching &&
                AssetsListScreen.pageNo == 1),
        listener: (context, state) {
          if (state is AssetsListFetched) {
            if (state.fetchAssetsListModel.status == 204 &&
                context.read<AssetsBloc>().assetsDatum.isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is AssetsListFetching) {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is AssetsListFetched) {
            if (context.read<AssetsBloc>().assetsDatum.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: context.read<AssetsBloc>().hasReachedMax
                          ? context.read<AssetsBloc>().assetsDatum.length
                          : context.read<AssetsBloc>().assetsDatum.length + 1,
                      itemBuilder: (context, index) {
                        if (index <
                            context.read<AssetsBloc>().assetsDatum.length) {
                          return AssetsListCard(
                              data: context
                                  .read<AssetsBloc>()
                                  .assetsDatum[index]);
                        } else if (!state.hasReachedMax) {
                          AssetsListScreen.pageNo++;
                          context.read<AssetsBloc>().add(FetchAssetsList(
                              pageNo: AssetsListScreen.pageNo,
                              isFromHome: false));
                          return const Center(
                              child: Padding(
                                  padding: EdgeInsets.all(
                                      kCircularProgressIndicatorPadding),
                                  child: SizedBox(
                                      width: kCircularProgressIndicatorWidth,
                                      child: CircularProgressIndicator())));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      }));
            } else if (state.fetchAssetsListModel.status == 204 &&
                context.read<AssetsBloc>().assetsDatum.isEmpty) {
              if (context.read<AssetsBloc>().filters.isNotEmpty) {
                return const NoRecordsText(
                    text: StringConstants.kNoRecordsFilter);
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            }
          }
          return const SizedBox.shrink();
        });
  }
}
