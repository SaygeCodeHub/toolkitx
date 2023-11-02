import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/documents/documents_bloc.dart';
import '../../blocs/documents/documents_events.dart';
import '../../blocs/documents/documents_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'link_documents_filter_screen.dart';
import 'widgets/link_documents_body.dart';

class LinkDocumentScreen extends StatelessWidget {
  static const routeName = 'LinkDocumentScreen';
  static int page = 1;
  static String linkedDocuments = '';

  const LinkDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    linkedDocuments = '';
    page = 1;
    context.read<DocumentsBloc>().documentsToLinkList = [];
    context.read<DocumentsBloc>().linkDocFilters = {};
    context.read<DocumentsBloc>().linkDocSelectedType = '';
    context.read<DocumentsBloc>().add(GetDocumentsToLink(page: page));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('AssignDocuments')),
        bottomNavigationBar: BottomAppBar(
            child: PrimaryButton(
                onPressed: () {
                  context.read<DocumentsBloc>().add(
                      SaveLinkedDocuments(linkedDocuments: linkedDocuments));
                },
                textValue: DatabaseUtil.getText('buttonDone'))),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin, right: leftRightMargin),
            child: Column(children: [
              BlocConsumer<DocumentsBloc, DocumentsStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is DocumentsToLinkFetched,
                  listener: (context, state) {
                    if (state is SavingLikedDocuments) {
                      ProgressBar.show(context);
                    }
                    if (state is LikedDocumentsSaved) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      context
                          .read<DocumentsBloc>()
                          .add(const GetDocumentsDetails());
                    }
                    if (state is SaveLikedDocumentsError) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.message, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is DocumentsToLinkFetched) {
                      return CustomIconButtonRow(
                          secondaryVisible: false,
                          clearVisible: context
                              .read<DocumentsBloc>()
                              .linkDocFilters
                              .isNotEmpty,
                          primaryOnPress: () {
                            Navigator.pushNamed(
                                context, LinkDocumentsFilterScreen.routeName);
                          },
                          secondaryOnPress: () {},
                          clearOnPress: () {
                            page = 1;
                            context.read<DocumentsBloc>().linkDocFilters = {};
                            context.read<DocumentsBloc>().documentsToLinkList =
                                [];
                            context.read<DocumentsBloc>().linkDocSelectedType =
                                '';
                            context
                                .read<DocumentsBloc>()
                                .add(const GetDocumentsToLink(page: 1));
                          });
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const LinkDocumentsBody()
            ])));
  }
}
