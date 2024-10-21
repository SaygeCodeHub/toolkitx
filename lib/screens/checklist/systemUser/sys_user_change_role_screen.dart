import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_bloc.dart';
import '../../../blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_event.dart';
import '../../../blocs/checklist/systemUser/changeRole/sys_user_checklist_change_role_states.dart';
import '../../../utils/constants/string_constants.dart';
import 'sys_user_checklist_list_screen.dart';

class ChangeRoleScreen extends StatelessWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CheckListRoleBloc>().add(CheckListFetchRoles(
        roleName: context.read<CheckListRoleBloc>().roleName));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChangeRole),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<CheckListRoleBloc, CheckListRoleStates>(
                listener: (context, state) {
              if (state is CheckListRolesFetched &&
                  state.isRoleSelected == true) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, SystemUserCheckListScreen.routeName,
                    arguments: false);
              }
            }, builder: (context, state) {
              if (state is FetchingCheckListRoles) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CheckListRolesFetched) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: xxTinierSpacing),
                      CustomCard(
                          elevation: kZeroElevation,
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(bottom: tiniestSpacing),
                              shrinkWrap: true,
                              itemCount: state.checkListRolesModel.data!.length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    dense: true,
                                    activeColor: AppColor.deepBlue,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(state.checkListRolesModel
                                        .data![index].groupName
                                        .toString()),
                                    value: state.checkListRolesModel
                                        .data![index].groupName,
                                    groupValue: state.roleName,
                                    onChanged: (value) {
                                      value = state.checkListRolesModel
                                          .data![index].groupName;
                                      context.read<CheckListRoleBloc>().add(
                                          CheckListChangeRole(
                                              roleId: state.checkListRolesModel
                                                  .data![index].groupId
                                                  .toString(),
                                              roleName: state
                                                  .checkListRolesModel
                                                  .data![index]
                                                  .groupName
                                                  .toString(),
                                              checkListRolesModel:
                                                  state.checkListRolesModel,
                                              isRoleSelected: true));
                                    });
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                    thickness: kDividerThickness,
                                    height: kDividerHeight);
                              })),
                      const SizedBox(height: xxLargerSpacing)
                    ]);
              } else if (state is CheckListRolesNotFetched) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context
                              .read<CheckListRoleBloc>()
                              .add(CheckListFetchRoles(roleName: ''));
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            })));
  }
}
