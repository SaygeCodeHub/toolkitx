import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/location/fetch_location_checklists_model.dart';
import '../../../widgets/custom_card.dart';

class LocationDetailsCheckListsBody extends StatelessWidget {
  final List<LocationCheckListsDatum> checklistsLocation;

  const LocationDetailsCheckListsBody(
      {Key? key, required this.checklistsLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: checklistsLocation.length,
          itemBuilder: (context, index) {
            return CustomCard(
              child: ListTile(
                contentPadding: const EdgeInsets.all(xxTinierSpacing),
                title: Padding(
                    padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                    child: Text(checklistsLocation[index].name,
                        style: Theme.of(context).textTheme.small.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600))),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${checklistsLocation[index].categoryname} - ${checklistsLocation[index].subcategoryname}',
                        style: Theme.of(context).textTheme.xSmall)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: xxTinySpacing);
          }),
    );
  }
}
