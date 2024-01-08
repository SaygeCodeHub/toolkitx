import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'widgets/transfer_equipment_popup_menu.dart';

class TransferEquipmentScreen extends StatelessWidget {
  static const routeName = 'TransferEquipmentScreen';

  const TransferEquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kTransfer,
        actions: [TransferEquipmentPopupMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: AppColor.errorRed)),
                child: Padding(
                  padding: const EdgeInsets.all(xxTinierSpacing),
                  child: Text(
                    StringConstants.kPleaseSearchOrScanTheEquipment,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                          color: AppColor.errorRed,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
