import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/equipment_details_tabs_util.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/custom_tabbar_view.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import 'widgets/equipment_details_tab_one.dart';
import 'widgets/equipment_details_tab_two.dart';
import 'widgets/search_equipment_poup_menu_button.dart';

class SearchEquipmentDetailsScreen extends StatelessWidget {
  const SearchEquipmentDetailsScreen(
      {super.key, required this.searchEquipmentDetailsMap});

  static const routeName = 'EquipmentDetailsScreen';
  final Map searchEquipmentDetailsMap;

  @override
  Widget build(BuildContext context) {
    context.read<EquipmentTraceabilityBloc>().add(FetchSearchEquipmentDetails(
        equipmentId: searchEquipmentDetailsMap["equipmentId"]));
    return Scaffold(
      appBar: GenericAppBar(
          title: searchEquipmentDetailsMap["equipmentName"],
          actions: [
            BlocConsumer<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
              listener: (context, state) {
                if (state is EquipmentLocationSaving) {
                  ProgressBar.show(context);
                } else if (state is EquipmentLocationSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, StringConstants.kLocationSavedSuccessfully, '');
                } else if (state is EquipmentLocationNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.errorMessage, '');
                }
              },
              buildWhen: (previousState, currentState) =>
                  currentState is SearchEquipmentDetailsFetched,
              builder: (context, state) {
                if (state is SearchEquipmentDetailsFetched) {
                  if (state.showPopMenu == true) {
                    return SearchEquipmentPopupMenuButton(
                      popupItems: state.popUpMenuItems,
                      searchEquipmentDetailsMap: searchEquipmentDetailsMap,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ]),
      body: BlocBuilder<EquipmentTraceabilityBloc, EquipmentTraceabilityState>(
        buildWhen: (previousState, currentState) =>
            currentState is SearchEquipmentDetailsFetching ||
            currentState is SearchEquipmentDetailsFetched ||
            currentState is SearchEquipmentDetailsNotFetched,
        builder: (context, state) {
          if (state is SearchEquipmentDetailsFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchEquipmentDetailsFetched) {
            var data = state.fetchSearchEquipmentDetailsModel.data;
            Map detailsMap = {
              "equipmentId": searchEquipmentDetailsMap["equipmentId"],
              "equipmentName": searchEquipmentDetailsMap["equipmentName"],
              "clientId": state.clientId,
            };
            return Column(
              children: [
                CustomTabBarView(
                    tabBarViewIcons: EquipmentDetailsTabsUtil().tabBarViewIcons,
                    tabBarViewWidgets: [
                      EquipmentDetailsTabOne(tabIndex: 0, data: data),
                      EquipmentDetailsTabTwo(
                          tabIndex: 1,
                          searchEquipmentDetailsData: data,
                          detailsMap: detailsMap),
                    ],
                    lengthOfTabs: 2),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
