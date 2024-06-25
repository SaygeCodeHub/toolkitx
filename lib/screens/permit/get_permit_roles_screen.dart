import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/permit/permit_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class GetPermitRolesScreen extends StatelessWidget {
  static const routeName = 'GetPermitRolesScreen';

  const GetPermitRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const GetPermitRoles());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ChangeRole')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: BlocConsumer<PermitBloc, PermitStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingPermitRoles ||
                  currentState is PermitRolesFetched,
              listener: (context, state) {
                if (state is PermitRoleSelected) {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, PermitListScreen.routeName,
                      arguments: false);
                }
              },
              builder: (context, state) {
                if (state is FetchingPermitRoles) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PermitRolesFetched) {
                  return Builder(builder: (context) {
                    return ListView.builder(
                        itemCount: state.permitRolesModel.data!.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              dense: true,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(state
                                  .permitRolesModel.data![index].groupName
                                  .toString()),
                              value:
                                  state.permitRolesModel.data![index].groupId,
                              groupValue: state.roleId,
                              onChanged: (value) {
                                context
                                    .read<PermitBloc>()
                                    .add(SelectPermitRoleEvent(value!));
                              });
                        });
                  });
                } else {
                  return const SizedBox();
                }
              },
            )));
  }
}
