import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/location/location_bloc.dart';
import '../../../blocs/location/location_event.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/primary_button.dart';
import 'location_type_deropdown.dart';

class LocationFilterScreen extends StatelessWidget {
  static const routeName = 'LocationFilterScreen';
  static Map locationFilterMap = {};

  const LocationFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kFilter),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(StringConstants.kName,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          value: locationFilterMap['nm'] ?? '',
                          onTextFieldChanged: (String textField) {
                            locationFilterMap['nm'] = textField;
                          }),
                      const SizedBox(height: xxTinySpacing),
                      Text(StringConstants.kType,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxTinySpacing),
                      const LocationTypeDropDown(),
                      const SizedBox(height: xxTinySpacing),
                      PrimaryButton(
                          onPressed: () {
                            context.read<LocationBloc>().add(
                                ApplyLocationFilter(
                                    filterMap: locationFilterMap));
                            Navigator.pop(context);
                            context.read<LocationBloc>().add(
                                FetchLocations(pageNo: 1, isFromHome: false));
                          },
                          textValue: StringConstants.kApply)
                    ]))));
  }
}
