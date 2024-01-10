import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/view_my_request_popup_menu.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../configs/app_color.dart';

class ViewMyRequestScreen extends StatelessWidget {
  static const routeName = "ViewMyRequestScreen";
  const ViewMyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kViewMyRequest),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: ListView.separated(
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                  title: Text('Title',
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.black)),
                  subtitle: Text('1231',
                      style: Theme.of(context).textTheme.xSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey)),
                  trailing: const ViewMyRequestPopUp(),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinierSpacing);
            }),
      ),
    );
  }
}
