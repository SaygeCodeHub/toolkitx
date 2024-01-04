import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/enums/report_anonymously_enum.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/expansion_tile_border.dart';

class ReportAnonymouslyExpansionTile extends StatelessWidget {
  final Map reportNewQAMap;

  const ReportAnonymouslyExpansionTile({Key? key, required this.reportNewQAMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<QualityManagementBloc>()
        .add(ReportNewQAAnonymously(anonymousId: ''));
    String anonymousName = '';
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportedNewQAAnonymously,
        builder: (context, state) {
          if (state is ReportedNewQAAnonymously) {
            reportNewQAMap['responsible_person'] = state.anonymousId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        (anonymousName == '')
                            ? DatabaseUtil.getText('No')
                            : anonymousName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ReportAnonymouslyEnum.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: xxxTinierSpacing),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    ReportAnonymouslyEnum.values
                                        .elementAt(index)
                                        .status,
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: ReportAnonymouslyEnum.values
                                    .elementAt(index)
                                    .value,
                                groupValue: state.anonymousId,
                                onChanged: (value) {
                                  value = ReportAnonymouslyEnum.values
                                      .elementAt(index)
                                      .value;
                                  anonymousName = ReportAnonymouslyEnum.values
                                      .elementAt(index)
                                      .status;
                                  context.read<QualityManagementBloc>().add(
                                      ReportNewQAAnonymously(
                                          anonymousId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
