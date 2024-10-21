import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/screens/qualityManagement/qm_list_screen.dart';

import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';

class QualityManagementRolesScreen extends StatelessWidget {
  static const routeName = 'QualityManagementRolesScreen';

  const QualityManagementRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(FetchQualityManagementRoles());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ChangeRole')),
      body: BlocConsumer<QualityManagementBloc, QualityManagementStates>(
          listener: (context, state) {
        if (state is QualityManagementRoleChanged) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
              context, QualityManagementListScreen.routeName,
              arguments: false);
        }
      }, builder: (context, state) {
        if (state is FetchingQualityManagementRoles) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QualityManagementRolesFetched) {
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(top: topBottomPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: xxTiniestSpacing),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: xxTiniestSpacing),
                            shrinkWrap: true,
                            itemCount: state
                                .fetchQualityManagementRolesModel.data.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: xxxMediumSpacing,
                                  child: RadioListTile(
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state
                                          .fetchQualityManagementRolesModel
                                          .data[index]
                                          .groupName),
                                      value: state
                                          .fetchQualityManagementRolesModel
                                          .data[index]
                                          .groupId,
                                      groupValue: state.roleId,
                                      onChanged: (value) {
                                        context
                                            .read<QualityManagementBloc>()
                                            .add(SelectQualityManagementRole(
                                                roleId: state
                                                    .fetchQualityManagementRolesModel
                                                    .data[index]
                                                    .groupId));
                                      }));
                            }),
                        const SizedBox(height: xxxSmallerSpacing)
                      ])));
        } else if (state is QualityManagementRolesNotFetched) {
          return GenericReloadButton(
              onPressed: () {
                context
                    .read<QualityManagementBloc>()
                    .add(FetchQualityManagementRoles());
              },
              textValue: StringConstants.kReload);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
