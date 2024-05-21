import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/trips/trip_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/trips/trip_status_filter.dart';
import 'package:toolkit/screens/trips/trip_vessel_filter.dart';
import 'package:toolkit/screens/trips/trips_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class TripsFilterScreen extends StatelessWidget {
  static const routeName = 'TripsFilterScreen';
  static Map tripFilterMap = {};

  const TripsFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Filters')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(DatabaseUtil.getText('StartDate'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            DatePickerTextField(onDateChanged: (date) {
              tripFilterMap['startdate'] = date;
            }),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('EndDate'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: tiniestSpacing),
            DatePickerTextField(onDateChanged: (date) {
              tripFilterMap['enddate'] = date;
            }),
            const SizedBox(height: xxTinierSpacing),
            TripVesselFilter(tripFilterMap: tripFilterMap),
            const SizedBox(height: xxTinierSpacing),
            Text(DatabaseUtil.getText('Status'),
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            const SizedBox(height: xxTinierSpacing),
            TripStatusFilter(tripFilterMap: tripFilterMap),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              context
                  .read<TripBloc>()
                  .add(ApplyTripFilter(tripFilterMap: tripFilterMap));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, TripsListScreen.routeName,
                  arguments: false);
            },
            textValue: StringConstants.kApply),
      ),
    );
  }
}
