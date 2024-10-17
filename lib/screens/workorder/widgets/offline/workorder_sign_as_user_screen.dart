import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/profile/widgets/signature.dart';
import 'package:toolkit/screens/workorder/widgets/offline/workorder_sap_model.dart';
import 'package:toolkit/screens/workorder/workorder_details_tab_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../../blocs/workorder/workorder_bloc.dart';
import '../../../../blocs/workorder/workorder_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/offlinePermit/save_offline_data_util.dart';

class WorkOrderSignAsUserScreen extends StatelessWidget {
  static const routeName = 'WorkOrderSignAsSapScreen';

  final WorkOrderSapModel workOrderSapModel;

  const WorkOrderSignAsUserScreen({super.key, required this.workOrderSapModel});

  @override
  Widget build(BuildContext context) {
    workOrderSapModel.sapMap['user_sign'] = '';
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSignAsUser),
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
              BlocListener<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
                listener: (context, state) {
                  if (state is WorkOrderOfflineDataSaved) {
                    showCustomSnackBar(
                        context, StringConstants.kDataSavedSuccessfully, '');
                    Future.delayed(const Duration(seconds: 3));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context
                        .read<WorkOrderBloc>()
                        .add(FetchWorkOrders(pageNo: 1, isFromHome: false));
                    Navigator.pushReplacementNamed(
                        context, WorkOrderDetailsTabScreen.routeName,
                        arguments: state.workOrderId);
                  } else if (state is WorkOrderOfflineDataNotSaved) {
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                child: Expanded(
                    child: PrimaryButton(
                        onPressed: () {
                          print(
                              'orkOrderSapModel.sapMap ${workOrderSapModel.sapMap}');
                          if (workOrderSapModel.sapMap['user_name'] == null ||
                              workOrderSapModel.sapMap['user_name'] == '') {
                            showCustomSnackBar(context,
                                StringConstants.kEnterNameValidation, '');
                          } else if (workOrderSapModel.sapMap['user_date'] ==
                                  null ||
                              workOrderSapModel.sapMap['user_date'] == '') {
                            showCustomSnackBar(
                                context, StringConstants.kPleaseSelectDate, '');
                          } else if (workOrderSapModel.sapMap['user_time'] ==
                                  null ||
                              workOrderSapModel.sapMap['user_time'] == '') {
                            showCustomSnackBar(
                                context, StringConstants.kPleaseSelectTime, '');
                          } else if (workOrderSapModel.sapMap['user_sign'] ==
                                  null ||
                              workOrderSapModel.sapMap['user_sign'] == '') {
                            showCustomSnackBar(context,
                                StringConstants.kPleaseEnterSignature, '');
                          } else {
                            SaveOfflineDataUtil().saveWorkOrderData(
                                workOrderSapModel.previousScreen,
                                workOrderSapModel.sapMap,
                                context);
                          }
                        },
                        textValue: StringConstants.kSignAsUser)),
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
                    TextField(
                        onChanged: (value) {
                          workOrderSapModel.sapMap['user_name'] = value;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            counterText: '',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(color: AppColor.grey),
                            contentPadding:
                                const EdgeInsets.all(xxTinierSpacing),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.lightGrey)),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.lightGrey),
                            ),
                            filled: true,
                            fillColor: AppColor.white)),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kDate,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    DatePickerTextField(onDateChanged: (String date) {
                      workOrderSapModel.sapMap['user_date'] = date;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    Text(StringConstants.kTime,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxxTinierSpacing),
                    TimePickerTextField(onTimeChanged: (String time) {
                      workOrderSapModel.sapMap['user_time'] = time;
                    }),
                    const SizedBox(height: xxTinySpacing),
                    SignaturePad(
                        map: workOrderSapModel.sapMap, mapKey: 'user_sign'),
                    const SizedBox(height: xxTinySpacing)
                  ],
                ))));
  }
}
