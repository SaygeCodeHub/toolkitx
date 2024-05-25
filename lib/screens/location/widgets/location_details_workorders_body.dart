import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_workorders_model.dart';
import '../../../widgets/custom_card.dart';
import '../../workorder/workorder_details_tab_screen.dart';
import 'location_details_workorders_tab.dart';

class LocationDetailsWorkOrdersBody extends StatelessWidget {
  final List<LocationWorkOrdersDatum> workOrderLocations;
  final bool workOrderLoToListReachedMax;

  const LocationDetailsWorkOrdersBody(
      {Key? key,
      required this.workOrderLocations,
      required this.workOrderLoToListReachedMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: workOrderLoToListReachedMax
              ? workOrderLocations.length
              : workOrderLocations.length + 1,
          itemBuilder: (context, index) {
            if (index < workOrderLocations.length) {
              return CustomCard(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, WorkOrderDetailsTabScreen.routeName,
                        arguments: workOrderLocations[index].id);
                  },
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(workOrderLocations[index].woname,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(width: tiniestSpacing),
                            Text(workOrderLocations[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(workOrderLocations[index].subject,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset("assets/icons/calendar.png",
                              height: kIconSize, width: kIconSize),
                          const SizedBox(width: tiniestSpacing),
                          Text(workOrderLocations[index].schedule,
                              style: Theme.of(context).textTheme.xSmall)
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                      Text(
                          '${workOrderLocations[index].contractorname} - ${workOrderLocations[index].type}',
                          style: Theme.of(context).textTheme.xSmall),
                    ],
                  ),
                ),
              );
            } else {
              LocationDetailsWorkOrdersTab.pageNo++;
              context.read<LocationBloc>().add(FetchLocationWorkOrders(
                  pageNo: LocationDetailsWorkOrdersTab.pageNo));
              return const Center(child: CircularProgressIndicator());
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
