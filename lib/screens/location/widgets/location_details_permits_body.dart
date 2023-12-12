import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_permits_model.dart';
import '../../../widgets/custom_card.dart';
import 'location_details_permits_tab.dart';

class LocationDetailsPermitsBody extends StatelessWidget {
  final List<LocationPermitsDatum> locationPermits;
  final bool locationPermitListReachedMax;

  const LocationDetailsPermitsBody(
      {Key? key,
      required this.locationPermits,
      required this.locationPermitListReachedMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: locationPermitListReachedMax
              ? locationPermits.length
              : locationPermits.length + 1,
          itemBuilder: (context, index) {
            if (index < locationPermits.length) {
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(locationPermits[index].permit,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(width: tiniestSpacing),
                            Text(locationPermits[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locationPermits[index].description,
                          style: Theme.of(context).textTheme.xSmall),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset("assets/icons/calendar.png",
                              height: kIconSize, width: kIconSize),
                          const SizedBox(width: tiniestSpacing),
                          Text(locationPermits[index].schedule,
                              style: Theme.of(context).textTheme.xSmall)
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                      Text(locationPermits[index].pcompany,
                          style: Theme.of(context).textTheme.xSmall),
                    ],
                  ),
                ),
              );
            } else {
              LocationDetailsPermitsTab.pageNo++;
              context.read<LocationBloc>().add(FetchLocationPermits(
                  pageNo: LocationDetailsPermitsTab.pageNo));
              return const Center(child: CircularProgressIndicator());
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
