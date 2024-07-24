import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tankManagement/tank_management_details_screen.dart';
import 'package:toolkit/screens/tankManagement/tank_management_list_screen.dart';
import 'package:toolkit/widgets/custom_card.dart';

class TankManagementListBody extends StatelessWidget {
  const TankManagementListBody({super.key, required this.tankDatum});

  final List tankDatum;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: context.read<TankManagementBloc>().hasReachedMax
            ? tankDatum.length
            : tankDatum.length + 1,
        itemBuilder: (context, index) {
          if (index < tankDatum.length) {
            return CustomCard(
                child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, TankManagementDetailsScreen.routeName,
                          arguments: tankDatum[index].id);
                    },
                    title: Text(tankDatum[index].nominationNo,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: xxxTinierSpacing,
                          ),
                          Text(
                            tankDatum[index].announce,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey),
                          ),
                          const SizedBox(height: xxxTinierSpacing),
                          Text(
                            tankDatum[index].date,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey),
                          ),
                          const SizedBox(
                            height: xxxTinierSpacing,
                          ),
                          Text(
                            tankDatum[index].contractname,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.grey),
                          ),
                          const SizedBox(height: xxxTinierSpacing)
                        ]),
                    trailing: Text(tankDatum[index].status,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.deepBlue))));
          } else {
            TankManagementListScreen.pageNo++;
            context.read<TankManagementBloc>().add(FetchTankManagementList(
                pageNo: TankManagementListScreen.pageNo, isFromHome: false));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
