import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dateFormat/date_format_bloc.dart';
import '../../../blocs/dateFormat/date_format_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/date_enum.dart';
import '../../../widgets/custom_card.dart';

class SelectDateFormatBody extends StatelessWidget {
  final String dateFormatString;
  final bool isFromProfile;

  const SelectDateFormatBody(
      {Key? key, required this.dateFormatString, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        elevation: kZeroElevation,
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: xxTinierSpacing),
            shrinkWrap: true,
            itemCount: CustomDateFormat.values.length,
            itemBuilder: (context, index) {
              return SizedBox(
                  height: xxxMediumSpacing,
                  child: RadioListTile(
                      dense: true,
                      activeColor: AppColor.deepBlue,
                      title: Text(
                          CustomDateFormat.values.elementAt(index).dateFormat),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value:
                          CustomDateFormat.values.elementAt(index).dateFormat,
                      groupValue: dateFormatString,
                      onChanged: (value) {
                        value =
                            CustomDateFormat.values.elementAt(index).dateFormat;
                        context.read<DateFormatBloc>().add(SetDateFormat(
                            saveDateFormatValue:
                                CustomDateFormat.values.elementAt(index).value,
                            saveDateFormatString: value,
                            isFromProfile: isFromProfile));
                      }));
            },
            separatorBuilder: (context, index) {
              return const Divider(
                  thickness: kDividerThickness, height: kDividerHeight);
            }));
  }
}
