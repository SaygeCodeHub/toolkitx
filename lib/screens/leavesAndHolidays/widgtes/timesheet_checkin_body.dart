import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';

class TimeSheetCheckInBody extends StatelessWidget {
  const TimeSheetCheckInBody({
    super.key,
    required this.checkInList,
  });

  final List checkInList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: checkInList.length,
      itemBuilder: (context, index) {
        return CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: ListTile(
              leading: CustomCard(
                  child: Padding(
                padding: const EdgeInsets.all(tiniestSpacing),
                child: Text(
                    "${checkInList[index].starttime}-${checkInList[index].endtime}"),
              )),
              title: Padding(
                padding: const EdgeInsets.all(tiniestSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(checkInList[index].workingat,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.deepBlue)),
                    CustomIconButton(icon: Icons.edit, onPressed: () {}),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(tiniestSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${checkInList[index].breakmins} ${StringConstants.kMinsBreak}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomIconButton(icon: Icons.delete, onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: xxTinierSpacing);
      },
    );
  }
}
