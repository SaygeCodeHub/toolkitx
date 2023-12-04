import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_assets_model.dart';
import '../../../widgets/custom_card.dart';
import 'location_details_assets_tab.dart';

class LocationDetailsAssetsBody extends StatelessWidget {
  final List<LocationAssetsDatum> locationAssets;
  final bool locationAssetsListReachedMax;

  const LocationDetailsAssetsBody(
      {Key? key,
      required this.locationAssets,
      required this.locationAssetsListReachedMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: locationAssetsListReachedMax
              ? locationAssets.length
              : locationAssets.length + 1,
          itemBuilder: (context, index) {
            if (index < locationAssets.length) {
              return CustomCard(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(xxTinierSpacing),
                  title: Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(locationAssets[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600)),
                            const SizedBox(width: tiniestSpacing),
                            Text(locationAssets[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .xxSmall
                                    .copyWith(color: AppColor.deepBlue))
                          ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: tinierSpacing),
                      Text(locationAssets[index].tag,
                          style: Theme.of(context).textTheme.xSmall),
                    ],
                  ),
                ),
              );
            } else {
              LocationDetailsAssetsTab.pageNo++;
              context.read<LocationBloc>().add(
                  FetchLocationAssets(pageNo: LocationDetailsAssetsTab.pageNo));
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
