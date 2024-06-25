import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';

import '../../blocs/location/location_bloc.dart';
import '../../blocs/location/location_event.dart';
import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../incident/widgets/date_picker.dart';
import 'widgets/permit_emergency_filter.dart';
import 'widgets/permit_location_filter.dart';
import 'widgets/permit_status_filter.dart';
import 'widgets/permit_type_filter.dart';

class PermitFilterScreen extends StatelessWidget {
  static const routeName = 'PermitFilterScreen';
  static Map permitFilterMap = {};
  final List location = [];
  static bool isFromLocation = false;
  static String expenseId = '';

  PermitFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const FetchPermitMaster());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kFilter),
        body: BlocConsumer<PermitBloc, PermitStates>(
            listener: (context, state) {
              if (state is CouldNotFetchPermitMaster) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
            },
            buildWhen: (previousState, currentState) =>
                currentState is FetchingPermitMaster ||
                currentState is PermitMasterFetched ||
                currentState is CouldNotFetchPermitMaster,
            builder: (context, state) {
              if (state is FetchingPermitMaster) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PermitMasterFetched) {
                permitFilterMap.addAll(state.permitFilterMap);
                location.addAll(state.location);
                return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: leftRightMargin,
                            right: leftRightMargin,
                            top: topBottomPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(StringConstants.kDateRange,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxTinySpacing),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: DatePickerTextField(
                                            editDate:
                                                (permitFilterMap['st'] == null)
                                                    ? ''
                                                    : permitFilterMap['st'],
                                            hintText:
                                                StringConstants.kSelectDate,
                                            onDateChanged: (String date) {
                                              permitFilterMap['st'] = date;
                                            })),
                                    const SizedBox(width: xxTinierSpacing),
                                    const Text(StringConstants.kBis),
                                    const SizedBox(width: xxTinierSpacing),
                                    Expanded(
                                        child: DatePickerTextField(
                                            editDate:
                                                (permitFilterMap['et'] == null)
                                                    ? ''
                                                    : permitFilterMap['et'],
                                            hintText:
                                                StringConstants.kSelectDate,
                                            onDateChanged: (String date) {
                                              permitFilterMap['et'] = date;
                                            }))
                                  ]),
                              const SizedBox(height: xxTinySpacing),
                              Text('Keyword',
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              TextFieldWidget(
                                  value: (permitFilterMap['kword'] == null)
                                      ? ''
                                      : permitFilterMap['kword'],
                                  hintText: 'Keyword',
                                  onTextFieldChanged: (String textField) {
                                    permitFilterMap['kword'] = textField;
                                  }),
                              const SizedBox(height: xxTinySpacing),
                              Text(StringConstants.kPermitType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              PermitTypeFilter(
                                  permitMasterDatum:
                                      state.permitGetMasterModel.data,
                                  permitFilterMap: permitFilterMap),
                              const SizedBox(height: xxTinierSpacing),
                              Text(DatabaseUtil.getText('Status'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: xxxTinierSpacing),
                              PermitStatusFilter(
                                  permitFilterMap: permitFilterMap),
                              PermitEmergencyFilter(
                                  permitFilterMap: permitFilterMap),
                              PermitLocationFilter(
                                  permitMasterDatum:
                                      state.permitGetMasterModel.data,
                                  permitFilterMap: permitFilterMap,
                                  location: location),
                              const SizedBox(height: xxTinySpacing),
                              PrimaryButton(
                                  onPressed: () {
                                    if (permitFilterMap['st'] != null &&
                                            permitFilterMap['et'] == null ||
                                        permitFilterMap['st'] == null &&
                                            permitFilterMap['et'] != null) {
                                      showCustomSnackBar(
                                          context,
                                          DatabaseUtil.getText(
                                              'TimeDateValidate'),
                                          '');
                                    } else {
                                      if (isFromLocation == true) {
                                        context.read<LocationBloc>().add(
                                            ApplyPermitListFilter(
                                                filterMap: permitFilterMap));
                                        Navigator.pop(context);
                                        context.read<LocationBloc>().add(
                                            FetchLocationDetails(
                                                locationId: expenseId,
                                                selectedTabIndex: 2));
                                      } else {
                                        context.read<PermitBloc>().add(
                                            ApplyPermitFilters(
                                                permitFilterMap, location));
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, PermitListScreen.routeName,
                                            arguments: false);
                                      }
                                    }
                                  },
                                  textValue: StringConstants.kApply)
                            ])));
              } else {
                return const SizedBox();
              }
            }));
  }
}
