import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';

class SearchEquipmentListScreen extends StatelessWidget {
  const SearchEquipmentListScreen({super.key});

  static const routeName = 'SearchEquipmentListScreen';
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context
        .read<EquipmentTraceabilityBloc>()
        .add(FetchSearchEquipmentList(pageNo: pageNo));
    return Scaffold(
        appBar: const GenericAppBar(title: 'Search Equipment'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            children: [
              CustomIconButtonRow(
                  primaryOnPress: () {},
                  secondaryOnPress: () {},
                  secondaryVisible: false,
                  clearOnPress: () {}),
              BlocBuilder<EquipmentTraceabilityBloc,
                  EquipmentTraceabilityState>(
                builder: (context, state) {
                  if (state is SearchEquipmentListFetching) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is SearchEquipmentListFetched) {
                    var data = state.fetchSearchEquipmentModel.data;
                    return Expanded(
                      child: ListView.separated(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomCard(
                              child: Padding(
                                padding: const EdgeInsets.all(xxxTinierSpacing),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(data[index].equipmentname,
                                      style: Theme.of(context)
                                          .textTheme
                                          .small
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.black)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: xxTiniestSpacing),
                                      Text(data[index].equipmentcode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey)),
                                      const SizedBox(height: xxTiniestSpacing),
                                      Text(data[index].machinetype,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: tinierSpacing);
                          }),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
