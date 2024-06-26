import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/permit/permit_states.dart';
import '../../data/models/permit/permit_sap_cp_model.dart';
import '../../utils/offlinePermit/save_offline_data_util.dart';
import '../../widgets/custom_snackbar.dart';

class PermitSignAsCpScreen extends StatelessWidget {
  static const routeName = 'PermitSignAsCpScreen';

  final PermitCpSapModel permitCpSapModel;

  const PermitSignAsCpScreen({super.key, required this.permitCpSapModel});

  @override
  Widget build(BuildContext context) {
    permitCpSapModel.sapCpMap['npw_sign'] = '';
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSignAsCp),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxxTinierSpacing),
            child: Row(children: [
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textValue: StringConstants.kBack)),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                  child: BlocListener<PermitBloc, PermitStates>(
                      listener: (context, state) {
                        if (state is OfflineDataSaved) {
                          if (permitCpSapModel.previousScreen ==
                              'TransferPermitOfflineScreen') {
                            showCustomSnackBar(context,
                                StringConstants.kDataSavedSuccessfully, '');
                            Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, PermitDetailsScreen.routeName,
                                arguments:
                                    permitCpSapModel.sapCpMap['permitid']);
                          } else {
                            showCustomSnackBar(context,
                                StringConstants.kDataSavedSuccessfully, '');
                            Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, PermitDetailsScreen.routeName,
                                arguments:
                                    permitCpSapModel.sapCpMap['permitid']);
                          }
                        } else if (state is OfflineDataNotSaved) {
                          showCustomSnackBar(
                              context, StringConstants.kFailedToSaveData, '');
                        }
                      },
                      child: PrimaryButton(
                          onPressed: () {
                            if (permitCpSapModel.sapCpMap['npw_name'] == null ||
                                permitCpSapModel.sapCpMap['npw_name'] == '') {
                              showCustomSnackBar(context,
                                  StringConstants.kEnterNameValidation, '');
                            } else if (permitCpSapModel.sapCpMap['user_date'] ==
                                    null ||
                                permitCpSapModel.sapCpMap['user_date'] == '') {
                              showCustomSnackBar(context,
                                  StringConstants.kPleaseSelectDate, '');
                            } else if (permitCpSapModel.sapCpMap['user_time'] ==
                                    null ||
                                permitCpSapModel.sapCpMap['user_time'] == '') {
                              showCustomSnackBar(context,
                                  StringConstants.kPleaseSelectTime, '');
                            } else if (permitCpSapModel.sapCpMap['npw_sign'] ==
                                    null ||
                                permitCpSapModel.sapCpMap['npw_sign'] == '') {
                              showCustomSnackBar(context,
                                  StringConstants.kPleaseEnterSignature, '');
                            } else {
                              SaveOfflineDataUtil().saveData(
                                  permitCpSapModel.previousScreen,
                                  permitCpSapModel.sapCpMap,
                                  context);
                            }
                          },
                          textValue: StringConstants.kSignAsCpCap)))
            ])),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringConstants.kName,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          onTextFieldChanged: (String textValue) {
                            permitCpSapModel.sapCpMap['npw_name'] = textValue;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kAuthNumber,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          onTextFieldChanged: (String textValue) {
                            permitCpSapModel.sapCpMap['npw_auth'] = textValue;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kCompanyName,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          onTextFieldChanged: (String textValue) {
                            permitCpSapModel.sapCpMap['npw_company'] =
                                textValue;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kEmailAndPhoneNo,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          onTextFieldChanged: (String textValue) {
                            permitCpSapModel.sapCpMap['npw_email'] = textValue;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kDate,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      DatePickerTextField(onDateChanged: (String textValue) {
                        permitCpSapModel.sapCpMap['user_date'] = textValue;
                      }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kTime,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TimePickerTextField(onTimeChanged: (String date) {
                        permitCpSapModel.sapCpMap['user_time'] = date;
                      }),
                      const SizedBox(height: xxTinySpacing),
                      SignaturePad(
                          map: permitCpSapModel.sapCpMap, mapKey: 'npw_sign'),
                      const SizedBox(height: xxTinySpacing)
                    ]))));
  }
}
