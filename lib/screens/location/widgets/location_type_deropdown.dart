import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../blocs/location/location_state.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/enums/location_type_enum.dart';
import 'location_filter_screen.dart';

class LocationTypeDropDown extends StatelessWidget {
  const LocationTypeDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(SelectLocationType(locationTypeMap: {
          'tyId': LocationFilterScreen.locationFilterMap['tyId'] ?? '',
          'ty': LocationFilterScreen.locationFilterMap['tyName'] ?? ''
        }));
    return BlocBuilder<LocationBloc, LocationState>(
      buildWhen: (previousState, currentState) =>
          currentState is LocationTypeSelected,
      builder: (context, state) {
        if (state is LocationTypeSelected) {
          LocationFilterScreen.locationFilterMap['tyName'] =
              state.locationTypeMap['ty'];
          return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  collapsedShape: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.grey,
                    width: kExpansionBorderWidth,
                  )),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  shape: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.grey,
                    width: kExpansionBorderWidth,
                  )),
                  key: GlobalKey(),
                  title: Text(
                      LocationFilterScreen.locationFilterMap['tyName'] ==
                                  null ||
                              LocationFilterScreen
                                  .locationFilterMap['tyName'].isEmpty
                          ? StringConstants.kSelect
                          : LocationFilterScreen.locationFilterMap['tyName'],
                      style: Theme.of(context).textTheme.xSmall),
                  children: [
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: LocationTypeEnum.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RadioListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: kExpansionTileMargin,
                                  right: kExpansionTileMargin),
                              activeColor: AppColor.deepBlue,
                              title: Text(
                                  LocationTypeEnum.values.elementAt(index).type,
                                  style: Theme.of(context).textTheme.xSmall),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: LocationTypeEnum.values
                                  .elementAt(index)
                                  .value,
                              groupValue: state.locationTypeMap['tyId'],
                              onChanged: (value) {
                                state.locationTypeMap['tyId'] = LocationTypeEnum
                                    .values
                                    .elementAt(index)
                                    .value;
                                LocationFilterScreen.locationFilterMap['tyId'] =
                                    state.locationTypeMap['tyId'];
                                state.locationTypeMap['ty'] = LocationTypeEnum
                                    .values
                                    .elementAt(index)
                                    .type;
                                LocationFilterScreen
                                        .locationFilterMap['tyName'] =
                                    state.locationTypeMap['ty'];
                                context.read<LocationBloc>().add(
                                    SelectLocationType(
                                        locationTypeMap:
                                            state.locationTypeMap));
                              });
                        })
                  ]));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
