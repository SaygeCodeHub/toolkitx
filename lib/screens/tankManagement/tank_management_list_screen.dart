import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class TankManagementListScreen extends StatelessWidget {
  static const routeName = 'TankManagementListScreen';
  final bool isFromHome;
  static int pageNo = 1;

  const TankManagementListScreen({super.key, this.isFromHome = false});

  @override
  Widget build(BuildContext context) {
    context
        .read<TankManagementBloc>()
        .add(FetchTankManagementList(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: const GenericAppBar(title: "Tank Management"),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: Column(children: [
              CustomIconButtonRow(
                  secondaryVisible: false,
                  isEnabled: true,
                  primaryOnPress: () {},
                  secondaryOnPress: () {},
                  clearOnPress: () {}),
              Expanded(child:
                  BlocBuilder<TankManagementBloc, TankManagementState>(
                      builder: (context, state) {
                if (state is TankManagementListFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TankManagementListFetched) {
                  var data = state.fetchTankManagementListModel.data;
                  return ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                title: Text(data[index].nominationNo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.black)),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: xxxTinierSpacing,
                                      ),
                                      Text(
                                        data[index].announce,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.grey),
                                      ),
                                      const SizedBox(height: xxxTinierSpacing),
                                      Text(
                                        data[index].date,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.grey),
                                      ),
                                      const SizedBox(
                                        height: xxxTinierSpacing,
                                      ),
                                      Text(
                                        data[index].contractname,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.grey),
                                      ),
                                      const SizedBox(height: xxxTinierSpacing)
                                    ]),
                                trailing: Text(data[index].status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xSmall
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.deepBlue))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinierSpacing);
                      });
                } else if (state is TankManagementNotFetched) {
                  return const Center(
                      child: Text(StringConstants.kNoRecordsFound));
                }
                return const SizedBox.shrink();
              }))
            ])));
  }
}
