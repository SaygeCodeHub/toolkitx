import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/modules_model.dart';
import 'package:toolkit/screens/workorder/workorder_list_screen.dart';
import 'package:toolkit/utils/modules_util.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../permit/permit_list_screen.dart';

class OffLineModules extends StatefulWidget {
  const OffLineModules({super.key});

  @override
  State<OffLineModules> createState() => _OffLineModulesState();
}

class _OffLineModulesState extends State<OffLineModules> {
  List<ModulesModel> modules = [];

  @override
  void initState() {
    var moduleList = ModulesUtil.listModulesMode
        .where((element) => element.offLineSupport == true);
    modules = moduleList.toList();
    super.initState();
  }

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
          itemCount: modules.length,
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
                                  child: Image.asset(modules[index].moduleImage,
                                      height: kModuleIconSize,
                                      width: kModuleIconSize))),
                          const SizedBox(height: xxTinierSpacing),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: xxTiniestSpacing,
                                  right: xxTiniestSpacing),
                              child: Text(
                                  DatabaseUtil.getText(
                                      modules[index].moduleName),
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
      case 1:
        Navigator.pushNamed(context, WorkOrderListScreen.routeName,
            arguments: true);
        break;
    }
  }
}
