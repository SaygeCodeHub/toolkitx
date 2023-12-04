import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/widgets/assets_add_and_edit_downtime_screen.dart';
import 'package:toolkit/screens/assets/widgets/assets_downtime_popup_menu.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';

class AssetsManageDownTimeScreen extends StatelessWidget {
  static const routeName = 'AssetsManageDownTimeScreen';
  static int pageNo = 1;
  const AssetsManageDownTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsGetDownTime(
        assetId: context.read<AssetsBloc>().assetId, pageNo: pageNo));
    return Scaffold(
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                        context, AssetsAddAndEditDowntimeScreen.routeName,
                        arguments: "")
                    .then((_) => {
                          context.read<AssetsBloc>().add(FetchAssetsGetDownTime(
                              assetId: context.read<AssetsBloc>().assetId,
                              pageNo: pageNo))
                        });
              },
              child: const Icon(Icons.add),
            )),
        appBar: const GenericAppBar(title: StringConstants.kManageDownTime),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: leftRightMargin),
            child: BlocConsumer<AssetsBloc, AssetsState>(
                listener: (context, state) {
                  if (state is AssetsDownTimeDeleting) {
                    ProgressBar.show(context);
                  } else if (state is AssetsDownTimeDeleted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(
                        context, StringConstants.kDowntimeDeleted, "");
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, AssetsManageDownTimeScreen.routeName);
                  } else if (state is AssetsDownTimeNotDeleted) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, "");
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is AssetsGetDownTimeFetching ||
                    currentState is AssetsGetDownTimeFetched ||
                    currentState is AssetsGetDownTimeError,
                builder: (context, state) {
                  if (state is AssetsGetDownTimeFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetsGetDownTimeFetched) {
                    return ListView.separated(
                      itemCount: state.fetchAssetsDowntimeModel.data.length,
                      itemBuilder: (context, index) {
                        var hours = state.fetchAssetsDowntimeModel.data[index]
                                .totalmins ~/
                            60;
                        var remainingMin = state.fetchAssetsDowntimeModel
                                .data[index].totalmins %
                            60;
                        return CustomCard(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: xxxTinierSpacing,
                                    bottom: xxxTinierSpacing),
                                child: ListTile(
                                  title: Row(children: [
                                    Expanded(
                                      child: Text(
                                          "${state.fetchAssetsDowntimeModel.data[index].startdatetime} - ${state.fetchAssetsDowntimeModel.data[index].enddatetime}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.black)),
                                    ),
                                    SizedBox(
                                        width: smallerSpacing,
                                        child: AssetsDowntimePopUpMenu(
                                            popUpMenuItems:
                                                state.assetsPopUpMenu,
                                            fetchAssetsDowntimeModel:
                                                state.fetchAssetsDowntimeModel,
                                            downtimeId: state
                                                .fetchAssetsDowntimeModel
                                                .data[index]
                                                .id))
                                  ]),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${hours}hr : ${remainingMin}m",
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey)),
                                        const SizedBox(height: tiniestSpacing),
                                        Text(
                                            state.fetchAssetsDowntimeModel
                                                .data[index].note,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey)),
                                      ]),
                                )));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
