import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/todo/fetch_todo_document_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/todo_view_document_util.dart';

class ToDoViewDocument extends StatelessWidget {
  final ToDoDocumentDetailsDatum documentDetailsDatum;
  final Map todoMap;

  const ToDoViewDocument(
      {Key? key, required this.documentDetailsDatum, required this.todoMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 200 / 350,
            crossAxisCount: 4,
            crossAxisSpacing: tinierSpacing,
            mainAxisSpacing: tinierSpacing),
        itemCount:
            ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)
                .length,
        itemBuilder: (context, index) {
          return InkWell(
              splashColor: AppColor.transparent,
              highlightColor: AppColor.transparent,
              onTap: () {
                launchUrlString(
                    '${ApiConstants.viewDocBaseUrl}${ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(todoMap['clientId'])}',
                    mode: LaunchMode.inAppWebView);
              },
              child: CachedNetworkImage(
                  height: kCachedNetworkImageHeight,
                  imageUrl:
                      '${ApiConstants.viewDocBaseUrl}${ToDoViewDocumentUtil.viewImageList(documentDetailsDatum.files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(todoMap['clientId'])}',
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: AppColor.white,
                      child: Container(
                          height: kNetworkImageContainerTogether,
                          width: kNetworkImageContainerTogether,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius:
                                  BorderRadius.circular(kCardRadius)))),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error_outline_sharp, size: kIconSize)));
        });
  }
}
