import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/equipmentTraceability/equipment_traceability_bloc.dart';
import 'package:toolkit/screens/equipmentTraceability/search_equipment_filter_screen.dart';

import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'widgets/search_equipment_list_body.dart';

class SearchEquipmentListScreen extends StatelessWidget {
  const SearchEquipmentListScreen({super.key, this.isFromHome = true});

  static const routeName = 'SearchEquipmentListScreen';
  static int pageNo = 1;
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<EquipmentTraceabilityBloc>().hasReachedMax = false;
    context.read<EquipmentTraceabilityBloc>().searchEquipmentDatum.clear();
    context
        .read<EquipmentTraceabilityBloc>()
        .add(FetchSearchEquipmentList(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSearchEquipment),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<EquipmentTraceabilityBloc,
                  EquipmentTraceabilityState>(
                buildWhen: (previousState, currentState) {
                  if (currentState is SearchEquipmentListFetching &&
                      isFromHome == true) {
                    return true;
                  } else if (currentState is SearchEquipmentListFetched) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is SearchEquipmentListFetched) {
                    return CustomIconButtonRow(
                        primaryOnPress: () {
                          Navigator.pushNamed(
                              context, SearchEquipmentFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        secondaryVisible: false,
                        clearVisible:
                            state.filtersMap.isNotEmpty && isFromHome != true,
                        clearOnPress: () {
                          pageNo = 1;
                          context
                              .read<EquipmentTraceabilityBloc>()
                              .hasReachedMax = false;
                          context
                              .read<EquipmentTraceabilityBloc>()
                              .searchEquipmentDatum
                              .clear();
                          context
                              .read<EquipmentTraceabilityBloc>()
                              .add(ClearSearchEquipmentFilter());
                          context.read<EquipmentTraceabilityBloc>().add(
                              FetchSearchEquipmentList(
                                  pageNo: 1, isFromHome: isFromHome));
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              BlocConsumer<EquipmentTraceabilityBloc,
                      EquipmentTraceabilityState>(
                  buildWhen: (previousState, currentState) =>
                      (currentState is SearchEquipmentListFetching &&
                          pageNo == 1) ||
                      (currentState is SearchEquipmentListFetched),
                  listener: (context, state) {
                    if (state is SearchEquipmentListFetched &&
                        context
                            .read<EquipmentTraceabilityBloc>()
                            .hasReachedMax) {
                      showCustomSnackBar(
                          context, StringConstants.kAllDataLoaded, '');
                    }
                  },
                  builder: (context, state) {
                    if (state is SearchEquipmentListFetching) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is SearchEquipmentListFetched) {
                      if (state.data.isNotEmpty) {
                        return SearchEquipmentListBody(data: state.data);
                      } else {
                        return NoRecordsText(
                            text: DatabaseUtil.getText('no_records_found'));
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
            ])));
  }
}
