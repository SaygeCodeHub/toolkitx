import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../configs/app_color.dart';

class WorkOrderAddPartsScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddPartsScreen';
  const WorkOrderAddPartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkOrderTabDetailsBloc>()
        .add(FetchAssignPartsList(pageNo: 1));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddParts')),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: BlocBuilder<WorkOrderTabDetailsBloc, WorkOrderTabDetailsStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingAssignParts ||
              currentState is AssignPartsFetched ||
              currentState is AssignPartsNotFetched,
          builder: (context, state) {
            if (state is FetchingAssignParts) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssignPartsFetched) {
              return ListView.separated(
                  itemCount: state.fetchAssignPartsModel.data.length,
                  itemBuilder: (context, index) {
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
                          Text(state.fetchAssignPartsModel.data[index].item,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black)),
                          const SizedBox(
                            height: tiniestSpacing,
                          ),
                          Text(
                              "${state.fetchAssignPartsModel.data[index].type} - ${state.fetchAssignPartsModel.data[index].code}",
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.grey)),
                          const SizedBox(
                            height: tinierSpacing,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: xSizedBoxWidth,
                                child: TextFieldWidget(
                                  onTextFieldChanged: (textField) {},
                                  hintText: StringConstants.kPlannedQuantity,
                                ),
                              ),
                              const CustomCard(
                                color: AppColor.blueGrey,
                                shape: CircleBorder(),
                                elevation: kElevation,
                                child: Padding(
                                  padding: EdgeInsets.all(xxxTinierSpacing),
                                  child: Icon(Icons.add),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: tiniestSpacing,
                    );
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
