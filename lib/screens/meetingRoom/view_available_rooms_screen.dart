import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class ViewAvailableRoomsScreen extends StatelessWidget {
  static const routeName = 'ViewAvailableRoomsScreen';

  const ViewAvailableRoomsScreen({super.key, required this.searchRoomsMap});

  final Map searchRoomsMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('viewRoomAvailable')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: ListView.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return CustomCard();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: xxTinierSpacing);
            }),
      ),
    );
  }
}
