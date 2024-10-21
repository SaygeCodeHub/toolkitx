import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/incident/widgets/incident_details_body.dart';
import 'package:toolkit/screens/incident/widgets/incident_list_subtitle.dart';
import 'package:toolkit/screens/incident/widgets/incident_list_title.dart';
import '../../blocs/imagePickerBloc/image_picker_bloc.dart';
import '../../blocs/imagePickerBloc/image_picker_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_no_records_text.dart';
import '../../widgets/text_button.dart';
import 'category_screen.dart';
import 'change_role_screen.dart';
import 'incident_details_screen.dart';
import 'incident_filter_screen.dart';

class IncidentListScreen extends StatefulWidget {
  static const routeName = 'IncidentListScreen';
  final bool isFromHome;

  const IncidentListScreen({super.key, this.isFromHome = false});

  @override
  State<IncidentListScreen> createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  static bool noMoreData = false;
  static List incidentListData = [];
  var controller = ScrollController(keepScrollOffset: true);
  static bool waitForData = false;
  static int page = 1;

  @override
  void initState() {
    page = 1;
    noMoreData = false;
    incidentListData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<IncidentLisAndFilterBloc>()
        .add(FetchIncidentListEvent(isFromHome: widget.isFromHome, page: 1));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ReportanIncident')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<ImagePickerBloc>().pickedImagesList.clear();
              context.read<ImagePickerBloc>().add(PickImageInitial());
              CategoryScreen.isFromEdit = false;
              CategoryScreen.addAndEditIncidentMap = {};
              Navigator.pushNamed(context, CategoryScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<IncidentLisAndFilterBloc,
                        IncidentListAndFilterStates>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is FetchingIncidents &&
                      widget.isFromHome == true) {
                    return true;
                  } else if (currentState is IncidentsFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is IncidentsFetched) {
                    return Visibility(
                        visible: state.filterMap.isNotEmpty,
                        child: CustomTextButton(
                            onPressed: () {
                              page = 1;
                              incidentListData.clear();
                              noMoreData = false;
                              context
                                  .read<IncidentLisAndFilterBloc>()
                                  .add(const ClearIncidentFilters());
                              context.read<IncidentLisAndFilterBloc>().add(
                                  FetchIncidentListEvent(
                                      isFromHome: widget.isFromHome, page: 1));
                            },
                            textValue: DatabaseUtil.getText('Clear')));
                  } else {
                    return const SizedBox();
                  }
                }),
                CustomIconButtonRow(
                    primaryOnPress: () {
                      Navigator.pushNamed(
                          context, IncidentFilterScreen.routeName);
                    },
                    secondaryOnPress: () {
                      Navigator.pushNamed(
                          context, IncidentChangeRoleScreen.routeName);
                    },
                    isEnabled: true,
                    clearOnPress: () {})
              ]),
              const SizedBox(height: xxTinierSpacing),
              BlocConsumer<IncidentLisAndFilterBloc,
                      IncidentListAndFilterStates>(
                  buildWhen: (previousState, currentState) =>
                      ((currentState is IncidentsFetched &&
                              noMoreData != true) ||
                          (currentState is FetchingIncidents && page == 1)),
                  listener: (context, state) {
                    if (state is FetchingIncidents) {}
                    if (state is IncidentsFetched) {
                      if (state.fetchIncidentsListModel.status == 204 &&
                          page != 1) {
                        noMoreData = true;
                        showCustomSnackBar(
                            context, StringConstants.kAllDataLoaded, '');
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchingIncidents) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 3.5),
                              child: const CircularProgressIndicator()));
                    } else if (state is IncidentsFetched) {
                      if (state.fetchIncidentsListModel.data!.isNotEmpty) {
                        if (page == 1) {
                          incidentListData =
                              state.fetchIncidentsListModel.data!;
                        } else {
                          for (var item
                              in state.fetchIncidentsListModel.data!) {
                            incidentListData.add(item);
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
                                            .read<IncidentLisAndFilterBloc>()
                                            .add(FetchIncidentListEvent(
                                                isFromHome: false, page: page));
                                        waitForData = true;
                                      }
                                    }
                                  }),
                                shrinkWrap: true,
                                itemCount: incidentListData.length,
                                itemBuilder: (context, index) {
                                  return CustomCard(
                                      child: ListTile(
                                          contentPadding: const EdgeInsets.all(
                                              xxTinierSpacing),
                                          title: IncidentListTitle(
                                              incidentListDatum:
                                                  incidentListData[index]),
                                          subtitle: IncidentListSubtitle(
                                              incidentListDatum:
                                                  incidentListData[index]),
                                          onTap: () {
                                            IncidentDetailsBody.refNo = state
                                                .fetchIncidentsListModel
                                                .data![index]
                                                .refno;
                                            Navigator.pushNamed(
                                                    context,
                                                    IncidentDetailsScreen
                                                        .routeName,
                                                    arguments:
                                                        incidentListData[index]
                                                            .id)
                                                .then((_) {
                                              if (context.mounted) {
                                                context
                                                    .read<
                                                        IncidentLisAndFilterBloc>()
                                                    .add(FetchIncidentListEvent(
                                                        isFromHome:
                                                            widget.isFromHome,
                                                        page: 1));
                                              }
                                            });
                                          }));
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: xxTinySpacing);
                                }));
                      } else {
                        if (state.fetchIncidentsListModel.status == 204) {
                          if (state.filterMap.isEmpty) {
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
                      return const SizedBox();
                    }
                  }),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
