import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';

import '../../../configs/app_color.dart';
import '../../../utils/database_utils.dart';
import 'incident_details_view_network_image.dart';
import 'incident_map_links_list.dart';

class IncidentDetails extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;

  const IncidentDetails(
      {Key? key, required this.incidentDetailsModel, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tiniest),
            Text(
              DatabaseUtil.getText('Reportedby'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(
                '${incidentDetailsModel.data!.companyname} - ${incidentDetailsModel.data!.createdbyname}'),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('ReportedDate'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.eventdatetime,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Category'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.categorynames,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('IncidentDetails'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.description,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Location'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.locationname,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: xxTinierSpacing),
            IncidentMapLinksList(incidentDetailsModel: incidentDetailsModel),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('Reportedauthority'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.responsiblePerson,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('ReportedDate'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.reporteddatetime,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tiny),
            Text(
              DatabaseUtil.getText('viewimage'),
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Visibility(
              visible: incidentDetailsModel.data!.files.isNotEmpty,
              child: IncidentDetailsViewNetworkImage(
                  incidentDetailsModel: incidentDetailsModel,
                  clientId: clientId),
            ),
            const SizedBox(height: tiny)
          ],
        ));
  }
}
