import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/assets/assets_master_model.dart';
import '../../../widgets/generic_text_field.dart';
import '../../incident/widgets/date_picker.dart';
import '../../incident/widgets/time_picker.dart';
import 'isrollover_expansion_tile.dart';
import 'meter_expansion_tile.dart';

class AssetsManageMeterReadingBody extends StatelessWidget {
  const AssetsManageMeterReadingBody(
      {super.key, required this.meterReadingMap, required this.data});

  final Map meterReadingMap;
  final List<List<Datum>> data;

  @override
  Widget build(BuildContext context) {
    Map rolloverMap = {'1': 'Yes', '2': 'No'};
    context.read<AssetsBloc>().add(
        SelectAssetsMeter(id: meterReadingMap["meterid"] ?? 0, meterName: ''));
    context.read<AssetsBloc>().add(SelectAssetsRollOver(
          id: meterReadingMap["isrollover"] ?? '',
          isRollover: '',
        ));
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kMeter,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tinierSpacing),
          MeterExpansionTile(data: data, meterReadingMap: meterReadingMap),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kDateTaken,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          DatePickerTextField(onDateChanged: (date) {
            meterReadingMap["date"] = date;
          }),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kTimeTaken,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TimePickerTextField(onTimeChanged: (time) {
            meterReadingMap["time"] = time;
          }),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kReading,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(
              onTextFieldChanged: (textField) {
                meterReadingMap["reading"] = textField;
              },
              textInputType: TextInputType.number),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kIsRollover,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          IsRolloverExpansionTile(
              rolloverMap: rolloverMap, meterReadingMap: meterReadingMap),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kNote,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(onTextFieldChanged: (textField) {
            meterReadingMap["note"] = textField;
          })
        ]));
  }
}
