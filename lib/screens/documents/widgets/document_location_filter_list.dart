import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/blocs/documents/documents_events.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../document_filter_screen.dart';

class DocumentLocationFilterList extends StatelessWidget {
  static const routeName = 'DocumentLocationFilterList';
  final String selectLocation;

  const DocumentLocationFilterList({super.key, required this.selectLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectType),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            context.read<DocumentsBloc>().masterData[0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(context
                                  .read<DocumentsBloc>()
                                  .masterData[0][index]
                                  .name),
                              value: context
                                  .read<DocumentsBloc>()
                                  .masterData[0][index]
                                  .id
                                  .toString(),
                              groupValue: selectLocation,
                              onChanged: (value) {
                                DocumentFilterScreen.documentFilterMap["type"] =
                                    context
                                        .read<DocumentsBloc>()
                                        .masterData[0][index]
                                        .id
                                        .toString();
                                context
                                        .read<DocumentsBloc>()
                                        .linkDocFilters["type"] =
                                    context
                                        .read<DocumentsBloc>()
                                        .masterData[0][index]
                                        .id
                                        .toString();
                                context.read<DocumentsBloc>().add(
                                    SelectDocumentLocationFilter(
                                        selectedType: context
                                            .read<DocumentsBloc>()
                                            .masterData[0][index]
                                            .id
                                            .toString()));
                                context.read<DocumentsBloc>().selectedType =
                                    context
                                        .read<DocumentsBloc>()
                                        .masterData[0][index]
                                        .name;
                                context
                                        .read<DocumentsBloc>()
                                        .linkDocSelectedType =
                                    context
                                        .read<DocumentsBloc>()
                                        .masterData[0][index]
                                        .name;
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
