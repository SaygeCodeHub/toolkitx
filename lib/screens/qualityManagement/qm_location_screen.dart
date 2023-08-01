import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../blocs/qualityManagement/qm_states.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import 'qm_custom_fields_screen.dart';
import 'widgets/qm_impact_expansion_tile.dart';
import 'widgets/qm_location_list_tile.dart';
import 'widgets/qm_severity_expansion_tile.dart';
import 'widgets/qm_site_list_tile.dart';

class QualityManagementLocationScreen extends StatelessWidget {
  static const routeName = 'QualityManagementLocationScreen';
  final Map reportNewQMMap;

  const QualityManagementLocationScreen(
      {Key? key, required this.reportNewQMMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('NewQAReporting')),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin, right: leftRightMargin),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QualityManagementSiteListTile(
                        reportNewQMMap: reportNewQMMap),
                    QualityManagementLocationListTile(
                        reportNewQMMap: reportNewQMMap),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Severity'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    QualityManagementSeverityExpansionTile(
                        reportNewQMMap: reportNewQMMap),
                    const SizedBox(height: xxTinySpacing),
                    Text(DatabaseUtil.getText('Impact'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    QualityManagementImpactExpansionTile(
                        reportNewQMMap: reportNewQMMap)
                  ]))),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textValue: DatabaseUtil.getText('buttonBack'),
            )),
            const SizedBox(width: xxTinierSpacing),
            BlocListener<QualityManagementBloc, QualityManagementStates>(
                listener: (context, state) {
                  if (state
                      is ReportNewQualityManagementSiteLocationValidated) {
                    showCustomSnackBar(
                        context, state.siteLocationValidationMessage, '');
                  } else if (state
                      is ReportNewQualityManagementSiteLocationValidationComplete) {
                    Navigator.pushNamed(
                        context, QualityManagementCustomFieldsScreen.routeName,
                        arguments: reportNewQMMap);
                  }
                },
                child: Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        context.read<QualityManagementBloc>().add(
                            ReportNewQualityManagementSiteLocationValidation(
                                reportNewQAMap: reportNewQMMap));
                      },
                      textValue: DatabaseUtil.getText('nextButtonText')),
                )),
          ],
        ),
      ),
    );
  }
}
