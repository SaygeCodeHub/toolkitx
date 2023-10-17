import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/documents/widgets/document_location_filter_list.dart';

import '../../../blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';

class DocumentTypeScreen extends StatelessWidget {
  final Map documentFilterMap;
  final List locationList;
  final bool isFromLikeDoc;

  const DocumentTypeScreen(
      {super.key,
      required this.documentFilterMap,
      required this.locationList,
      required this.isFromLikeDoc});

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(SelectDocumentLocationFilter(
        selectedType: documentFilterMap['type'] ?? ''));
    return BlocBuilder<DocumentsBloc, DocumentsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is DocumentTypeFilterSelected,
        builder: (context, state) {
          if (state is DocumentTypeFilterSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, DocumentLocationFilterList.routeName,
                        arguments: state.selectedType);
                  },
                  title: Text(DatabaseUtil.getText('type'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle: (context.read<DocumentsBloc>().selectedType == '')
                      ? null
                      : (context.read<DocumentsBloc>().linkDocSelectedType ==
                              '')
                          ? null
                          : (isFromLikeDoc)
                              ? Text(context
                                  .read<DocumentsBloc>()
                                  .linkDocSelectedType)
                              : Text(
                                  context.read<DocumentsBloc>().selectedType),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
              Visibility(
                  visible: state.selectedType == DatabaseUtil.getText('Other'),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kOther,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        TextFieldWidget(
                            hintText: DatabaseUtil.getText('Other'),
                            onTextFieldChanged: (String textField) {
                              documentFilterMap['type'] =
                                  (state.selectedType == 'Other'
                                      ? textField
                                      : '');
                            })
                      ]))
            ]);
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
