import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../blocs/qualityManagement/qm_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../qm_location_screen.dart';

class NewQMReportingBottomBar extends StatelessWidget {
  final Map reportNewQAMap;

  const NewQMReportingBottomBar({
    Key? key,
    required this.reportNewQAMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
              if (state is ReportNewQualityManagementDateTimeDescValidated) {
                showCustomSnackBar(
                    context, state.dateTimeDescValidationMessage, '');
              } else if (state
                  is ReportNewQualityManagementDateTimeDescValidationComplete) {
                Navigator.pushNamed(
                    context, QualityManagementLocationScreen.routeName,
                    arguments: reportNewQAMap);
              }
            },
            child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    context.read<QualityManagementBloc>().add(
                        ReportNewQualityManagementDateTimeDescriptionValidation(
                            reportNewQAMap: reportNewQAMap));
                  },
                  textValue: DatabaseUtil.getText('nextButtonText')),
            ),
          ),
        ],
      ),
    );
  }
}
