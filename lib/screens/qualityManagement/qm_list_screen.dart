import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../blocs/qualityManagement/qm_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';

class QualityManagementListScreen extends StatefulWidget {
  static const routeName = 'QualityManagementListScreen';

  const QualityManagementListScreen({Key? key}) : super(key: key);

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
    context
        .read<QualityManagementBloc>()
        .add(FetchQualityManagementList(pageNo: 1));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ReportanIncident')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomIconButtonRow(
                    primaryOnPress: () {},
                    secondaryOnPress: () {},
                    isEnabled: true,
                    clearOnPress: () {})
              ]),
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
                                                pageNo: page));
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
                                          title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: xxTinierSpacing),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        qmListData[index].refno,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .small
                                                            .copyWith(
                                                                color: AppColor
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    const SizedBox(
                                                        width: tinierSpacing),
                                                    Text(
                                                        qmListData[index]
                                                            .status,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .xxSmall
                                                            .copyWith(
                                                                color: AppColor
                                                                    .deepBlue))
                                                  ])),
                                          subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    qmListData[index]
                                                        .description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Text(qmListData[index].location,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color:
                                                                AppColor.grey)),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Row(children: [
                                                  Image.asset(
                                                      "assets/icons/calendar.png",
                                                      height: kIconSize,
                                                      width: kIconSize),
                                                  const SizedBox(
                                                      width: tiniestSpacing),
                                                  Text(
                                                      qmListData[index]
                                                          .eventdatetime,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .xSmall
                                                          .copyWith(
                                                              color: AppColor
                                                                  .grey))
                                                ]),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                              ]),
                                          onTap: () {}));
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: xxTinySpacing);
                                }));
                      } else {
                        if (state.fetchQualityManagementListModel.status ==
                            204) {
                          return NoRecordsText(
                              text: DatabaseUtil.getText('no_records_found'));
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
