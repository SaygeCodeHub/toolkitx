import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/enums/incident_classification_enum.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class IncidentClassificationExpansionTile extends StatelessWidget {
  final Map incidentCommentsMap;

  const IncidentClassificationExpansionTile(
      {Key? key, required this.incidentCommentsMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<IncidentDetailsBloc>()
        .add(SelectIncidentClassification(classificationId: ''));
    String classificationStatus = '';
    return BlocBuilder<IncidentDetailsBloc, IncidentDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is IncidentClassificationSelected,
        builder: (context, state) {
          if (state is IncidentClassificationSelected) {
            incidentCommentsMap['classification'] = state.classificationId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (classificationStatus == '')
                            ? DatabaseUtil.getText('select_item')
                            : classificationStatus,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: IncidentClassificationEnum.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    IncidentClassificationEnum.values
                                        .elementAt(index)
                                        .status,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: IncidentClassificationEnum.values
                                    .elementAt(index)
                                    .value,
                                groupValue: state.classificationId,
                                onChanged: (value) {
                                  value = IncidentClassificationEnum.values
                                      .elementAt(index)
                                      .value;
                                  classificationStatus =
                                      IncidentClassificationEnum.values
                                          .elementAt(index)
                                          .status;
                                  context.read<IncidentDetailsBloc>().add(
                                      SelectIncidentClassification(
                                          classificationId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
