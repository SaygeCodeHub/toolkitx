import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/systemUser/sys_user_checklist_model.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../widgets/custom_tag_container.dart';
import '../sys_user_schedule_dates_screen.dart';

class SystemUserListCard extends StatelessWidget {
  final GetChecklistData checkListDatum;

  const SystemUserListCard({super.key, required this.checkListDatum});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
            contentPadding: const EdgeInsets.all(tinierSpacing),
            title: Padding(
                padding: const EdgeInsets.only(top: tinierSpacing),
                child: Text(checkListDatum.name,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.bold, color: AppColor.black))),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: tinierSpacing),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${checkListDatum.categoryname} -- ${checkListDatum.subcategoryname}',
                      ),
                      const SizedBox(height: tinierSpacing),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: checkListDatum.responsecount != 0,
                                child: const CustomTagContainer(
                                    color: AppColor.lightGreen,
                                    textValue: StringConstants.kResponded)),
                            const SizedBox(width: tiniestSpacing),
                            Visibility(
                                visible:
                                    checkListDatum.approvalpendingcount != 0,
                                child: const Icon(Icons.question_mark_outlined,
                                    color: AppColor.errorRed, size: kIconSize))
                          ])
                    ])),
            onTap: () {
              Navigator.pushNamed(
                  context, SystemUserScheduleDatesScreen.routeName,
                  arguments: checkListDatum.id);
            }));
  }
}
