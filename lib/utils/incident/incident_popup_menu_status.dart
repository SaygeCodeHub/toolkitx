import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/incident_details_model.dart';
import '../../widgets/generic_text_field.dart';

class IncidentPopUpMenuStatusWidgets {
  Widget renderWidgets(IncidentDetailsModel incidentDetailsModel,
      BuildContext context, Map incidentCommentsMap) {
    switch (incidentDetailsModel.data!.nextStatus) {
      case '0':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kSuspectedCause,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                maxLines: 5,
                onTextFieldChanged: (String value) {
                  incidentCommentsMap['suspectedcause'] = value;
                }),
            const SizedBox(height: xxTinierSpacing)
          ],
        );
      case '1':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kRootCause,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                maxLines: 5,
                onTextFieldChanged: (String value) {
                  incidentCommentsMap['rootcause'] = value;
                }),
            const SizedBox(height: xxTinierSpacing),
            Text(StringConstants.kLessonsLearnt,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                maxLines: 5,
                onTextFieldChanged: (String value) {
                  incidentCommentsMap['lessonslearnt'] = value;
                }),
            const SizedBox(height: xxTinierSpacing)
          ],
        );
      case '2':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kPreliminaryRecommendation,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                maxLines: 5,
                onTextFieldChanged: (String value) {
                  incidentCommentsMap['preliminaryrecommendation'] = value;
                }),
            const SizedBox(height: xxTinierSpacing)
          ],
        );
      case '4':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringConstants.kCompletedCorrectiveActions,
                style: Theme.of(context).textTheme.small.copyWith(
                    color: AppColor.black, fontWeight: FontWeight.w500)),
            const SizedBox(height: xxTinierSpacing),
            TextFieldWidget(
                maxLines: 5,
                onTextFieldChanged: (String value) {
                  incidentCommentsMap['completedcorrectiveactions'] = value;
                }),
            const SizedBox(height: xxTinierSpacing)
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget renderMarkAsResolvedControl(IncidentDetailsModel incidentDetailsModel,
      BuildContext context, Map incidentCommentsMap) {
    if (incidentDetailsModel.data!.canResolve == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.kPreventiveActions,
              style: Theme.of(context).textTheme.small.copyWith(
                  color: AppColor.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: xxTinierSpacing),
          TextFieldWidget(
              maxLines: 5,
              onTextFieldChanged: (String value) {
                incidentCommentsMap['preventiveactions'] = value;
              }),
          const SizedBox(height: xxTinierSpacing)
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
