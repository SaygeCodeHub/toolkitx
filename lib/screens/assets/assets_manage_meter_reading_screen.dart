import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/primary_button.dart';
import 'widgets/assets_manage_meter_reading_body.dart';

class AssetsManageMeterReadingScreen extends StatelessWidget {
  static const routeName = "AssetsManageMeterReadingScreen";
  static Map meterReadingMap = {};

  const AssetsManageMeterReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(FetchAssetsMaster());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kManageMeterReading),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(tinierSpacing),
            child: BlocListener<AssetsBloc, AssetsState>(
                listener: (context, state) {
                  if (state is AssetsMeterReadingSaving) {
                    ProgressBar.show(context);
                  } else if (state is AssetsMeterReadingSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, "Meter Reading Saved", "");
                    context.read<AssetsBloc>().add(FetchAssetsDetails(
                        assetId: context.read<AssetsBloc>().assetId,
                        assetTabIndex: 0));
                    Navigator.pop(context);
                  } else if (state is AssetsMeterReadingNotSaved) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, "");
                  }
                },
                child: PrimaryButton(
                    onPressed: () {
                      context.read<AssetsBloc>().add(SaveAssetsMeterReading(
                          assetsMeterReadingMap: meterReadingMap));
                    },
                    textValue: StringConstants.kSave))),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocBuilder<AssetsBloc, AssetsState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AssetsMasterFetching ||
                    currentState is AssetsMasterFetched,
                builder: (context, state) {
                  if (state is AssetsMasterFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetsMasterFetched) {
                    return AssetsManageMeterReadingBody(
                        meterReadingMap: meterReadingMap,
                        data: state.fetchAssetsMasterModel.data);
                  } else if (state is AssetsMasterError) {
                    return const Text(StringConstants.kSomethingWentWrong);
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
