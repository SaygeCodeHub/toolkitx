import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/timeZone/time_zone_bloc.dart';
import 'package:toolkit/blocs/timeZone/time_zone_events.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/timeZones/time_zone_model.dart';
import 'package:toolkit/screens/onboarding/select_date_format_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/primary_button.dart';

class SelectTimeZoneBody extends StatefulWidget {
  final List<TimeZoneData> timeZoneData;
  final bool isFromProfile;

  const SelectTimeZoneBody(
      {super.key, required this.timeZoneData, required this.isFromProfile});

  @override
  State<SelectTimeZoneBody> createState() => _SelectTimeZoneBodyState();
}

class _SelectTimeZoneBodyState extends State<SelectTimeZoneBody> {
  late TextEditingController _searchController;
  late List<TimeZoneData> _filteredTimeZonesData;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredTimeZonesData = widget.timeZoneData;
  }

  void _filterTimeZones() {
    setState(() {
      _filteredTimeZonesData = widget.timeZoneData
          .where((element) => element.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase().trim()))
          .toList();
      _isSearchActive = true;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredTimeZonesData = widget.timeZoneData;
      _isSearchActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.63,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffix: const SizedBox(),
                suffixIcon: const Icon(Icons.search_sharp, size: kIconSize),
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
                fillColor: AppColor.white,
              ),
            ),
          ),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
            child: PrimaryButton(
                onPressed: _isSearchActive
                    ? () => _clearSearch()
                    : () => _filterTimeZones(),
                textValue: _isSearchActive
                    ? StringConstants.kClear
                    : StringConstants.kSearch),
          ),
        ],
      ),
      const SizedBox(height: xxTinierSpacing),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(bottom: xxTinierSpacing),
        child: ListView.separated(
          itemCount: _filteredTimeZonesData.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomCard(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius)),
              child: ListTile(
                onTap: () {
                  context.read<TimeZoneBloc>().add(SelectTimeZone(
                      timeZoneCode: _filteredTimeZonesData[index].code,
                      isFromProfile: widget.isFromProfile,
                      timeZoneName: _filteredTimeZonesData[index].name,
                      timeZoneOffset: _filteredTimeZonesData[index].offset));
                  if (widget.isFromProfile == true) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamed(
                        context, SelectDateFormatScreen.routeName,
                        arguments: false);
                  }
                },
                horizontalTitleGap: kListTileTitleGap,
                minLeadingWidth: kListTileMinLeadingWidth,
                leading: const Padding(
                    padding: EdgeInsets.only(
                        top: kListTileLeadingPadding,
                        bottom: kListTileLeadingPadding),
                    child: Icon(Icons.public, size: kIconSize)),
                title: Padding(
                    padding: const EdgeInsets.only(bottom: xxTiniestSpacing),
                    child: Text(_filteredTimeZonesData[index].offset)),
                subtitle: Text(_filteredTimeZonesData[index].name),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: xxTinierSpacing);
          },
        ),
      )),
    ]);
  }
}
