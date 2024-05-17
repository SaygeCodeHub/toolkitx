import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class SavePermitEditSafetyDocumentButton extends StatelessWidget {
  final Map editSafetyDocumentMap;
  final String permitId;

  const SavePermitEditSafetyDocumentButton(
      {super.key, required this.editSafetyDocumentMap, required this.permitId});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(children: [
      Expanded(
          child: PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textValue: StringConstants.kBack)),
      const SizedBox(width: xxTinierSpacing),
      BlocListener<PermitBloc, PermitStates>(
          listener: (context, state) {
            if (state is SavingPermitEditSafetyDocument) {
              ProgressBar.show(context);
            } else if (state is PermitEditSafetyDocumentSaved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, PermitDetailsScreen.routeName,
                  arguments: permitId);
            } else if (state is PermitEditSafetyDocumentNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: Expanded(
              child: PrimaryButton(
                  onPressed: () {
                    if (editSafetyDocumentMap['panel_12'] == '1') {
                      if (editSafetyDocumentMap['ptw_isolation'] == null ||
                          editSafetyDocumentMap['ptw_isolation'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_circuit'] == null ||
                          editSafetyDocumentMap['ptw_circuit'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_isolation'] ==
                              null ||
                          editSafetyDocumentMap['ptw_isolation'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_safety'] == null ||
                          editSafetyDocumentMap['ptw_safety'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_precautions'] ==
                              null ||
                          editSafetyDocumentMap['ptw_precautions'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_precautions2'] ==
                              null ||
                          editSafetyDocumentMap['ptw_precautions2'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else {
                        editSafetyDocumentMap['permit_id'] = permitId;
                        context.read<PermitBloc>().add(
                            SavePermitEditSafetyDocument(
                                editSafetyDocumentMap: editSafetyDocumentMap));
                      }
                    }
                    if (editSafetyDocumentMap['panel_15'] == '1') {
                      if (editSafetyDocumentMap['ptw_isolation'] == null ||
                          editSafetyDocumentMap['ptw_isolation'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_circuit'] == null ||
                          editSafetyDocumentMap['ptw_circuit'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['st_precautions'] ==
                              null ||
                          editSafetyDocumentMap['st_precautions'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['st_safety'] == null ||
                          editSafetyDocumentMap['st_safety'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['ptw_circuit2'] ==
                              null ||
                          editSafetyDocumentMap['ptw_circuit2'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else {
                        editSafetyDocumentMap['permit_id'] = permitId;
                        context.read<PermitBloc>().add(
                            SavePermitEditSafetyDocument(
                                editSafetyDocumentMap: editSafetyDocumentMap));
                      }
                    }
                    if (editSafetyDocumentMap['panel_16'] == '1') {
                      if (editSafetyDocumentMap['lwc_accessto'] == null ||
                          editSafetyDocumentMap['lwc_accessto'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['lwc_environment'] ==
                              null ||
                          editSafetyDocumentMap['lwc_environment'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else if (editSafetyDocumentMap['lwc_precautions'] ==
                              null ||
                          editSafetyDocumentMap['lwc_precautions'] == '') {
                        showCustomSnackBar(
                            context, StringConstants.kAllFieldsMandatory, '');
                      } else {
                        editSafetyDocumentMap['permit_id'] = permitId;
                        context.read<PermitBloc>().add(
                            SavePermitEditSafetyDocument(
                                editSafetyDocumentMap: editSafetyDocumentMap));
                      }
                    }
                  },
                  textValue: StringConstants.kSave)))
    ]));
  }
}
