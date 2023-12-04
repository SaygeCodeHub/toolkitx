import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/location/location_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import 'location_details_screen.dart';

class LocationListScreen extends StatelessWidget {
  static const routeName = 'LocationListScreen';
  static int pageNo = 1;

  const LocationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LocationBloc>().add(FetchLocations(pageNo: 1));
    context.read<LocationBloc>().locationDatum.clear();
    context.read<LocationBloc>().locationListReachedMax = false;
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Location')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(
              children: [
                CustomIconButtonRow(
                    primaryOnPress: () {},
                    secondaryOnPress: () {},
                    secondaryVisible: false,
                    clearOnPress: () {}),
                const SizedBox(height: xxTinierSpacing),
                BlocConsumer<LocationBloc, LocationState>(
                    listener: (context, state) {
                      if (state is LocationsFetched &&
                          state.locationListReachedMax) {
                        showCustomSnackBar(
                            context, StringConstants.kAllDataLoaded, '');
                      }
                    },
                    buildWhen: (previousState, currentState) =>
                        (currentState is FetchingLocations && pageNo == 1) ||
                        (currentState is LocationsFetched),
                    builder: (context, state) {
                      if (state is FetchingLocations) {
                        return const Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      } else if (state is LocationsFetched) {
                        if (state.locationDatum.isNotEmpty) {
                          return Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: (state.locationListReachedMax)
                                      ? state.locationDatum.length
                                      : state.locationDatum.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < state.locationDatum.length) {
                                      return CustomCard(
                                          child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              LocationDetailsScreen.routeName,
                                              arguments: state
                                                  .locationDatum[index].id);
                                        },
                                        title: Text(
                                            state.locationDatum[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    color: AppColor.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        subtitle: Text(
                                            state.locationDatum[index].maptype,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey)),
                                      ));
                                    } else {
                                      pageNo++;
                                      context
                                          .read<LocationBloc>()
                                          .add(FetchLocations(pageNo: pageNo));
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                        height: xxTinySpacing);
                                  }));
                        } else {
                          return NoRecordsText(
                              text: DatabaseUtil.getText('no_records_found'));
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
              ],
            )));
  }
}
