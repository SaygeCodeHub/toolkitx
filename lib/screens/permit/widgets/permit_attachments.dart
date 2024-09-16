import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../di/app_module.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/global.dart';
import '../../../utils/incident_view_image_util.dart';
import '../../../widgets/custom_card.dart';
import '../../chat/file_viewer.dart';
import '../../chat/widgets/document_viewer_screen.dart';
import '../../chat/widgets/view_attached_image_widget.dart';

class PermitAttachments extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;
  final String clientId;
  final String userType;

  const PermitAttachments(
      {super.key,
      required this.permitDetailsModel,
      required this.clientId,
      required this.userType});

  @override
  Widget build(BuildContext context) {
    final FileViewer fileViewer = FileViewer();
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab5.length,
        itemBuilder: (context, index) {
          String files = permitDetailsModel.data.tab5[index].files;
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      title: Text(permitDetailsModel.data.tab5[index].name,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(permitDetailsModel.data.tab5[index].type),
                                const SizedBox(height: xxTinierSpacing),
                                ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        ViewImageUtil.viewImageList(files)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          splashColor: AppColor.transparent,
                                          highlightColor: AppColor.transparent,
                                          onTap: () async {
                                            if (isNetworkEstablished) {
                                              launchUrlString(
                                                  '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            } else {
                                              String filename =
                                                  ViewImageUtil.viewImageList(
                                                      files)[index];
                                              Directory directory =
                                                  await getApplicationCacheDirectory();
                                              String path = directory.path;
                                              String filePath =
                                                  '$path/$filename';
                                              if (filename
                                                      .toLowerCase()
                                                      .endsWith('.png') ||
                                                  filename
                                                      .toLowerCase()
                                                      .endsWith('.jpg') ||
                                                  filename
                                                      .toLowerCase()
                                                      .endsWith('.jpeg') ||
                                                  filename
                                                      .toLowerCase()
                                                      .endsWith('.bmp') ||
                                                  filename
                                                      .toLowerCase()
                                                      .endsWith('.gif')) {
                                                Navigator.pushNamed(
                                                    context,
                                                    ViewAttachedImageWidget
                                                        .routeName,
                                                    arguments: filePath);
                                              } else if (filename
                                                  .toLowerCase()
                                                  .endsWith('.pdf')) {
                                                OpenFile.open(filename);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             DocumentViewerScreen(
                                                //                 documentPath:
                                                //                     filePath)));
                                              } else {
                                                await fileViewer.viewFile(
                                                    context, filePath);
                                              }
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: xxxTinierSpacing),
                                            child: Text(
                                                ViewImageUtil.viewImageList(
                                                    files)[index],
                                                style: const TextStyle(
                                                    color: AppColor.deepBlue)),
                                          ));
                                    }),
                                const SizedBox(height: xxTiniestSpacing)
                              ])),
                      trailing: (isNetworkEstablished && userType == '1')
                          ? InkWell(
                              onTap: () {
                                List file = files.split(',').toList();
                                for (int i = 0; i < file.length; i++) {
                                  fileDownload(file[i], context);
                                }
                              },
                              child: const Icon(Icons.attach_file,
                                  size: kIconSize))
                          : null)));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }

  Future<String> downloadImage(
      String url, String filename, BuildContext context) async {
    Directory directory = await getApplicationCacheDirectory();
    String path = directory.path;
    String filePath = '$path/$filename';
    Dio dio = Dio();

    try {
      await dio.download(url, filePath, onReceiveProgress: (received, total) {
        if (total != -1) {
        } else {}
      });
    } catch (e) {
      rethrow;
    }
    return filePath;
  }

  Future<void> fileDownload(String filename, BuildContext context) async {
    final CustomerCache customerCache = getIt<CustomerCache>();
    String? hashCode = await customerCache.getHashCode(CacheKeys.hashcode);
    String url =
        '${ApiConstants.baseUrl}${ApiConstants.chatDocBaseUrl}$filename&hashcode=$hashCode';
    try {
      final Dio dio = Dio();

      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        dynamic messageValue = jsonResponse['Message'];
        if (messageValue is String) {
          String downloadUrl = messageValue;
          String finalUrl = '${ApiConstants.baseDocUrl}$downloadUrl';
          showCustomSnackBar(context, 'File downloaded successfully', '');
          await downloadImage(finalUrl, filename, context);
        } else {
          throw Exception('Invalid message value: $messageValue');
        }
      } else {
        throw Exception('Failed to fetch download URL');
      }
    } catch (e) {
      rethrow;
    }
  }
}
