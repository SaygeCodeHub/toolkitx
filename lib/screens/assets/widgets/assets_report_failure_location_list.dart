import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../assets_report_failure_screen.dart';

class AssetsReportFailureLocationList extends StatelessWidget {
  static const routeName = "AssetsReportFailureLocationList";

  const AssetsReportFailureLocationList(
      {super.key, required this.selectLocationName});

  final String selectLocationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: context
                            .read<AssetsBloc>()
                            .assetMasterData[0]
                            .length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(context
                                  .read<AssetsBloc>()
                                  .assetMasterData[0][index]
                                  .name),
                              value: context
                                  .read<AssetsBloc>()
                                  .assetMasterData[0][index]
                                  .id
                                  .toString(),
                              groupValue: selectLocationName,
                              onChanged: (value) {
                                AssetsReportFailureScreen
                                        .assetsReportFailureMap["location"] =
                                    context
                                        .read<AssetsBloc>()
                                        .assetMasterData[0][index]
                                        .id
                                        .toString();
                                context.read<AssetsBloc>().add(
                                    SelectAssetsReportFailureLocation(
                                        selectLocationName: context
                                            .read<AssetsBloc>()
                                            .assetMasterData[0][index]
                                            .id
                                            .toString()));
                                context.read<AssetsBloc>().selectLocationName =
                                    context
                                        .read<AssetsBloc>()
                                        .assetMasterData[0][index]
                                        .name;
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
