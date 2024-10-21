import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_edit_header_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_approve_pop_up.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_reject_pop_up.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/third_party_approval_pop_up.dart';
import '../../../blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';

class PopUpMenu extends StatelessWidget {
  final List responseIdList;
  final String scheduleId;
  final bool popUpMenuBuilder;

  const PopUpMenu(
      {super.key,
      required this.responseIdList,
      required this.scheduleId,
      required this.popUpMenuBuilder});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CheckListScheduleDatesResponseBloc>().add(
        FetchCheckListPopUpMenu(
            popUpMenuItems: const [], popUpMenuBuilder: popUpMenuBuilder));
    return BlocBuilder<CheckListScheduleDatesResponseBloc,
            CheckListScheduleDatesResponseStates>(
        buildWhen: (previousState, currentState) =>
            currentState is CheckListPopUpMenuItemsFetched,
        builder: (context, state) {
          if (state is CheckListPopUpMenuItemsFetched) {
            return PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                iconSize: kIconSize,
                icon: const Icon(Icons.more_vert_outlined),
                offset: const Offset(0, xxTinierSpacing),
                onSelected: (value) {
                  if (value == DatabaseUtil.getText('approve')) {
                    showDialog(
                        barrierColor: AppColor.transparent,
                        context: context,
                        builder: (context) {
                          return ApprovePopUp(
                              textValue: StringConstants.kApprove,
                              responseIdList: responseIdList);
                        });
                  }
                  if (value == DatabaseUtil.getText('Reject')) {
                    showDialog(
                        barrierColor: AppColor.transparent,
                        context: context,
                        builder: (context) {
                          return RejectPopUp(
                              textValue: StringConstants.kReject,
                              responseIdList: responseIdList);
                        });
                  }
                  if (value == StringConstants.kThirdParty) {
                    showDialog(
                        barrierColor: AppColor.transparent,
                        context: context,
                        builder: (context) {
                          return ThirdPartyApprovePopUp(
                              textValue: StringConstants.kApprove,
                              responseIdList: responseIdList);
                        });
                  }
                  if (value == StringConstants.kEditHeader) {
                    Navigator.pushNamed(context, EditHeaderScreen.routeName);
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  return List.generate(state.popUpMenuItems.length, (index) {
                    return _buildPopupMenuItem(
                        context,
                        state.popUpMenuItems[index],
                        state.popUpMenuItems[index]);
                  });
                });
          } else {
            return const SizedBox();
          }
        });
  }
}
