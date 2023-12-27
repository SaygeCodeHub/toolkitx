import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/documents/documents_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/documents/documents_list_model.dart';
import '../../../widgets/custom_card.dart';
import '../documents_details_screen.dart';

class DocumentsListCard extends StatelessWidget {
  final DocumentsListDatum documentsListData;

  const DocumentsListCard({super.key, required this.documentsListData});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
            onTap: () {
              context.read<DocumentsBloc>().documentId = documentsListData.id;
              Navigator.pushNamed(context, DocumentsDetailsScreen.routeName);
            },
            contentPadding: const EdgeInsets.all(xxTinierSpacing),
            title: Padding(
                padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(documentsListData.name,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(width: tinierSpacing),
                      Text(documentsListData.status,
                          style: Theme.of(context)
                              .textTheme
                              .xxSmall
                              .copyWith(color: AppColor.deepBlue))
                    ])),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(documentsListData.docno,
                    style: Theme.of(context).textTheme.xSmall),
                const SizedBox(height: tinierSpacing),
                Visibility(
                    visible: documentsListData.doctype != null,
                    child: Column(children: [
                      Text(documentsListData.doctype.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(color: AppColor.grey)),
                      const SizedBox(height: tinierSpacing)
                    ])),
                Text(documentsListData.owner,
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(color: AppColor.grey))
              ],
            )));
  }
}
