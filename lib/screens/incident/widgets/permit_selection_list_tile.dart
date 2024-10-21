import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/incident/fetch_permit_to_link_model.dart';
import '../../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/icon_and_text_row.dart';
import '../../../widgets/status_tag.dart';

class PermitSelectionListTile extends StatelessWidget {
  final Datum permitLinkDatum;
  final int index;
  final void Function(bool, int) checkPermit;

  const PermitSelectionListTile(
      {super.key,
      required this.permitLinkDatum,
      required this.index,
      required this.checkPermit});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Padding(
      padding: const EdgeInsets.all(tinierSpacing),
      child: Column(
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(permitLinkDatum.permit,
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.bold, color: AppColor.black)),
                  const SizedBox(width: tinierSpacing),
                  Image.asset('assets/icons/warning.png',
                      height: kImageHeight, width: kImageWidth)
                ]),
                Text(permitLinkDatum.status,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.deepBlue))
              ]),
          ListTile(
            contentPadding: EdgeInsets.zero,
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(permitLinkDatum.description),
                          ),
                          const SizedBox(height: tiniestSpacing),
                          Row(children: [
                            Image.asset("assets/icons/calendar.png",
                                height: kImageHeight, width: kImageWidth),
                            const SizedBox(width: tiniestSpacing),
                            Text(permitLinkDatum.schedule)
                          ]),
                          const SizedBox(height: tiniestSpacing),
                          IconAndTextRow(
                              title: permitLinkDatum.pname!,
                              icon: 'human_avatar_three'),
                          const SizedBox(height: tiniestSpacing),
                          IconAndTextRow(
                              title: permitLinkDatum.pcompany!, icon: 'office'),
                          const SizedBox(height: tiniestSpacing),
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/location.png",
                                    height: kImageHeight, width: kImageWidth),
                                const SizedBox(width: tiniestSpacing),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(permitLinkDatum.location),
                                ),
                              ],
                            ),
                          ),
                          if (permitLinkDatum.expired == '2')
                            const SizedBox(height: xxTinierSpacing),
                          if (permitLinkDatum.expired == '2')
                            StatusTag(tags: [
                              StatusTagModel(
                                  title: (permitLinkDatum.expired == '2')
                                      ? DatabaseUtil.getText('Expired')
                                      : '',
                                  bgColor: AppColor.errorRed),
                            ])
                        ]),
                    Checkbox(
                        activeColor: AppColor.deepBlue,
                        value: context
                            .read<IncidentDetailsBloc>()
                            .savedList
                            .contains(permitLinkDatum.id),
                        onChanged: (isChecked) {
                          checkPermit(isChecked!, index);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
