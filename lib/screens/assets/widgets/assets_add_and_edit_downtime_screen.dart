import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_spacing.dart';
import 'assets_add_and_edit_downtime_body.dart';

class AssetsAddAndEditDowntimeScreen extends StatelessWidget {
  static const routeName = "AssetsAddAndEditDowntimeScreen";

  const AssetsAddAndEditDowntimeScreen({super.key, required this.downtimeId});

  static Map saveDowntimeMap = {};
  final String downtimeId;

  @override
  Widget build(BuildContext context) {
    context
        .read<AssetsBloc>()
        .add(FetchAssetsSingleDowntime(downtimeId: downtimeId));

    return Scaffold(
        appBar: GenericAppBar(
            title: ((downtimeId == "")
                ? DatabaseUtil.getText("AddDowntime")
                : StringConstants.kEditDownTime)),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: BlocListener<AssetsBloc, AssetsState>(
              listener: (context, state) {
                if (state is AssetsDownTimeSaving) {
                  ProgressBar.show(context);
                } else if (state is AssetsDownTimeSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, StringConstants.kDowntimeSaved, "");
                  Navigator.pop(context);
                } else if (state is AssetsDownTimeNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, "");
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    saveDowntimeMap["downtimeId"] = downtimeId;
                    context.read<AssetsBloc>().add(
                        SaveAssetsDownTime(saveDowntimeMap: saveDowntimeMap));
                  },
                  textValue: StringConstants.kSave),
            )),
        body: BlocBuilder<AssetsBloc, AssetsState>(builder: (context, state) {
          if (state is AssetsSingleDownTimeFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssetsSingleDownTimeFetched) {
            return const AssetsAddAndEditDowntimeBody();
          } else {
            saveDowntimeMap = {};
            return const AssetsAddAndEditDowntimeBody();
          }
        }));
  }
}
