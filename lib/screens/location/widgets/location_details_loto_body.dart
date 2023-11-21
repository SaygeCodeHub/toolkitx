import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_loto_model.dart';
import '../../../widgets/custom_card.dart';
import 'location_details_loto_tab.dart';

class LocationDetailsLoToBody extends StatelessWidget {
  final List<LocationLotoDatum> locationLoTos;
  final bool locationLoToListReachedMax;

  const LocationDetailsLoToBody(
      {Key? key,
      required this.locationLoTos,
      required this.locationLoToListReachedMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: locationLoToListReachedMax
              ? locationLoTos.length
              : locationLoTos.length + 1,
          itemBuilder: (context, index) {
            if (index < locationLoTos.length) {
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(locationLoTos[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(width: tiniestSpacing),
                            Text(locationLoTos[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset("assets/icons/calendar.png",
                              height: kIconSize, width: kIconSize),
                          const SizedBox(width: tiniestSpacing),
                          Text(locationLoTos[index].date,
                              style: Theme.of(context).textTheme.xSmall)
                        ],
                      ),
                      const SizedBox(height: tinierSpacing),
                      Text(locationLoTos[index].purpose,
                          style: Theme.of(context).textTheme.xSmall),
                    ],
                  ),
                ),
              );
            } else {
              LocationDetailsLoToTab.pageNo++;
              context.read<LocationBloc>().add(
                  FetchLocationLoTo(pageNo: LocationDetailsLoToTab.pageNo));
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
