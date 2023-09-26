import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/workorder/widgets/workorder_add_parts_screen.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_assign_parts_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_text_field.dart';

class AddPartsListBody extends StatelessWidget {
  const AddPartsListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is FetchingAssignParts) ||
                (currentState is AssignPartsFetched &&
                    WorkOrderAddPartsScreen.pageNo == 1)) ||
            currentState is AssignPartsNotFetched,
        listener: (context, state) {
          if (state is AssignPartsFetched) {
            if (state.fetchAssignPartsModel.status == 204) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingAssignParts) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssignPartsFetched) {
            if (context
                .read<WorkOrderTabDetailsBloc>()
                .addPartsDatum
                .isNotEmpty) {
              return SearchableList.seperated(
                  initialList: state.fetchAssignPartsModel.data,
                  builder: (AddPartsDatum addPartsDatum) {
                    if(WorkOrderAddPartsScreen.pageNo < context.read<WorkOrderTabDetailsBloc>().addPartsDatum.length){
                      return CustomCard(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: xxxTinierSpacing,
                                  right: xxxTinierSpacing,
                                  top: xxTinierSpacing,
                                  bottom: tinierSpacing),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(addPartsDatum.item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.black)),
                                    const SizedBox(height: tiniestSpacing),
                                    Text(
                                        "${addPartsDatum.type} - ${addPartsDatum.code}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.grey)),
                                    const SizedBox(height: tinierSpacing),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: xSizedBoxWidth,
                                              child: TextFieldWidget(
                                                  onTextFieldChanged:
                                                      (textField) {

                                                  },
                                                  hintText: StringConstants
                                                      .kPlannedQuantity)),
                                          const CustomCard(
                                              color: AppColor.blueGrey,
                                              shape: CircleBorder(),
                                              elevation: kElevation,
                                              child: Padding(
                                                  padding: EdgeInsets.all(
                                                      xxxTinierSpacing),
                                                  child: Icon(Icons.add)))
                                        ])
                                  ])));
                    } else if (!context
                        .read<WorkOrderTabDetailsBloc>()
                        .docListReachedMax) {
                      WorkOrderAddPartsScreen.pageNo++;
                      context.read<WorkOrderTabDetailsBloc>().add((FetchAssignPartsList(
                          pageNo: WorkOrderAddPartsScreen.pageNo)));
                      return const Center(
                          child: Padding(
                              padding: EdgeInsets.all(
                                  kCircularProgressIndicatorPadding),
                              child: SizedBox(
                                  width: kCircularProgressIndicatorWidth,
                                  child: CircularProgressIndicator())));
                    } else {
                      return const SizedBox.shrink();
                    }

                  },
                  filter: (value) => state.fetchAssignPartsModel.data
                      .where((element) => element.item
                          .toLowerCase()
                          .contains(value.toLowerCase().trim()))
                      .toList(),
                  inputDecoration: InputDecoration(
                      suffix: const SizedBox(),
                      suffixIcon:
                          const Icon(Icons.search_sharp, size: kIconSize),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.grey),
                      hintText: StringConstants.kSearchPartName,
                      contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.lightGrey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      filled: true,
                      fillColor: AppColor.white),
                  seperatorBuilder: (BuildContext context, int height) {
                    return const SizedBox(height: tinierSpacing);
                  });
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
