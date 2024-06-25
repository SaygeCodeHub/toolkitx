import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_list_card.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../../widgets/text_button.dart';
import 'sys_user_change_role_screen.dart';
import 'sys_user_filters_screen.dart';

class SystemUserCheckListScreen extends StatefulWidget {
  static const routeName = 'SystemUserCheckListScreen';
  final bool isFromHome;

  const SystemUserCheckListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  State<SystemUserCheckListScreen> createState() =>
      _SystemUserCheckListScreenState();
}

class _SystemUserCheckListScreenState extends State<SystemUserCheckListScreen> {
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;
  static List checkListData = [];
  static bool noMoreData = false;
  static int page = 1;

  @override
  void initState() {
    page = 1;
    noMoreData = false;
    checkListData.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<SysUserCheckListBloc>()
        .add(FetchCheckList(isFromHome: widget.isFromHome, page: 1));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<SysUserCheckListBloc, SysUserCheckListStates>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is FetchingCheckList &&
                      widget.isFromHome == true) {
                    return true;
                  } else if (currentState is CheckListFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is CheckListFetched) {
                    return Visibility(
                        visible: state.filterData != '{}',
                        child: CustomTextButton(
                            onPressed: () {
                              page = 1;
                              checkListData.clear();
                              noMoreData = false;
                              context
                                  .read<SysUserCheckListBloc>()
                                  .add(ClearCheckListFilter());
                              context.read<SysUserCheckListBloc>().add(
                                  FetchCheckList(isFromHome: false, page: 1));
                            },
                            textValue: DatabaseUtil.getText('Clear')));
                  } else {
                    return const SizedBox();
                  }
                }),
                CustomIconButtonRow(
                    primaryOnPress: () {
                      Navigator.pushNamed(context, FiltersScreen.routeName);
                    },
                    secondaryOnPress: () {
                      Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                    },
                    isEnabled: true,
                    clearOnPress: () {})
              ]),
              const SizedBox(height: tiniestSpacing),
              BlocConsumer<SysUserCheckListBloc, SysUserCheckListStates>(
                  buildWhen: (previousState, currentState) =>
                      ((currentState is CheckListFetched &&
                              noMoreData != true) ||
                          (currentState is FetchingCheckList && page == 1)),
                  listener: (context, state) {
                    if (state is CheckListFetched) {
                      if (state.getChecklistModel.status == 204 &&
                          checkListData.isNotEmpty) {
                        noMoreData = true;
                        showCustomSnackBar(
                            context, StringConstants.kAllDataLoaded, '');
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is CheckListFetched) {
                      if (state.getChecklistModel.data!.isNotEmpty) {
                        if (page == 1) {
                          checkListData = state.getChecklistModel.data!;
                        } else {
                          for (var item in state.getChecklistModel.data!) {
                            checkListData.add(item);
                          }
                        }
                        waitForData = false;
                        return Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                controller: controller
                                  ..addListener(() {
                                    if (noMoreData != true &&
                                        waitForData == false) {
                                      if (controller.position.extentAfter <
                                          500) {
                                        page++;
                                        context
                                            .read<SysUserCheckListBloc>()
                                            .add(FetchCheckList(
                                                isFromHome: false, page: page));
                                        waitForData = true;
                                      }
                                    }
                                  }),
                                shrinkWrap: true,
                                itemCount: checkListData.length,
                                itemBuilder: (context, index) {
                                  return SystemUserListCard(
                                      checkListDatum: checkListData[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: xxTinySpacing);
                                }));
                      } else {
                        if (state.getChecklistModel.status == 204) {
                          if (state.filterData == '{}') {
                            return NoRecordsText(
                                text: DatabaseUtil.getText('no_records_found'));
                          } else {
                            return const NoRecordsText(
                                text: StringConstants.kNoRecordsFilter);
                          }
                        } else {
                          return const SizedBox();
                        }
                      }
                    } else if (state is FetchingCheckList) {
                      return Center(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            child: const CircularProgressIndicator()),
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
            ])));
  }
}
