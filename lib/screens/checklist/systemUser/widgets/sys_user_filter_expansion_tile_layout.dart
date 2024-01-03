import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/string_extension.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/error_section.dart';

typedef FilterCategoryCallBack = Function(String categoryId);

class FilterExpansionTileLayout extends StatelessWidget {
  final FilterCategoryCallBack onCategoryChanged;

  const FilterExpansionTileLayout({Key? key, required this.onCategoryChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SysUserCheckListBloc, SysUserCheckListStates>(
        buildWhen: (previousState, currentState) =>
            currentState is CheckListCategoryFetched ||
            currentState is FetchingCheckListCategory,
        builder: (context, state) {
          if (state is FetchingCheckListCategory) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CheckListCategoryFetched) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    collapsedShape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: AppColor.grey,
                      width: kExpansionBorderWidth,
                    )),
                    maintainState: true,
                    key: GlobalKey(),
                    title: Text(
                        state.categoryName == ""
                            ? StringConstants.kSelectCategory
                            : state.categoryName.capitalize(),
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.getFilterCategoryData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: kExpansionTileMargin,
                                    right: kExpansionTileMargin),
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.getFilterCategoryData
                                        .elementAt(index)
                                        .name
                                        .capitalize(),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.getFilterCategoryData
                                    .elementAt(index)
                                    .name,
                                groupValue: state.categoryName,
                                onChanged: (value) {
                                  value = state.getFilterCategoryData
                                      .elementAt(index)
                                      .name;
                                  onCategoryChanged(state.getFilterCategoryData
                                      .elementAt(index)
                                      .id
                                      .toString());
                                  context.read<SysUserCheckListBloc>().add(
                                      ChangeCheckListCategory(
                                          getFilterCategoryData:
                                              state.getFilterCategoryData,
                                          categoryName: value,
                                          categoryId: state
                                              .getFilterCategoryData
                                              .elementAt(index)
                                              .id
                                              .toString()));
                                });
                          })
                    ]));
          } else if (state is CheckListCategoryNotFetched) {
            return Center(
                child: GenericReloadButton(
                    onPressed: () {
                      context
                          .read<SysUserCheckListBloc>()
                          .add(FetchCheckListMaster());
                    },
                    textValue: StringConstants.kReload));
          } else {
            return const SizedBox();
          }
        });
  }
}
