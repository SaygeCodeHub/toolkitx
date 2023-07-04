import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/report_new_incident_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = 'CategoryScreen';
  static List multiSelectList = [];
  static Map addIncidentMap = {};

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(FetchIncidentMaster(
        role: context.read<IncidentFetchAndChangeRoleBloc>().roleId));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kCategory),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingIncidentMaster ||
                    currentState is IncidentMasterFetched,
                builder: (context, state) {
                  if (state is FetchingIncidentMaster) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is IncidentMasterFetched) {
                    multiSelectList.addAll(state.categorySelectedList);
                    addIncidentMap['category'] = multiSelectList
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", "");
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DatabaseUtil.getText('SelectcategoryHeading'),
                              style: Theme.of(context)
                                  .textTheme
                                  .mediumLarge
                                  .copyWith(fontWeight: FontWeight.w500)),
                          const SizedBox(height: xxTinySpacing),
                          Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.categoryList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              state.categoryList[index]
                                                  ['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .medium
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.greyBlack)),
                                          const SizedBox(
                                              height: xxTiniestSpacing),
                                          ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: state
                                                  .categoryList[index]['items']
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int itemIndex) {
                                                return CheckboxListTile(
                                                    checkColor: AppColor.white,
                                                    activeColor:
                                                        AppColor.deepBlue,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    value: multiSelectList
                                                        .contains(state
                                                            .categoryList[index]
                                                                ['items']
                                                                [itemIndex]
                                                            .id),
                                                    title: Text(
                                                        state
                                                            .categoryList[index]
                                                                ['items']
                                                                [itemIndex]
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .xSmall
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                color: AppColor.grey)),
                                                    controlAffinity: ListTileControlAffinity.trailing,
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              ReportNewIncidentBloc>()
                                                          .add(SelectIncidentCategory(
                                                              index: index,
                                                              itemIndex:
                                                                  itemIndex,
                                                              isSelected:
                                                                  value!,
                                                              multiSelectList:
                                                                  multiSelectList,
                                                              addNewIncidentMap:
                                                                  addIncidentMap));
                                                    });
                                              }),
                                          const SizedBox(
                                              height: xxTiniestSpacing)
                                        ]);
                                  })),
                          const SizedBox(height: xxTiniestSpacing),
                          PrimaryButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ReportNewIncidentScreen.routeName,
                                    arguments: addIncidentMap);
                              },
                              textValue:
                                  DatabaseUtil.getText('nextButtonText')),
                          const SizedBox(height: xxTiniestSpacing)
                        ]);
                  } else if (state is IncidentMasterNotFetched) {
                    return GenericReloadButton(
                        onPressed: () {}, textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
