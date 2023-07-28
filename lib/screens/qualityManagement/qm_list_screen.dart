import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/qualityManagement/qm_bloc.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../blocs/qualityManagement/qm_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';

class QualityManagementListScreen extends StatelessWidget {
  static const routeName = 'QualityManagementListScreen';

  const QualityManagementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<QualityManagementBloc>().add(FetchQualityManagementList());
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
                  listener: (context, state) {},
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
                        return Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.fetchQualityManagementListModel
                                    .data.length,
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
                                                        state
                                                            .fetchQualityManagementListModel
                                                            .data[index]
                                                            .refno,
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
                                                        state
                                                            .fetchQualityManagementListModel
                                                            .data[index]
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
                                                    state
                                                        .fetchQualityManagementListModel
                                                        .data[index]
                                                        .description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Text(
                                                    state
                                                        .fetchQualityManagementListModel
                                                        .data[index]
                                                        .location,
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
                                                      state
                                                          .fetchQualityManagementListModel
                                                          .data[index]
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
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
