import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../blocs/qualityManagement/qm_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import 'qm_site_list.dart';

class QualityManagementSiteListTile extends StatelessWidget {
  final Map reportNewQMMap;

  const QualityManagementSiteListTile(
      {super.key, required this.reportNewQMMap});

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        ReportQualityManagementSiteListChange(
            selectSiteName: (reportNewQMMap['site_name'] == null)
                ? ''
                : reportNewQMMap['site_name']));
    return BlocBuilder<QualityManagementBloc, QualityManagementStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewQualityManagementSiteSelected,
        builder: (context, state) {
          if (state is ReportNewQualityManagementSiteSelected) {
            reportNewQMMap['site_name'] = state.selectSiteName;
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QualityManagementSiteList(
                                  fetchQualityManagementMasterModel:
                                      state.fetchQualityManagementMasterModel,
                                  selectSiteName: state.selectSiteName)));
                    },
                    title: Text(DatabaseUtil.getText('Site'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.selectSiteName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.selectSiteName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible:
                        state.selectSiteName == DatabaseUtil.getText('Other'),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DatabaseUtil.getText('OtherSite'),
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: xxxTinierSpacing),
                          TextFieldWidget(
                              hintText: StringConstants.kOther,
                              onTextFieldChanged: (String textField) {
                                reportNewQMMap['site'] = textField;
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
