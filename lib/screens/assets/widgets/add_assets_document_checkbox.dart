import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/fetch_add_assets_document_model.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';

typedef CreatedForListCallBack = Function(List id);

class AddAssetsDocumentCheckbox extends StatelessWidget {
  const AddAssetsDocumentCheckbox(
      {super.key,
      required this.data,
      required this.selectedCreatedForIdList,
      required this.onCreatedForChanged});

  final List selectedCreatedForIdList;
  final AddDocumentDatum data;
  final CreatedForListCallBack onCreatedForChanged;

  void _checkboxChange(isSelected, documentId) {
    if (isSelected) {
      selectedCreatedForIdList.add(documentId);
      onCreatedForChanged(selectedCreatedForIdList);
    } else {
      onCreatedForChanged(selectedCreatedForIdList);
      selectedCreatedForIdList.remove(documentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    context
        .read<AssetsBloc>()
        .add(SelectAssetsDocument(documentId: '', isChecked: isChecked));
    return BlocBuilder<AssetsBloc, AssetsState>(
      buildWhen: (previousState, currentState) =>
          currentState is AssetsDocumentSelected,
      builder: (context, state) {
        if (state is AssetsDocumentSelected) {
          return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: AppColor.deepBlue,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(data.docname,
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w400, color: AppColor.black)),
              subtitle: Text(data.doctypename,
                  style: Theme.of(context).textTheme.xxSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      )),
              value: selectedCreatedForIdList.contains(data.docid),
              onChanged: (isChecked) {
                _checkboxChange(isChecked, data.docid);
                context.read<AssetsBloc>().add(SelectAssetsDocument(
                    documentId: data.docid, isChecked: isChecked!));
              });
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
