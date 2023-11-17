import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/assets/assets_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';

class AssetsManageMeterReadingScreen extends StatelessWidget {
  static const routeName = "AssetsManageMeterReadingScreen";
  static Map meterReadingMap = {};

  const AssetsManageMeterReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kManageMeterReading),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(tinierSpacing),
        child: BlocListener<AssetsBloc, AssetsState>(
          listener: (context, state) {
            if(state is AssetsMeterReadingSaving){
              ProgressBar.show(context);
            }else if(state is AssetsMeterReadingSaved){
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, "Meter Reading Saved", "");
              context.read<AssetsBloc>().add(FetchAssetsDetails(
                  assetId: context.read<AssetsBloc>().assetId, assetTabIndex: 0));
              Navigator.pop(context);
            } else if(state is AssetsMeterReadingNotSaved){
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, "");
            }
          },
          child:
              PrimaryButton(onPressed: () {
                context.read<AssetsBloc>().add(SaveAssetsMeterReading(assetsMeterReadingMap: meterReadingMap));
              }, textValue: StringConstants.kSave),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Meter",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tinierSpacing),
          Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  key: GlobalKey(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  title: const Text(""),
                  children: [
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .removePadding(removeTop: true),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, listIndex) {
                              return ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 10),
                                  title: Text("yes"),
                                  onTap: () {
                                    // filterMap["year"] = state
                                    //     .yearList[listIndex]
                                    //     .toString();
                                    // state.yearList.clear();
                                    // context
                                    //     .read<ReportBloc>()
                                    //     .add(SelectFilterYear(
                                    //     filterYearMap:
                                    //     filterMap));
                                  });
                            }))
                  ])),
          const SizedBox(height: xxTinierSpacing),
          Text("Date Taken",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          DatePickerTextField(
            onDateChanged: (date) {
              // TopCustomerFilterScreen.filterMap["startDate"] = date;
            },
          ),
          const SizedBox(height: xxTinierSpacing),
          Text("Time Taken",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TimePickerTextField(
            onTimeChanged: (time) {
              // TopCustomerFilterScreen.filterMap["startDate"] = date;
            },
          ),
          const SizedBox(height: xxTinierSpacing),
          Text("Reading",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(
            onTextFieldChanged: (textField) {},
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: xxTinierSpacing),
          Text("Is rollover",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  key: GlobalKey(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  title: const Text(""),
                  children: [
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .removePadding(removeTop: true),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, listIndex) {
                              return ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 10),
                                  title: Text("yes"),
                                  onTap: () {
                                    // filterMap["year"] = state
                                    //     .yearList[listIndex]
                                    //     .toString();
                                    // state.yearList.clear();
                                    // context
                                    //     .read<ReportBloc>()
                                    //     .add(SelectFilterYear(
                                    //     filterYearMap:
                                    //     filterMap));
                                  });
                            }))
                  ])),
          const SizedBox(height: xxTinierSpacing),
          Text("Note",
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(onTextFieldChanged: (textField) {}),
        ]),
      ),
    );
  }
}
