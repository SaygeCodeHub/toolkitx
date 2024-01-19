import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/leavesAndHolidays/leaves_and_holidays_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import '../../../blocs/leavesAndHolidays/leaves_and_holidays_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';

class TimeSheetCheckInBody extends StatelessWidget {
  const TimeSheetCheckInBody(
      {super.key, required this.checkInList, required this.timeSheetMap});

  final List checkInList;
  final Map timeSheetMap;

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
                    Visibility(
                        visible: timeSheetMap['status'] == 0,
                        child: CustomIconButton(
                            icon: Icons.edit, onPressed: () {})),
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
                    Visibility(
                        visible: timeSheetMap['status'] == 0,
                        child: CustomIconButton(
                            icon: Icons.delete,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AndroidPopUp(
                                      titleValue:
                                          StringConstants.kPleaseConfirm,
                                      contentValue: StringConstants
                                          .kDoYouWantToDeleteThisEntry,
                                      onPrimaryButton: () {
                                        String timeId = checkInList[index].id;
                                        context
                                            .read<LeavesAndHolidaysBloc>()
                                            .add(DeleteTimeSheet(
                                                timeId: timeId));
                                      }));
                            }))
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
