import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';
import 'package:toolkit/screens/assets/assets_manage_document_filter_screen.dart';

import '../../../blocs/documents/documents_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class AssetsDocumentFilterTypeList extends StatelessWidget {
  static const routeName = 'AssetsDocumentFilterTypeList';
  final String selectedTypeName;
  const AssetsDocumentFilterTypeList(
      {super.key, required this.selectedTypeName});

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
                          itemCount: context
                              .read<DocumentsBloc>()
                              .masterData[0]
                              .length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColor.deepBlue,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(context
                                    .read<DocumentsBloc>()
                                    .masterData[0][index]
                                    .name),
                                value: context
                                    .read<DocumentsBloc>()
                                    .masterData[0][index]
                                    .id
                                    .toString(),
                                groupValue: selectedTypeName,
                                onChanged: (value) {
                                  context.read<DocumentsBloc>().selectedType =
                                      context
                                          .read<DocumentsBloc>()
                                          .masterData[0][index]
                                          .name;
                                  AssetsManageDocumentFilterScreen
                                          .documentFilterMap["type"] =
                                      context
                                          .read<DocumentsBloc>()
                                          .masterData[0][index]
                                          .id
                                          .toString();

                                  context.read<AssetsBloc>().add(
                                      SelectAssetsDocumentTypeFilter(
                                          selectedTypeId: context
                                              .read<DocumentsBloc>()
                                              .masterData[0][index]
                                              .id
                                              .toString(),
                                          selectedTypeName: context
                                              .read<DocumentsBloc>()
                                              .masterData[0][index]
                                              .name));
                                  Navigator.pop(context);
                                });
                          }),
                      const SizedBox(height: xxxSmallerSpacing)
                    ]))));
  }
}
