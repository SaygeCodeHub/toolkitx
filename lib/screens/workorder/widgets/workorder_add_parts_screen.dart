import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import 'package:toolkit/blocs/workorder/workorder_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import 'add_parts_list_body.dart';

class WorkOrderAddPartsScreen extends StatelessWidget {
  static const routeName = 'WorkOrderAddPartsScreen';

  const WorkOrderAddPartsScreen({super.key});

  static String partName = '';
  static int pageNo = 1;
  static bool isSearched = false;
  static TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<WorkOrderTabDetailsBloc>().add(FetchAssignPartsList(
          pageNo: pageNo,
          partName: '',
          workOrderId: context.read<WorkOrderBloc>().workOrderId,
        ));
    context.read<WorkOrderTabDetailsBloc>().docListReachedMax = false;
    context
        .read<WorkOrderTabDetailsBloc>()
        .add(SearchParts(isSearched: isSearched));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('AddParts')),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftRightMargin,
          right: leftRightMargin,
          top: xxTinierSpacing,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: xxxSmallestSpacing),
              child: TextFormField(
                  controller: nameController,
                  onChanged: (value) {
                    context.read<WorkOrderTabDetailsBloc>().partName = value;
                  },
                  decoration: InputDecoration(
                      suffix: const SizedBox(),
                      suffixIcon: BlocBuilder<WorkOrderTabDetailsBloc,
                          WorkOrderTabDetailsStates>(
                        buildWhen: (previousState, currentState) =>
                            currentState is WorkOrderAddPartsListSearched,
                        builder: (context, state) {
                          if (state is WorkOrderAddPartsListSearched) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: kSearchIconHeight),
                              child: CustomIconButton(
                                onPressed: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (nameController.text != '' ||
                                      nameController.text.trim() != '') {
                                    isSearched = !isSearched;
                                    AddPartsListBody.isFirst = true;
                                    pageNo = 1;
                                    context
                                        .read<WorkOrderTabDetailsBloc>()
                                        .addPartsDatum = [];
                                    context
                                        .read<WorkOrderTabDetailsBloc>()
                                        .docListReachedMax = false;
                                    context.read<WorkOrderTabDetailsBloc>().add(
                                        SearchParts(isSearched: isSearched));
                                  }
                                },
                                icon: (state.isSearched == false)
                                    ? Icons.search
                                    : Icons.clear,
                              ),
                            );
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
                      contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      filled: true,
                      fillColor: AppColor.white)),
            ),
            const AddPartsListBody(),
          ],
        ),
      ),
    );
  }
}
