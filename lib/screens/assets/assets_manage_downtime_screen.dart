import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/assets/widgets/assets_add_and_edit_downtime_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../utils/database_utils.dart';
import '../../widgets/generic_no_records_text.dart';
import 'widgets/assets_manage_downtime_body.dart';

class AssetsManageDownTimeScreen extends StatelessWidget {
  static const routeName = 'AssetsManageDownTimeScreen';
  static int pageNo = 1;

  const AssetsManageDownTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<AssetsBloc>().hasDowntimeReachedMax = false;
    context.read<AssetsBloc>().assetsDowntimeDatum = [];
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
                  if (state is AssetsGetDownTimeFetched &&
                      context.read<AssetsBloc>().hasDowntimeReachedMax) {
                    showCustomSnackBar(
                        context, StringConstants.kAllDataLoaded, '');
                  }
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
                    (currentState is AssetsGetDownTimeFetching &&
                        pageNo == 1) ||
                    currentState is AssetsGetDownTimeFetched,
                builder: (context, state) {
                  if (state is AssetsGetDownTimeFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetsGetDownTimeFetched) {
                    if (state.assetDowntimeDatum.isNotEmpty) {
                      return AssetsManageDowntimeBody(
                        assetDowntimeDatum: state.assetDowntimeDatum,
                        assetsPopUpMenu: state.assetsPopUpMenu,
                      );
                    } else {
                      return NoRecordsText(
                          text: DatabaseUtil.getText('no_records_found'));
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
