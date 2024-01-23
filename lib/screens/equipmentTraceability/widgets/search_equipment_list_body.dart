import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_details_screen.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_list_screen.dart';
import 'package:toolkit/screens/equipmentTraceability/widgets/search_equipment_checkbox.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';

class SearchEquipmentListBody extends StatelessWidget {
  const SearchEquipmentListBody({
    super.key,
    required this.data,
  });

  final List data;

  @override
  Widget build(BuildContext context) {
    SearchEquipmentListScreen.codeList = [];
    return Expanded(
      child: ListView.separated(
          itemCount: (context.read<EquipmentTraceabilityBloc>().hasReachedMax)
              ? data.length
              : data.length + 1,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < data.length) {
              return CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(xxxTinierSpacing),
                  child: ListTile(
                    onTap: () {
                      Map searchEquipmentDetailsMap = {
                        "equipmentId": data[index].id,
                        "equipmentName": data[index].equipmentname
                      };
                      SearchEquipmentDetailsScreen.searchEquipmentDetailsMap =
                          searchEquipmentDetailsMap;
                      SearchEquipmentListScreen.isTransferScreen != true
                          ? Navigator.pushNamed(
                              context, SearchEquipmentDetailsScreen.routeName)
                          : null;
                    },
                    title: Text(data[index].equipmentname,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: xxTiniestSpacing),
                        Text(data[index].equipmentcode,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey)),
                        const SizedBox(height: xxTiniestSpacing),
                        Text(data[index].machinetype,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey)),
                      ],
                    ),
                    trailing: SearchEquipmentListScreen.isTransferScreen == true
                        ? SearchEquipmentCheckbox(
                            selectedCreatedForIdList: context
                                .read<EquipmentTraceabilityBloc>()
                                .equipmentCodeList,
                            data: data[index],
                            onCreatedForChanged: (List codeList) {
                              SearchEquipmentListScreen.codeList = codeList;
                            },
                            codeList: SearchEquipmentListScreen.codeList,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              );
            } else {
              SearchEquipmentListScreen.pageNo++;
              context.read<EquipmentTraceabilityBloc>().add(
                  FetchSearchEquipmentList(
                      pageNo: SearchEquipmentListScreen.pageNo,
                      isFromHome: false));
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
