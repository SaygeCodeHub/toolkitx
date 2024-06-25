import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/documents/documents_bloc.dart';
import '../../../blocs/documents/documents_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_to_link_model.dart';
import '../link_document_screen.dart';

class LinkDocumentMultiSelect extends StatefulWidget {
  final List<DocumentsToLinkData> linkDocumentsList;

  const LinkDocumentMultiSelect({super.key, required this.linkDocumentsList});

  @override
  State<LinkDocumentMultiSelect> createState() =>
      _LinkDocumentMultiSelectState();
}

class _LinkDocumentMultiSelectState extends State<LinkDocumentMultiSelect> {
  List selectedDocuments = [];

  multiSelect(item) {
    setState(() {
      if (selectedDocuments.contains(item)) {
        selectedDocuments.remove(item);
      } else {
        selectedDocuments.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                context.read<DocumentsBloc>().linkDocumentsReachedMax == true
                    ? widget.linkDocumentsList.length
                    : widget.linkDocumentsList.length + 1,
            itemBuilder: (context, index) {
              if (index < widget.linkDocumentsList.length) {
                return CheckboxListTile(
                    checkColor: AppColor.white,
                    activeColor: AppColor.deepBlue,
                    contentPadding: EdgeInsets.zero,
                    value: selectedDocuments
                        .contains(widget.linkDocumentsList[index].id),
                    title: Text(widget.linkDocumentsList[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(widget.linkDocumentsList[index].doctype),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (isChecked) {
                      multiSelect(widget.linkDocumentsList[index].id);
                      LinkDocumentScreen.linkedDocuments = selectedDocuments
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '');
                    });
              } else if (!context.read<DocumentsBloc>().docListReachedMax) {
                LinkDocumentScreen.page++;
                context
                    .read<DocumentsBloc>()
                    .add((GetDocumentsToLink(page: LinkDocumentScreen.page)));
                return const Center(
                    child: Padding(
                        padding:
                            EdgeInsets.all(kCircularProgressIndicatorPadding),
                        child: SizedBox(
                            width: kCircularProgressIndicatorWidth,
                            child: CircularProgressIndicator())));
              } else {
                return const SizedBox.shrink();
              }
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: xxTinySpacing);
            }));
  }
}
