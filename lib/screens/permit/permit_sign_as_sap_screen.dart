import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/offlinePermit/save_offline_data_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../data/models/permit/permit_sap_cp_model.dart';

class PermitSignAsSapScreen extends StatelessWidget {
  static const routeName = 'PermitSignAsSapScreen';
  final PermitCpSapModel permitCpSapModel;

  const PermitSignAsSapScreen({super.key, required this.permitCpSapModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSignAsSap),
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
              BlocListener<PermitBloc, PermitStates>(
                listener: (context, state) {
                  if (state is OfflineDataSaved) {
                    showCustomSnackBar(
                        context, StringConstants.kDataSavedSuccessfully, '');
                    Future.delayed(const Duration(seconds: 3));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, PermitDetailsScreen.routeName,
                        arguments: permitCpSapModel.sapCpMap['permitid'] ??
                            permitCpSapModel.sapCpMap['permitId']);
                  } else if (state is OfflineDataNotSaved) {
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                child: Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          SaveOfflineDataUtil().saveData(
                              permitCpSapModel.previousScreen,
                              permitCpSapModel.sapCpMap,
                              context);
                        },
                        textValue: StringConstants.kSignAsSapCap)),
              )
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
                          permitCpSapModel.sapCpMap['user_name'] = textValue;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kEmailAndPhoneNo,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TextFieldWidget(
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onTextFieldChanged: (String textValue) {
                          permitCpSapModel.sapCpMap['user_email'] = textValue;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kDate,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(onDateChanged: (String date) {
                      permitCpSapModel.sapCpMap['user_date'] = date;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kTime,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TimePickerTextField(onTimeChanged: (String time) {
                      permitCpSapModel.sapCpMap['user_time'] = time;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    SignaturePad(
                        map: permitCpSapModel.sapCpMap, mapKey: 'user_sign'),
                    const SizedBox(height: xxTinySpacing)
                  ],
                ))));
  }
}
