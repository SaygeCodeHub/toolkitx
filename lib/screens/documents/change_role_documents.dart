import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/screens/documents/documents_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class ChangeRoleDocuments extends StatelessWidget {
  static const routeName = 'ChangeRoleDocuments';

  const ChangeRoleDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(GetDocumentRoles());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ChangeRole')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing,
              bottom: xxTinierSpacing),
          child: BlocConsumer<DocumentsBloc, DocumentsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingDocumentRoles ||
                currentState is DocumentRolesFetched,
            listener: (context, state) {
              if (state is DocumentRoleSelected) {
                Navigator.pop(context);
                Navigator.pushNamed(context, DocumentsListScreen.routeName,
                    arguments: false);
              }
            },
            builder: (context, state) {
              if (state is FetchingDocumentRoles) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DocumentRolesFetched) {
                return ListView.builder(
                    itemCount: state.documentRolesModel.data.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                          dense: true,
                          activeColor: AppColor.deepBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(state
                              .documentRolesModel.data[index].groupName
                              .toString()),
                          value: state.documentRolesModel.data[index].groupId,
                          groupValue: state.roleId,
                          onChanged: (value) {
                            context
                                .read<DocumentsBloc>()
                                .add(SelectDocumentRoleEvent(value!));
                          });
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ));
  }
}
