import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class IncidentCategoryBody extends StatelessWidget {
  final List categoryList;
  final List categorySelectedList;

  const IncidentCategoryBody(
      {Key? key,
      required this.categoryList,
      required this.categorySelectedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categoryList[index]['title'],
                        style: Theme.of(context).textTheme.medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.greyBlack)),
                    const SizedBox(height: xxTiniestSpacing),
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryList[index]['items'].length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return CheckboxListTile(
                              checkColor: AppColor.white,
                              activeColor: AppColor.deepBlue,
                              contentPadding: EdgeInsets.zero,
                              value: categorySelectedList.contains(
                                  categoryList[index]['items'][itemIndex]
                                      .id
                                      .toString()
                                      .trim()),
                              title: Text(
                                  categoryList[index]['items'][itemIndex].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.grey)),
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (value) {
                                context
                                    .read<ReportNewIncidentBloc>()
                                    .add(SelectIncidentCategory(
                                      selectedCategory: categoryList[index]
                                              ['items'][itemIndex]
                                          .id
                                          .toString()
                                          .trim(),
                                      multiSelectList: categorySelectedList,
                                    ));
                              });
                        }),
                    const SizedBox(height: xxTiniestSpacing)
                  ]);
            }));
  }
}
