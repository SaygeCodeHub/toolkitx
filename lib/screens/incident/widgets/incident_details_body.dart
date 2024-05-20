import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/incident_util.dart';
import '../../../widgets/custom_tabbar_view.dart';
import '../../../widgets/status_tag.dart';
import 'incident_custom_field_info.dart';
import 'incident_custom_timeline.dart';
import 'incident_details.dart';
import 'incident_details_comment.dart';
import 'incident_injured_person_tab.dart';
import 'incident_link_permit_list.dart';

class IncidentDetailsBody extends StatelessWidget {
  final String incidentId;
  final IncidentDetailsModel incidentDetailsModel;
  final String clientId;
  static String refNo = '';

  const IncidentDetailsBody(
      {super.key,
      required this.incidentId,
      required this.incidentDetailsModel,
      required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(children: [
          Card(
              color: AppColor.white,
              elevation: kCardElevation,
              child: ListTile(
                  title: Padding(
                      padding: const EdgeInsets.only(top: xxTinierSpacing),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                refNo == ''
                                    ? '#RI${incidentDetailsModel.data!.id}'
                                    : refNo,
                                style: Theme.of(context).textTheme.medium),
                            StatusTag(tags: [
                              StatusTagModel(
                                  title: incidentDetailsModel.data!.statusText,
                                  bgColor: AppColor.deepBlue)
                            ])
                          ])))),
          const SizedBox(height: xxTinierSpacing),
          const Divider(height: kDividerHeight, thickness: kDividerWidth),
          CustomTabBarView(
              lengthOfTabs: 6,
              tabBarViewIcons: IncidentUtil().tabBarViewIcons,
              initialIndex:
                  context.read<IncidentDetailsBloc>().incidentTabIndex,
              tabBarViewWidgets: [
                IncidentDetails(
                    incidentDetailsModel: incidentDetailsModel,
                    clientId: clientId,
                    initialIndex: 0),
                IncidentCustomFieldInfo(
                    incidentDetailsModel: incidentDetailsModel,
                    initialIndex: 1),
                PermitDetailsComment(
                    incidentDetailsModel: incidentDetailsModel,
                    clientId: clientId,
                    initialIndex: 2),
                IncidentInjuredPersonTab(
                    incidentDetailsModel: incidentDetailsModel,
                    initialIndex: 3,
                    incidentId: incidentId),
                IncidentCustomTimeLine(
                    incidentDetailsModel: incidentDetailsModel,
                    initialIndex: 4),
                IncidentLinkPermitList(
                    incidentDetailsModel: incidentDetailsModel,
                    incidentId: incidentId,
                    initialIndex: 5)
              ])
        ]));
  }
}
