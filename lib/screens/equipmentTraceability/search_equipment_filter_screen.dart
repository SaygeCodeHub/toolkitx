import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class SearchEquipmentFilterScreen extends StatelessWidget {
  static const routeName = 'SearchEquipmentFilterScreen';
  static Map searchEquipmentFilterMap = {};

  const SearchEquipmentFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kEquipmentName,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(
            onTextFieldChanged: (textField) {
              searchEquipmentFilterMap['equname'] = textField;
            },
          ),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kEquipmentCode,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(
            onTextFieldChanged: (textField) {
              searchEquipmentFilterMap['equcode'] = textField;
            },
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context.read<EquipmentTraceabilityBloc>().add(
                  ApplySearchEquipmentFilter(
                      searchEquipmentFilterMap: searchEquipmentFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, SearchEquipmentListScreen.routeName,
                  arguments: false);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
