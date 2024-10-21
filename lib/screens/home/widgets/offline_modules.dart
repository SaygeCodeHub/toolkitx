import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../utils/modules_util.dart';
import '../../permit/permit_list_screen.dart';

class OffLineModules extends StatelessWidget {
  const OffLineModules({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: xxLargerSpacing,
          color: AppColor.errorRed,
          child: Center(
              child: Text(StringConstants.kNoInternetMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(color: AppColor.white)))),
      const SizedBox(height: tinierSpacing),
      GridView.builder(
          primary: false,
          itemCount: ModulesUtil.listModulesMode
              .where((element) => element.offLineSupport == true)
              .length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: tinierSpacing,
              mainAxisSpacing: tinierSpacing),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                borderRadius: BorderRadius.circular(kCardRadius),
                onTap: () => navigateToModule(index, context),
                child: Card(
                    color: AppColor.transparent,
                    elevation: kZeroElevation,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              margin: const EdgeInsets.all(kModuleCardMargin),
                              color: AppColor.lightestBlue,
                              shadowColor: AppColor.ghostWhite,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.all(kModuleImagePadding),
                                  child: Image.asset(
                                      ModulesUtil
                                          .listModulesMode[ModulesUtil
                                              .listModulesMode
                                              .indexWhere((element) =>
                                                  element.offLineSupport ==
                                                  true)]
                                          .moduleImage,
                                      height: kModuleIconSize,
                                      width: kModuleIconSize))),
                          const SizedBox(height: xxTinierSpacing),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: xxTiniestSpacing,
                                  right: xxTiniestSpacing),
                              child: Text(
                                  DatabaseUtil.getText(ModulesUtil
                                      .listModulesMode[ModulesUtil
                                          .listModulesMode
                                          .indexWhere((element) =>
                                              element.offLineSupport == true)]
                                      .moduleName),
                                  textAlign: TextAlign.center))
                        ])));
          })
    ]);
  }

  navigateToModule(index, context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, PermitListScreen.routeName,
            arguments: true);
        break;
    }
  }
}
