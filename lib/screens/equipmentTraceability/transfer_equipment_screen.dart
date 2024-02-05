import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/send_transfer_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';
import 'widgets/transfer_equipment_popup_menu.dart';

class TransferEquipmentScreen extends StatelessWidget {
  static const routeName = 'TransferEquipmentScreen';

  const TransferEquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().equipmentList = [];
    context
        .read<EquipmentTraceabilityBloc>()
        .add(FetchEquipmentByCode(code: ''));
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kTransfer,
        actions: [TransferEquipmentPopupMenu()],
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<EquipmentTraceabilityBloc,
              EquipmentTraceabilityState>(
            buildWhen: (previousState, currentState) =>
                (currentState is EquipmentByCodeNotFetched &&
                    context
                        .read<EquipmentTraceabilityBloc>()
                        .equipmentList
                        .isEmpty) ||
                (currentState is EquipmentByCodeFetching &&
                    context
                        .read<EquipmentTraceabilityBloc>()
                        .equipmentList
                        .isEmpty) ||
                currentState is EquipmentByCodeFetched,
            builder: (context, state) {
              if (state is EquipmentByCodeFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EquipmentByCodeFetched) {
                return ListView.separated(
                  itemCount: context
                      .read<EquipmentTraceabilityBloc>()
                      .equipmentList
                      .length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        child: ListTile(
                      title: Text(
                          context
                                  .read<EquipmentTraceabilityBloc>()
                                  .equipmentList[index]["equipmentname"] ??
                              '',
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      subtitle: Text(
                          context
                                  .read<EquipmentTraceabilityBloc>()
                                  .equipmentList[index]["equipmentcode"] ??
                              '',
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.grey)),
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  },
                );
              } else if (state is EquipmentByCodeNotFetched) {
                return Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.errorRed)),
                        child: Padding(
                          padding: const EdgeInsets.all(xxTinierSpacing),
                          child: Text(
                            StringConstants.kPleaseSearchOrScanTheEquipment,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                  color: AppColor.errorRed,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ))
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          )),
      bottomNavigationBar:
          BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
        buildWhen: (previousState, currentState) =>
            currentState is EquipmentByCodeFetched,
        builder: (context, state) {
          if (state is EquipmentByCodeFetched) {
            return Padding(
              padding: const EdgeInsets.all(xxTinierSpacing),
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SendTransferScreen.routeName);
                  },
                  textValue: StringConstants.kTransfer),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
