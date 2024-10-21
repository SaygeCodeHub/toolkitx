import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import 'incident_list_screen.dart';

class IncidentChangeRoleScreen extends StatelessWidget {
  static const routeName = 'IncidentChangeRoleScreen';

  const IncidentChangeRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<IncidentLisAndFilterBloc>().add(const IncidentFetchRoles());
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ChangeRole')),
      body: BlocConsumer<IncidentLisAndFilterBloc, IncidentListAndFilterStates>(
          listener: (context, state) {
        if (state is IncidentRoleChanged) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, IncidentListScreen.routeName,
              arguments: false);
        }
      }, builder: (context, state) {
        if (state is FetchingIncidentRoles) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is IncidentRolesFetched) {
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
                            itemCount:
                                state.incidentFetchRolesModel.data!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: xxxMediumSpacing,
                                  child: RadioListTile(
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state.incidentFetchRolesModel
                                          .data![index].groupName),
                                      value: state.incidentFetchRolesModel
                                          .data![index].groupId,
                                      groupValue: state.roleId,
                                      onChanged: (value) {
                                        context
                                            .read<IncidentLisAndFilterBloc>()
                                            .add(IncidentChangeRole(
                                                roleId: state
                                                    .incidentFetchRolesModel
                                                    .data![index]
                                                    .groupId));
                                      }));
                            }),
                        const SizedBox(height: xxxSmallerSpacing)
                      ])));
        } else if (state is IncidentRolesNotFetched) {
          return GenericReloadButton(
              onPressed: () {
                context
                    .read<IncidentLisAndFilterBloc>()
                    .add(const IncidentFetchRoles());
              },
              textValue: StringConstants.kReload);
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
