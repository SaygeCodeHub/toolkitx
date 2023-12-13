import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../add_assets_document_screen.dart';
import 'add_assets_document_checkbox.dart';

class AssetsAddDocumentListBody extends StatelessWidget {
  final List data;

  const AssetsAddDocumentListBody({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: context.read<AssetsBloc>().hasDocumentReachedMax
            ? data.length
            : data.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < context.read<AssetsBloc>().addDocumentDatum.length) {
            return AddAssetsDocumentCheckbox(
              data: context.read<AssetsBloc>().addDocumentDatum[index],
              selectedCreatedForIdList:
                  AddAssetsDocumentScreen.selectedCreatedForIdList,
              onCreatedForChanged: (List<dynamic> id) {
                AddAssetsDocumentScreen.selectedCreatedForIdList = id;
                AddAssetsDocumentScreen.addDocumentApp['documents'] =
                    AddAssetsDocumentScreen.selectedCreatedForIdList
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", "");
              },
            );
          } else {
            AddAssetsDocumentScreen.pageNo++;
            context.read<AssetsBloc>().add(FetchAddAssetsDocument(
                pageNo: AddAssetsDocumentScreen.pageNo, isFromHome: false));
            return const Center(
                child: Padding(
                    padding:
                        EdgeInsets.all(kCircularProgressIndicatorPadding),
                    child: SizedBox(
                        width: kCircularProgressIndicatorWidth,
                        child: CircularProgressIndicator())));
          }
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }
}
