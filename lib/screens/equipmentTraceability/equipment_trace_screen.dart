import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_list_screen.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/view_my_request_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/equipment_util.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import 'transfer_equipment_screen.dart';

class EquipmentTraceScreen extends StatelessWidget {
  const EquipmentTraceScreen({super.key});
  static const routeName = 'EquipmentTraceScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kTrace),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 16 / 9,
              crossAxisCount: 2,
              crossAxisSpacing: leftRightMargin,
              mainAxisSpacing: leftRightMargin),
          itemCount: equipment.length,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () {
                _navigateToEquipmentModule(
                    equipment[index].equipmentModuleName, context);
              },
              child: CustomCard(
                color: AppColor.blueGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(equipment[index].icon, size: kEquipmentModuleIconSize),
                    const SizedBox(
                      height: xxTinierSpacing,
                    ),
                    Text(
                      equipment[index].equipmentModuleName,
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToEquipmentModule(
      String equipmentModuleName, BuildContext context) {
    switch (equipmentModuleName) {
      case StringConstants.kSearchEquipment:
        Navigator.pushNamed(context, SearchEquipmentListScreen.routeName,
            arguments: true);
        break;
      case StringConstants.kTransferEquipment:
        Navigator.pushNamed(context, TransferEquipmentScreen.routeName);
        break;
      case StringConstants.kViewMyRequest:
        Navigator.pushNamed(context, ViewMyRequestScreen.routeName);
        break;
    }
  }
}
