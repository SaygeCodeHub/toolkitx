import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../widgets/custom_card.dart';

class PermitComments extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitComments({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab6.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      title: Text(permitDetailsModel.data.tab6[index].createdBy,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    permitDetailsModel.data.tab6[index].action),
                                const SizedBox(height: xxTinierSpacing),
                                Text(permitDetailsModel.data.tab6[index].role,
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
