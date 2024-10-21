import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/encrypt_class.dart';
import '../../../data/models/location/fetch_location_logbooks_model.dart';
import '../../../widgets/custom_card.dart';
import '../../logBook/logbook_details_screen.dart';
import 'location_details_logbooks_tab.dart';

class LocationDetailsLogBooksBody extends StatelessWidget {
  final List<LocationLogBooksDatum> locationLogBooks;
  final bool locationLogBooksListReachedMax;
  final String apiKey;

  const LocationDetailsLogBooksBody(
      {super.key,
      required this.locationLogBooks,
      required this.locationLogBooksListReachedMax,
      required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: locationLogBooksListReachedMax
              ? locationLogBooks.length
              : locationLogBooks.length + 1,
          itemBuilder: (context, index) {
            if (index < locationLogBooks.length) {
              return CustomCard(
                child: ListTile(
                  onTap: () {
                    String encryptId = '';
                    encryptId = EncryptData.encryptAESPrivateKey(
                        locationLogBooks[index].id.toString(), apiKey);
                    Navigator.pushNamed(context, LogBookDetailsScreen.routeName,
                        arguments: encryptId);
                  },
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxxTinierSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(locationLogBooks[index].logbookname,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(width: tiniestSpacing),
                            Text(locationLogBooks[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locationLogBooks[index].description,
                          style: Theme.of(context).textTheme.xSmall.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: tinierSpacing),
                      Row(
                        children: [
                          Image.asset("assets/icons/calendar.png",
                              height: kIconSize, width: kIconSize),
                          const SizedBox(width: tiniestSpacing),
                          Text(locationLogBooks[index].eventdatetime,
                              style: Theme.of(context).textTheme.xSmall)
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              LocationDetailsLogBooksTab.pageNo++;
              context.read<LocationBloc>().add(FetchLocationLogBooks(
                  pageNo: LocationDetailsLogBooksTab.pageNo));
              return const Center(child: CircularProgressIndicator());
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
