import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/permit_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';

class PermitSwitchingScheduleTab extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitSwitchingScheduleTab(
      {super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab7.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      onTap: () {},
                      title: Text(permitDetailsModel.data.tab7[index].number,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      trailing: PopupMenuButton(
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: StringConstants.kMarkAsComplete,
                              child: Text(StringConstants.kMarkAsComplete,
                                  style: Theme.of(context).textTheme.xxSmall),
                            ),
                            PopupMenuItem(
                              value: StringConstants.kGeneratePdf,
                              child: Text(StringConstants.kGeneratePdf,
                                  style: Theme.of(context).textTheme.xxSmall),
                            ),
                          ];
                        },
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(permitDetailsModel.data.tab7[index].title),
                                const SizedBox(height: xxTinierSpacing),
                                Text(permitDetailsModel.data.tab7[index].status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xxSmall
                                        .copyWith(color: AppColor.deepBlue)),
                                const SizedBox(height: xxTiniestSpacing)
                              ])))));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
