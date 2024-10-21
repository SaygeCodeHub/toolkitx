import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/text_button.dart';
import '../category_screen.dart';

class AddInjuredPersonBody extends StatelessWidget {
  final List injuredPersonsList;
  final Map addAndEditIncidentMap;

  const AddInjuredPersonBody(
      {super.key,
      required this.injuredPersonsList,
      required this.addAndEditIncidentMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Visibility(
            visible: injuredPersonsList.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: CategoryScreen.isFromEdit == true,
                    child: Text(
                        '${DatabaseUtil.getText('headingInjuredPerson')} :',
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.mediumBlack))),
                const SizedBox(height: xxTinySpacing),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: injuredPersonsList.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: tinierSpacing,
                                right: tinierSpacing,
                                top: tiniestSpacing,
                                bottom: tiniestSpacing),
                            trailing: Visibility(
                              visible: CategoryScreen.isFromEdit != true,
                              replacement: Image.asset(
                                  'assets/icons/human_avatar_three.png'),
                              child: CustomTextButton(
                                  onPressed: () {
                                    context.read<ReportNewIncidentBloc>().add(
                                        IncidentRemoveInjuredPersonDetails(
                                            injuredPersonDetailsList:
                                                addAndEditIncidentMap[
                                                    'persons'],
                                            index: index));
                                  },
                                  textValue: StringConstants.kRemove),
                            ),
                            title: Text(injuredPersonsList[index]['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.mediumBlack))));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  },
                ),
              ],
            )));
  }
}
