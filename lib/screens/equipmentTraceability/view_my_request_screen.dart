
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/view_my_request_popup_menu.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';

class ViewMyRequestScreen extends StatelessWidget {
  static const routeName = "ViewMyRequestScreen";
  static int pageNo = 1;

  const ViewMyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context
        .read<EquipmentTraceabilityBloc>()
        .add(FetchMyRequest(pageNo: pageNo));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kViewMyRequest),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child:
            BlocConsumer<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
          listener: (context, state) {
            if (state is MyRequestFetched &&
                context.read<EquipmentTraceabilityBloc>().requestReachedMax) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          },
          buildWhen: (previousState, currentState) =>
              (currentState is MyRequestFetching && pageNo == 1) ||
              (currentState is MyRequestFetched),
          builder: (context, state) {
            if (state is MyRequestFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyRequestFetched) {
              if (state.myRequestData.isNotEmpty) {
                return ListView.separated(
                    itemCount: (context
                            .read<EquipmentTraceabilityBloc>()
                            .requestReachedMax)
                        ? state.myRequestData.length
                        : state.myRequestData.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < state.myRequestData.length) {
                        return CustomCard(
                          child: ListTile(
                            title: Text(
                                state.myRequestData[index].equipmentname,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            subtitle: Text(
                                state.myRequestData[index].equipmentcode,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.grey)),
                            trailing: const ViewMyRequestPopUp(),
                          ),
                        );
                      } else {
                        pageNo++;
                        context
                            .read<EquipmentTraceabilityBloc>()
                            .add(FetchMyRequest(pageNo: pageNo));
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinierSpacing);
                    });
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
