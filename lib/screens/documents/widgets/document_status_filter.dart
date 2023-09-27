
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_events.dart';
import '../../../blocs/documents/documents_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/document_status_enum.dart';
import '../../../widgets/custom_choice_chip.dart';

class DocumentStatusFilter extends StatelessWidget {
  const DocumentStatusFilter({super.key, required this.documentFilterMap});
  final Map documentFilterMap;

  @override
  Widget build(BuildContext context) {
    context.read<DocumentsBloc>().add(SelectDocumentStatusFilter(
        selectedIndex: documentFilterMap["status"] ?? ''));
    return Wrap(spacing: kFilterTags, children: [
      for (int i = 0; i < DocumentStatusEnum.values.length; i++)
        BlocBuilder<DocumentsBloc, DocumentsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is DocumentStatusFilterSelected,
          builder: (context, state) {
            if (state is DocumentStatusFilterSelected) {
              String id = DocumentStatusEnum.values[i].value.toString();
              documentFilterMap["status"] = state.selectedIndex;
              return CustomChoiceChip(
                  label: DocumentStatusEnum.values[i].name,
                  selected: (documentFilterMap["status"] == null)
                      ? false
                      : state.selectedIndex == id,
                  onSelected: (bool value) {
                    context
                        .read<DocumentsBloc>()
                        .add(SelectDocumentStatusFilter(selectedIndex: id));
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        )
    ]);
  }
}
