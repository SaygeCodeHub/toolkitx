import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/select_time_zone_body.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../blocs/timeZone/time_zone_bloc.dart';
import '../../blocs/timeZone/time_zone_events.dart';
import '../../blocs/timeZone/time_zone_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/error_section.dart';

class SelectTimeZoneScreen extends StatelessWidget {
  static const routeName = 'SelectTimeZoneScreen';
  final bool isFromProfile;

  const SelectTimeZoneScreen({super.key, this.isFromProfile = false});

  @override
  Widget build(BuildContext context) {
    context.read<TimeZoneBloc>().add(FetchTimeZone());
    return Scaffold(
        appBar: AppBar(
            title: Text(isFromProfile == true
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
                return SelectTimeZoneBody(
                    timeZoneData: state.getTimeZoneModel.data!,
                    isFromProfile: isFromProfile);
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
