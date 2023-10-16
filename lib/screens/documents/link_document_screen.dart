import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'widgets/link_documents_body.dart';

class LinkDocumentScreen extends StatelessWidget {
  static const routeName = 'LinkDocumentScreen';
  static int page = 1;

  const LinkDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(GetDocumentsToLink(page: page));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('AssignDocuments')),
        bottomNavigationBar: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {},
                textValue: DatabaseUtil.getText('buttonDone'))),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child: Column(children: [
              BlocBuilder<DocumentsBloc, DocumentsStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is DocumentsToLinkFetched,
                  builder: (context, state) {
                    if (state is DocumentsToLinkFetched) {
                      return CustomIconButtonRow(
                          secondaryVisible: false,
                          clearVisible: context
                              .read<DocumentsBloc>()
                              .linkDocFilters
                              .isNotEmpty,
                          primaryOnPress: () {},
                          secondaryOnPress: () {},
                          clearOnPress: () {
                            context.read<DocumentsBloc>().linkDocFilters = {};
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const LinkDocumentsBody()
            ])));
  }
}
