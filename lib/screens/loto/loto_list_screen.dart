import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/loto/loto_list_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';

class LotoListScreen extends StatelessWidget {
  static const routeName = 'LotoListScreen';
  static int pageNo = 1;

  const LotoListScreen({super.key, this.isFromHome = false});

  static List lotoListData = [];
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoListBloc>()
        .add(FetchLotoList(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('LOTO')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SafeArea(
          child: BlocConsumer<LotoListBloc, LotoListState>(
            buildWhen: (previousState, currentState) =>
                ((currentState is LotoListFetched &&
                        context.read<LotoListBloc>().hasReachedMax == false ||
                    currentState is FetchingLotoList && pageNo == 1)),
            listener: (context, state) {
              if (state is LotoListFetched) {
                if (state.fetchLotoListModel.status == 204) {
                  showCustomSnackBar(
                      context, StringConstants.kAllDataLoaded, '');
                  context.read<LotoListBloc>().hasReachedMax = true;
                  pageNo = 1;
                }
              }
            },
            builder: (context, state) {
              if (state is FetchingLotoList) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LotoListFetched) {
                if (state.fetchLotoListModel.data.isNotEmpty) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.hasReachedMax
                          ? state.data.length
                          : state.data.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.data.length) {
                          return CustomCard(
                            elevation: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: tinierSpacing),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    title: Text(state.data[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.black)),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: xxxTinierSpacing,
                                        ),
                                        Text(
                                          state.data[index].date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey),
                                        ),
                                        const SizedBox(
                                          height: xxxTinierSpacing,
                                        ),
                                        Text(
                                          state.data[index].location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey),
                                        ),
                                        const SizedBox(
                                          height: xxxTinierSpacing,
                                        ),
                                        Text(
                                          state.data[index].purpose,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey),
                                        ),
                                        const SizedBox(
                                          height: xxxTinierSpacing,
                                        ),
                                      ],
                                    ),
                                    trailing: Text(
                                      state.data[index].status,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.deepBlue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (!state.hasReachedMax) {
                          pageNo++;
                          context.read<LotoListBloc>().add(FetchLotoList(
                            pageNo: pageNo,
                                isFromHome: isFromHome,
                              ));
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  kCircularProgressIndicatorPadding),
                              child: SizedBox(
                                  width: kCircularProgressIndicatorWidth,
                                  child: CircularProgressIndicator()),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      });
                } else {
                  if (state.fetchLotoListModel.status == 204) {
                    return NoRecordsText(
                        text: DatabaseUtil.getText('no_records_found'));
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
