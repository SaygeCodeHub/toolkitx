import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';

class LotoTabSixScreen extends StatelessWidget {
  const LotoTabSixScreen(
      {super.key,
      required this.fetchLotoDetailsModel,
      required this.lotoTabIndex});

  final FetchLotoDetailsModel fetchLotoDetailsModel;
  final int lotoTabIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: fetchLotoDetailsModel.data.workforce.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: ListTile(
                    title: Text(
                        "${fetchLotoDetailsModel.data.workforce[index].name} (${fetchLotoDetailsModel.data.workforce[index].jobTitle})",
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w400)),
                    subtitle: Text(
                        "${StringConstants.kAssignedFor}${fetchLotoDetailsModel.data.workforce[index].applyfor}",
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.grey)),
                    trailing: Visibility(
                      visible: fetchLotoDetailsModel
                              .data.workforce[index].candelete ==
                          '1',
                      child: CustomIconButton(
                          icon: Icons.delete,
                          onPressed: () {
                            Map deleteWorkforceMap = {
                              "lotoworkforceid": fetchLotoDetailsModel
                                  .data.workforce[index].workforceid,
                              "type": fetchLotoDetailsModel
                                  .data.workforce[index].type,
                            };
                            showDialog(
                                context: context,
                                builder: (context) => AndroidPopUp(
                                    titleValue: 'Delete Workforce',
                                    contentValue: DatabaseUtil.getText(
                                        'DeleteConfirmationImage'),
                                    onPrimaryButton: () {
                                      Navigator.pop(context);
                                      context.read<LotoDetailsBloc>().add(
                                          DeleteLotoWorkforce(
                                              deleteWorkforceMap:
                                                  deleteWorkforceMap));
                                    }));
                          },
                          size: kDeleteIconSize),
                    )));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
