import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class EnterEquipmentCodeScreen extends StatelessWidget {
  static const routeName = 'EnterEquipmentCodeScreen';
  static String code = '';

  const EnterEquipmentCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    code = '';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(xxTinySpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringConstants.kEquipmentCode,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    const SizedBox(height: xxTinierSpacing),
                    TextFieldWidget(
                        textInputType: TextInputType.number,
                        onTextFieldChanged: (textField) {
                          code = textField;
                        }),
                    const SizedBox(height: xxTinySpacing),
                    Row(
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                textValue: StringConstants.kClose)),
                        const SizedBox(width: xxTinySpacing),
                        Expanded(
                            child: BlocListener<EquipmentTraceabilityBloc,
                                EquipmentTraceabilityState>(
                          listener: (context, state) {
                            if (state is EquipmentByCodeFetching) {
                              ProgressBar.show(context);
                            }
                            if (state is EquipmentByCodeFetched) {
                              ProgressBar.dismiss(context);
                              Navigator.pop(context);
                            }
                            if (state is EquipmentByCodeNotFetched) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.errorMessage, '');
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context
                                    .read<EquipmentTraceabilityBloc>()
                                    .add(FetchEquipmentByCode(code: code));
                              },
                              textValue: StringConstants.kSearch),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
