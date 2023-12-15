import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../assets_manage_document_screeen.dart';
import 'assets_manage_document_popup_menu.dart';

class AssetsManageDocumentBody extends StatelessWidget {
  const AssetsManageDocumentBody({
    super.key,
    required this.manageDocumentDatum,
    required this.assetsPopUpMenu,
  });

  final List manageDocumentDatum;
  final List assetsPopUpMenu;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: context.read<AssetsBloc>().hasDocumentReachedMax
            ? manageDocumentDatum.length
            : manageDocumentDatum.length + 1,
        itemBuilder: (context, index) {
          if (index < manageDocumentDatum.length) {
            return CustomCard(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                    child: ListTile(
                        title: Row(children: [
                          Expanded(
                              child: Text(manageDocumentDatum[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black))),
                          SizedBox(
                              width: smallerSpacing,
                              child: AssetsManageDocumentPopUp(
                                popUpMenuItems: assetsPopUpMenu,
                                documentId: manageDocumentDatum[index].docid,
                              ))
                        ]),
                        subtitle: Text(manageDocumentDatum[index].type,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.grey)))));
          } else {
            AssetsManageDocumentScreen.pageNo++;
            context.read<AssetsBloc>().add(FetchAssetsManageDocument(
                pageNo: AssetsManageDocumentScreen.pageNo,
                assetsId: context.read<AssetsBloc>().assetId));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: tinierSpacing);
        });
  }
}