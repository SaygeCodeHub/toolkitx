import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/equipment_util.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

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
              childAspectRatio: 16 / 7,
              crossAxisCount: 2,
              crossAxisSpacing: leftRightMargin,
              mainAxisSpacing: leftRightMargin),
          itemCount: equipment.length,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () {},
              child: CustomCard(
                color: AppColor.deepBlue,
                child: Center(
                    child: Text(
                  equipment[index].equipmentModuleName,
                  style: Theme.of(context).textTheme.xSmall.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
