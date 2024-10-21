import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import 'qm_location_list.dart';

class QualityManagementLocationListTile extends StatelessWidget {
  final Map reportNewQMMap;

  const QualityManagementLocationListTile(
      {super.key, required this.reportNewQMMap});

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        ReportNewQualityManagementLocationChange(
            selectLocationName: (reportNewQMMap['location_name'] == null)
                ? ''
                : reportNewQMMap['location_name']));
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementLocationSelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementLocationSelected) {
            reportNewQMMap['location_name'] = state.selectLocationName;
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QualityManagementLocationList(
                                      fetchQualityManagementMasterModel: state
                                          .fetchQualityManagementMasterModel,
                                      selectLocationName:
                                          state.selectLocationName)));
                    },
                    title: Text(DatabaseUtil.getText('Location'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.selectLocationName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.selectLocationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible: state.selectLocationName ==
                        DatabaseUtil.getText('Other'),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringConstants.kOther,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              hintText: DatabaseUtil.getText('OtherLocation'),
                              onTextFieldChanged: (String textField) {
                                reportNewQMMap['location'] =
                                    (state.selectLocationName == 'Other'
                                        ? textField
                                        : '');
                              })
                        ])),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
