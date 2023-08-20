import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../blocs/qualityManagement/qm_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'qm_details_screen.dart';
import 'qm_roles_screen.dart';
import 'qm_filters_screen.dart';
import 'report_new_qm.dart';
import 'widgets/qm_list_tile_subtitle.dart';
import 'widgets/qm_list_tile_titile.dart';

class QualityManagementListScreen extends StatefulWidget {
  static const routeName = 'QualityManagementListScreen';
  final bool isFromHome;

  const QualityManagementListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  State<QualityManagementListScreen> createState() =>
      _QualityManagementListScreenState();
}

class _QualityManagementListScreenState
    extends State<QualityManagementListScreen> {
  static bool noMoreData = false;
  static List qmListData = [];
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;
  static int page = 1;

  @override
  void initState() {
    page = 1;
    noMoreData = false;
    qmListData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(
        FetchQualityManagementList(pageNo: 1, isFromHome: widget.isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('QAReporting')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, ReportNewQA.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<QualityManagementBloc, QualityManagementStates>(
                  buildWhen: (previousState, currentState) {
                if (currentState is FetchingQualityManagementList &&
                    widget.isFromHome == true) {
                  return true;
                } else if (currentState is QualityManagementListFetched) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                if (state is QualityManagementListFetched) {
                  return CustomIconButtonRow(
                      secondaryOnPress: () {
                        Navigator.pushNamed(
                            context, QualityManagementRolesScreen.routeName);
                      },
                      primaryOnPress: () {
                        Navigator.pushNamed(
                            context, QualityManagementFilterScreen.routeName);
                      },
                      isEnabled: true,
                      clearVisible: state.filtersMap.isNotEmpty,
                      clearOnPress: () {
                        page = 1;
                        qmListData.clear();
                        noMoreData = false;
                        context
                            .read<QualityManagementBloc>()
                            .add(QualityManagementClearFilter());
                        context.read<QualityManagementBloc>().add(
                            FetchQualityManagementList(
                                isFromHome: widget.isFromHome, pageNo: 1));
                      });
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<QualityManagementBloc, QualityManagementStates>(
                  buildWhen: (previousState, currentState) =>
                      ((currentState is QualityManagementListFetched &&
                              noMoreData != true) ||
                          (currentState is FetchingQualityManagementList &&
                              page == 1)),
                  listener: (context, state) {
                    if (state is QualityManagementListFetched) {
                      if (state.fetchQualityManagementListModel.status == 204 &&
                          page != 1) {
                        noMoreData = true;
                        showCustomSnackBar(
                            context, StringConstants.kAllDataLoaded, '');
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingQualityManagementList) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()));
                    } else if (state is QualityManagementListFetched) {
                      if (state
                          .fetchQualityManagementListModel.data.isNotEmpty) {
                        if (page == 1) {
                          qmListData =
                              state.fetchQualityManagementListModel.data;
                        } else {
                          for (var item
                              in state.fetchQualityManagementListModel.data) {
                            qmListData.add(item);
                          }
                        }
                        waitForData = false;
                        return Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                controller: controller
                                  ..addListener(() {
                                    if (noMoreData != true &&
                                        waitForData == false) {
                                      if (controller.position.extentAfter <
                                          500) {
                                        page++;
                                        context
                                            .read<QualityManagementBloc>()
                                            .add(FetchQualityManagementList(
                                                pageNo: page,
                                                isFromHome: false));
                                        waitForData = true;
                                      }
                                    }
                                  }),
                                itemCount: qmListData.length,
                                itemBuilder: (context, index) {
                                  return CustomCard(
                                      child: ListTile(
                                          contentPadding: const EdgeInsets.all(
                                              xxTinierSpacing),
                                          title: QualityManagementListTileTitle(
                                              data: qmListData[index]),
                                          subtitle:
                                              QualityManagementListTileSubtitle(
                                                  data: qmListData[index]),
                                          onTap: () {
                                            Map qmListMap = {
                                              'id': qmListData[index].id,
                                              'refNo': qmListData[index].refno,
                                              'status': qmListData[index].status
                                            };
                                            Navigator.pushNamed(
                                                context,
                                                QualityManagementDetailsScreen
                                                    .routeName,
                                                arguments: qmListMap);
                                          }));
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: xxTinySpacing);
                                }));
                      } else {
                        if (state.fetchQualityManagementListModel.status ==
                            204) {
                          if (state.filtersMap.isEmpty) {
                            return const NoRecordsText(
                                text: StringConstants.kNoRecordsFilter);
                          } else {
                            return NoRecordsText(
                                text: DatabaseUtil.getText('no_records_found'));
                          }
                        } else {
                          return const SizedBox();
                        }
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
