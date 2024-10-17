import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../di/app_module.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../utils/global.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_snackbar.dart';
import 'workorder_view_document.dart';

class WorkOrderTabThreeDocumentTab extends StatelessWidget {
  final WorkOrderDetailsData data;
  final String clientId;

  const WorkOrderTabThreeDocumentTab(
      {super.key, required this.data, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.documents.isNotEmpty,
      replacement: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
        child: Center(
            child: Text(StringConstants.kNoDocuments,
                style: Theme.of(context).textTheme.medium)),
      ),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.documents.length,
          itemBuilder: (context, index) {
            String files = data.documents[index].files;
            return CustomCard(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(data.documents[index].name,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                        const Spacer(),
                        if (isNetworkEstablished &&
                            data.documents[index].files.isNotEmpty)
                          CustomIconButton(
                              icon: Icons.attach_file,
                              onPressed: () {
                                List file = files.split(',').toList();
                                for (int i = 0; i < file.length; i++) {
                                  fileDownload(file[i], context);
                                }
                              }),
                        if (isNetworkEstablished)
                          const SizedBox(width: tiniestSpacing),
                        if (isNetworkEstablished)
                          CustomIconButton(
                              icon: Icons.delete,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AndroidPopUp(
                                          titleValue: DatabaseUtil.getText(
                                              'DeleteRecord'),
                                          contentValue: '',
                                          onPrimaryButton: () {
                                            context
                                                .read<WorkOrderTabDetailsBloc>()
                                                .add(WorkOrderDeleteDocument(
                                                    docId: data
                                                        .documents[index].id));
                                            Navigator.pop(context);
                                          });
                                    });
                              },
                              size: kEditAndDeleteIconTogether)
                      ],
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: tinierSpacing),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(data.documents[index].type),
                              const SizedBox(height: tinierSpacing),
                              Visibility(
                                  visible: data.documents[index].files != '',
                                  child: WorkOrderViewDocument(
                                      documents: files, clientId: clientId)),
                            ]))));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
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

        String localPath = await downloadImage(finalUrl, filename, context);
        File file = File(localPath);
        if (await file.exists()) {
          if (context.mounted) {
            showCustomSnackBar(context, 'File downloaded successfully', '');
          }
        } else {
          if (context.mounted) {
            showCustomSnackBar(
                context, 'File not found in local directory', '');
          }
        }
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
