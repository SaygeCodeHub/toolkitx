import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/trip_details_screen.dart';
import 'package:toolkit/screens/trips/trips_list_screen.dart';

import '../../../blocs/trips/trip_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';

class TripListBody extends StatelessWidget {
  const TripListBody({super.key, required this.tripListDatum});

  final List tripListDatum;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: context.read<TripBloc>().hasReachedMax
            ? tripListDatum.length
            : tripListDatum.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < tripListDatum.length) {
            return CustomCard(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: xxTinierSpacing),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, TripsDetailsScreen.routeName,
                      arguments: tripListDatum[index].id);
                },
                title: Text(tripListDatum[index].vessel,
                    style: Theme.of(context).textTheme.small.copyWith(
                        fontWeight: FontWeight.w600, color: AppColor.black)),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: tinierSpacing),
                      Text(
                          '${tripListDatum[index].departuredatetime} - ${tripListDatum[index].arrivaldatetime}',
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.grey)),
                      const SizedBox(height: tiniestSpacing),
                      Text(
                          '${tripListDatum[index].deplocname} - ${tripListDatum[index].arrlocname}',
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.grey)),
                    ]),
                trailing: Text(tripListDatum[index].status,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.deepBlue)),
              ),
            ));
          } else {
            TripsListScreen.pageNo++;
            context.read<TripBloc>().add(FetchTripsList(
                pageNo: TripsListScreen.pageNo, isFromHome: false));
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
