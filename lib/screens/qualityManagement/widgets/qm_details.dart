import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../../utils/database_utils.dart';
import 'qm_details_view_network_image.dart';
import 'qm_map_links_list.dart';

class QualityManagementDetails extends StatelessWidget {
  final QMDetailsData data;
  final int initialIndex;
  final String clientId;

  const QualityManagementDetails(
      {Key? key,
      required this.data,
      required this.initialIndex,
      required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniestSpacing),
            Text(
              DatabaseUtil.getText('Reportedby'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text('${data.companyname} - ${data.createdbyname}'),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('ReportedDate'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.eventdatetime, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('IncidentDetails'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.description, style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('Location'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(data.locationname, style: Theme.of(context).textTheme.small),
            const SizedBox(height: xxTinierSpacing),
            QualityManagementMapLinksList(data: data),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('SeverityImpact'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Text('${data.severityname} - ${data.impactname}',
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
            Text(
              DatabaseUtil.getText('viewimage'),
              style: Theme.of(context).textTheme.medium,
            ),
            const SizedBox(height: xxTinierSpacing),
            Visibility(
                visible: data.files.isNotEmpty,
                child: QualityManagementViewNetworkImage(
                    clientId: clientId, data: data)),
            const SizedBox(height: tinySpacing)
          ],
        ));
  }
}
