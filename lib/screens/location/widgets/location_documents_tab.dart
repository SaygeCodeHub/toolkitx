import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import 'view_location_documents_images.dart';

class LocationDocumentsTab extends StatelessWidget {
  final LocationDetailsData data;
  final int selectedTabIndex;
  final String clientId;

  const LocationDocumentsTab(
      {super.key,
      required this.data,
      required this.selectedTabIndex,
      required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.locdocs.isNotEmpty,
      replacement: Center(
          child: Text(StringConstants.kNoDocuments,
              style: Theme.of(context).textTheme.medium)),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.locdocs.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(xxTinierSpacing),
                    title: Text(data.locdocs[index].name,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600)),
                    subtitle: Visibility(
                      visible: data.locdocs[index].filename != '',
                      child: ViewLocationDocumentsImages(
                          fileName: data.locdocs[index].filename,
                          clientId: clientId),
                    )));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
