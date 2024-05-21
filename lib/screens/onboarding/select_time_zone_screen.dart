import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../blocs/timeZone/time_zone_bloc.dart';
import '../../blocs/timeZone/time_zone_events.dart';
import '../../blocs/timeZone/time_zone_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/timeZones/time_zone_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/error_section.dart';
import 'select_date_format_screen.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';
  final bool isFromProfile;

  const SelectTimeZoneScreen({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return Scaffold(
        appBar: AppBar(
            title: Text((isFromProfile == true)
                ? DatabaseUtil.getText('changetimezone')
                : StringConstants.kSelectTimeZone),
            titleTextStyle: Theme.of(context).textTheme.mediumLarge),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocBuilder<TimeZoneBloc, TimeZoneStates>(
                builder: (context, state) {
              if (state is TimeZoneFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TimeZoneFetched) {
                return Column(children: [
                  Expanded(
                      child: SearchableList(
                    initialList: state.getTimeZoneModel.data!,
                    itemBuilder: (TimeZoneData item) {
                      return Padding(
                          padding:
                              const EdgeInsets.only(bottom: xxTinierSpacing),
                          child: CustomCard(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kCardRadius)),
                              child: ListTile(
                                  onTap: () {
                                    context.read<TimeZoneBloc>().add(
                                        SelectTimeZone(
                                            timeZoneCode: item.code,
                                            isFromProfile: isFromProfile,
                                            timeZoneName: item.name,
                                            timeZoneOffset: item.offset));
                                    if (isFromProfile == true) {
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pushNamed(context,
                                          SelectDateFormatScreen.routeName,
                                          arguments: false);
                                    }
                                  },
                                  horizontalTitleGap: kListTileTitleGap,
                                  minLeadingWidth: kListTileMinLeadingWidth,
                                  leading: const Padding(
                                      padding: EdgeInsets.only(
                                          top: kListTileLeadingPadding,
                                          bottom: kListTileLeadingPadding),
                                      child:
                                          Icon(Icons.public, size: kIconSize)),
                                  title: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: xxTiniestSpacing),
                                      child: Text(item.offset)),
                                  subtitle: Text(item.name))));
                    },
                    emptyWidget: Text(DatabaseUtil.getText('no_records_found')),
                    filter: (value) => state.getTimeZoneModel.data!
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase().trim()))
                        .toList(),
                    inputDecoration: InputDecoration(
                        suffix: const SizedBox(),
                        suffixIcon:
                            const Icon(Icons.search_sharp, size: kIconSize),
                        hintText: StringConstants.kSearchTimezone,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(color: AppColor.grey),
                        contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.lightGrey)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.lightGrey)),
                        filled: true,
                        fillColor: AppColor.white),
                  )),
                ]);
              } else if (state is FetchTimeZoneError) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<TimeZoneBloc>().add(FetchTimeZone());
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            })));
  }
}
