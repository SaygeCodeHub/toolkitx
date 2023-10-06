import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import '../assign_workforce_screen.dart';
import 'assign_workforce_status_tags.dart';

class AssignWorkForceBody extends StatelessWidget {
  const AssignWorkForceBody({Key? key}) : super(key: key);
  static Map assignWorkForceMap = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: context
                        .read<WorkOrderTabDetailsBloc>()
                        .assignWorkForceListReachedMax ==
                    true
                ? context
                    .read<WorkOrderTabDetailsBloc>()
                    .assignWorkForceDatum
                    .length
                : context
                        .read<WorkOrderTabDetailsBloc>()
                        .assignWorkForceDatum
                        .length +
                    1,
            itemBuilder: (context, index) {
              if (index <
                  context
                      .read<WorkOrderTabDetailsBloc>()
                      .assignWorkForceDatum
                      .length) {
                return Card(
                    child: ListTile(
                        contentPadding: const EdgeInsets.all(tiniestSpacing),
                        title: Text(
                            context
                                .read<WorkOrderTabDetailsBloc>()
                                .assignWorkForceDatum[index]
                                .name,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w500)),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: xxTinierSpacing),
                              Text(context
                                  .read<WorkOrderTabDetailsBloc>()
                                  .assignWorkForceDatum[index]
                                  .jobTitle),
                              const SizedBox(height: xxTinierSpacing),
                              TextFieldWidget(
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.number,
                                  maxLength: 2,
                                  hintText: DatabaseUtil.getText(
                                      'PlannedWorkingHours'),
                                  onTextFieldChanged: (String textField) {
                                    assignWorkForceMap['hrs'] = textField;
                                  }),
                              const SizedBox(height: xxTinierSpacing),
                              AssignWorkForceStatusTags(
                                  assignWorkForceDatum: context
                                      .read<WorkOrderTabDetailsBloc>()
                                      .assignWorkForceDatum[index],
                                  index: index)
                            ])));
              } else if (!context
                  .read<WorkOrderTabDetailsBloc>()
                  .assignWorkForceListReachedMax) {
                AssignWorkForceScreen.pageNo++;
                context.read<WorkOrderTabDetailsBloc>().add(
                    (FetchAssignWorkForceList(
                        pageNo: AssignWorkForceScreen.pageNo)));
                return const Center(
                    child: Padding(
                        padding:
                            EdgeInsets.all(kCircularProgressIndicatorPadding),
                        child: SizedBox(
                            width: kCircularProgressIndicatorWidth,
                            child: CircularProgressIndicator())));
              } else {
                return const SizedBox.shrink();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: xxTinierSpacing);
            }));
  }
}
