import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/incident_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../configs/app_color.dart';
import '../../../utils/database_utils.dart';
import 'incident_details_view_network_image.dart';

class IncidentDetails extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;
  final int initialIndex;

  const IncidentDetails(
      {Key? key,
      required this.incidentDetailsModel,
      required this.clientId,
      required this.initialIndex})
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
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(
                '${incidentDetailsModel.data!.companyname} - ${incidentDetailsModel.data!.createdbyname}'),
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing),
            Text(
              StringConstants.kSummaryOfIncident,
              style: Theme.of(context)
                  .textTheme
                  .medium
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: xxTinierSpacing),
            Text(incidentDetailsModel.data!.description,
                style: Theme.of(context).textTheme.small),
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing),
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
            const SizedBox(height: tinySpacing)
          ],
        ));
  }
}
