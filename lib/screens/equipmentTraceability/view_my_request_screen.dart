import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/view_my_request_popup_menu.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/progress_bar.dart';

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
            if (state is TransferRequestRejecting) {
              ProgressBar.show(context);
            }
            if (state is TransferRequestRejected) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, StringConstants.kRequestRejected, '');
              Navigator.pop(context);
              context
                  .read<EquipmentTraceabilityBloc>()
                  .add(FetchMyRequest(pageNo: pageNo));
            }
            if (state is TransferRequestNotRejected) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          buildWhen: (previousState, currentState) =>
              (currentState is MyRequestFetching && pageNo == 1) ||
              (currentState is MyRequestFetched) ||
              currentState is MyRequestNotFetched,
          builder: (context, state) {
            if (state is MyRequestFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyRequestFetched) {
              var data = state.fetchMyRequestModel.data;
              return ListView.separated(
                  itemCount: data.transfers!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: ListTile(
                        title: Text(data.transfers![index].equipmentname!,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        subtitle: Text(data.transfers![index].equipmentcode!,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey)),
                        trailing: ViewMyRequestPopUp(
                          popUpMenuItems: state.popUpMenuItems,
                          requestId: data.transfers![index].id!,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  });
            } else if (state is MyRequestNotFetched) {
              return Center(
                  child: Text(DatabaseUtil.getText('no_records_found')));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
