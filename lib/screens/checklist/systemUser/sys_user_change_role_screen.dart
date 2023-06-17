import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../blocs/checklist/systemUser/changeRole/sys_user_change_role_event.dart';

class ChangeRoleScreen extends StatelessWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: StringConstants.kChangeRole,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<CheckListRoleBloc, CheckListRoleStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is RolesFetched,
                listenWhen: (previousState, currentState) =>
                    currentState is RolesFetched,
                listener: (context, state) {
                  if (state is RolesFetched) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is RolesFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: xxTinierSpacing),
                          CustomCard(
                              elevation: kZeroElevation,
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.only(bottom: tiniest),
                                  shrinkWrap: true,
                                  itemCount:
                                      state.checkListRolesModel.data!.length,
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
                                          context
                                              .read<CheckListRoleBloc>()
                                              .add(ChangeRole(
                                                roleId: state
                                                    .checkListRolesModel
                                                    .data![index]
                                                    .groupId
                                                    .toString(),
                                                roleName: state
                                                    .checkListRolesModel
                                                    .data![index]
                                                    .groupName
                                                    .toString(),
                                                checkListRolesModel:
                                                    state.checkListRolesModel,
                                              ));
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                        thickness: kDividerThickness,
                                        height: kDividerHeight);
                                  })),
                          const SizedBox(height: xxLargerSpacing)
                        ]);
                  } else if (state is RolesNotFetched) {
                    return GenericReloadButton(
                        onPressed: () {
                          context
                              .read<CheckListRoleBloc>()
                              .add(FetchRoles(roleName: ''));
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
