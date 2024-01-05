import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';

class EquipmentSetParameterScreen extends StatelessWidget {
  const EquipmentSetParameterScreen({super.key, required this.equipmentMap});

  static const routeName = 'EquipmentSetParameterScreen';
  final Map equipmentMap;

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(
        FetchEquipmentSetParameter(equipmentId: equipmentMap["equipmentId"]));
    return Scaffold(
      appBar: GenericAppBar(
        title: equipmentMap['equipmentName'],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child:
            BlocConsumer<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          listener: (context, state) {
            if (state is CustomParameterSaving) {
              ProgressBar.show(context);
            } else if (state is CustomParameterSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(
                  context, StringConstants.kCustomParameterSaved, "");
              Navigator.pop(context);
            } else if (state is CustomParameterNotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, "");
            }
          },
          builder: (context, state) {
            if (state is EquipmentSetParameterFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EquipmentSetParameterFetched) {
              var data = state.fetchEquipmentSetParameterModel.data;
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.fetchEquipmentSetParameterModel.data
                      .parameterlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: xxTinySpacing,
                            vertical: xxxSmallestSpacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${data.parameterlist[index].name} (${data.parameterlist[index].unitname})',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            TextFieldWidget(
                              textInputType: TextInputType.number,
                              hintText: StringConstants.kEnterMileageHere,
                              onTextFieldChanged: (textField) {
                                equipmentMap["answer"] = textField;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: tiniestSpacing));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
          onPressed: () {
            context.read<EquipmentTraceabilityBloc>().answerList.add({
              "id": equipmentMap["equipmentId"],
              "answer": equipmentMap["answer"]
            });
            context
                .read<EquipmentTraceabilityBloc>()
                .add(SaveCustomParameter(saveCustomParameterMap: equipmentMap));
          },
          textValue: StringConstants.kSubmit,
        ),
      ),
    );
  }
}
