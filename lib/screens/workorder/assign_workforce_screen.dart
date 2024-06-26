import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../blocs/workorder/workorder_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/assign_workforce_body.dart';

class AssignWorkForceScreen extends StatelessWidget {
  static const routeName = 'AssignWorkForceScreen';
  static String workOrderWorkforceName = '';
  static int pageNo = 1;
  static bool isWorkforceSearched = false;
  static TextEditingController workforceNameController =
      TextEditingController();

  const AssignWorkForceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkOrderTabDetailsBloc>().add(FetchAssignWorkForceList(
        pageNo: 1,
        workOrderWorkforceName: '',
        workOrderId: context.read<WorkOrderBloc>().workOrderId));
    context.read<WorkOrderTabDetailsBloc>().assignWorkForceListReachedMax =
        false;
    context.read<WorkOrderTabDetailsBloc>().add(
        SearchWorkOrderWorkforce(isWorkforceSearched: isWorkforceSearched));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('assign_workforce')),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: xxxSmallestSpacing),
                  child: TextFormField(
                      controller: workforceNameController,
                      onChanged: (value) {
                        context
                            .read<WorkOrderTabDetailsBloc>()
                            .workOrderWorkforceName = value;
                      },
                      decoration: InputDecoration(
                          suffixIcon: BlocBuilder<WorkOrderTabDetailsBloc,
                              WorkOrderTabDetailsStates>(
                            buildWhen: (previousState, currentState) =>
                                currentState
                                    is WorkOrderAssignWorkforceSearched,
                            builder: (context, state) {
                              if (state is WorkOrderAssignWorkforceSearched) {
                                return CustomIconButton(
                                    onPressed: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (workforceNameController.text != '' ||
                                          workforceNameController.text.trim() !=
                                              '') {
                                        isWorkforceSearched =
                                            !isWorkforceSearched;
                                        pageNo = 1;
                                        context
                                            .read<WorkOrderTabDetailsBloc>()
                                            .assignWorkForceDatum = [];
                                        context
                                            .read<WorkOrderTabDetailsBloc>()
                                            .docListReachedMax = false;
                                        context
                                            .read<WorkOrderTabDetailsBloc>()
                                            .add(SearchWorkOrderWorkforce(
                                                isWorkforceSearched:
                                                    isWorkforceSearched));
                                      }
                                    },
                                    icon: (state.isWorkforceSearched == false)
                                        ? Icons.search
                                        : Icons.clear);
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(color: AppColor.grey),
                          hintText: StringConstants.kSearch,
                          contentPadding:
                              const EdgeInsets.all(xxxTinierSpacing),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.lightGrey)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.lightGrey)),
                          filled: true,
                          fillColor: AppColor.white))),
              const AssignWorkForceBody(),
            ],
          ),
        ));
  }
}
