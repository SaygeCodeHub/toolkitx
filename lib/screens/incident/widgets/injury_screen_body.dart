import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../configs/app_spacing.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/incident/incident_injury_master.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import 'injury_grid_multi_select.dart';
import 'injury_nature_expansion.dart';

class InjuryScreenBody extends StatelessWidget {
  final List<IncidentInjuryMasterDatum> injuryNatureList;
  final Map injuredPersonDetails;

  const InjuryScreenBody(
      {super.key,
      required this.injuryNatureList,
      required this.injuredPersonDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(DatabaseUtil.getText('NameOfInjuredPerson'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              hintText: DatabaseUtil.getText('Name'),
              onTextFieldChanged: (String textField) {
                injuredPersonDetails['name'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          Text(DatabaseUtil.getText('CompanyOfInjuredPersin'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          TextFieldWidget(
              hintText: DatabaseUtil.getText('Company'),
              onTextFieldChanged: (String textField) {
                injuredPersonDetails['company'] = textField;
              }),
          const SizedBox(height: xxTinySpacing),
          Text(DatabaseUtil.getText('NatureOfInjuries'),
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: xxxTinierSpacing),
          InjuryNatureExpansionTile(
              injuryNature: injuryNatureList,
              injuredPersonDetails: injuredPersonDetails),
          const SizedBox(height: xxTinySpacing),
          ClipRRect(
              borderRadius: BorderRadius.circular(kCardRadius),
              child: Image.asset('assets/icons/bodyPart.png',
                  fit: BoxFit.fitWidth)),
          const SizedBox(height: xxTinySpacing),
          InjuryMultiSelect(injuredPersonDetails: injuredPersonDetails)
        ]));
  }
}
