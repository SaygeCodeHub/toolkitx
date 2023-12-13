
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/assets/widgets/assets_document_filter_type_list.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../assets_manage_document_filter_screen.dart';

class AssetsDocumentTypeScreen extends StatelessWidget {
  const AssetsDocumentTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(SelectAssetsDocumentTypeFilter(
        selectedTypeId: AssetsManageDocumentFilterScreen.documentFilterMap['type'] ?? '',
        selectedTypeName: AssetsManageDocumentFilterScreen.documentFilterMap['typeName'] ?? ''));
    return BlocBuilder<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
        currentState is AssetsDocumentTypeFilterSelected,
        builder: (context, state) {
          if (state is AssetsDocumentTypeFilterSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, AssetsDocumentFilterTypeList.routeName,
                        arguments: state.selectedTypeName);
                  },
                  title: Text(DatabaseUtil.getText('type'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle: state.selectedTypeName == ''
                      ? null
                      : Text(
                      state.selectedTypeName),
                  trailing:
                  const Icon(Icons.navigate_next_rounded, size: kIconSize)),
              Visibility(
                  visible: state.selectedTypeId == DatabaseUtil.getText('Other'),
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
                              AssetsManageDocumentFilterScreen.documentFilterMap['type'] =
                              (state.selectedTypeId == 'Other'
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
