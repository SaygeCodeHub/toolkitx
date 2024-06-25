import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/trips/widgets/trip_created_for_expansion_tile.dart';
import 'package:toolkit/screens/trips/widgets/trip_special_request_type_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/trips/trip_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class AddSpecialReportScreen extends StatelessWidget {
  static const routeName = 'AddSpecialReportScreen';
  final String tripId;

  const AddSpecialReportScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(FetchPassengerCrewList(tripId: tripId));
    context.read<TripBloc>().add(FetchTripMaster());
    Map specialReportMap = {};
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kManageSpecialRequest),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(StringConstants.kCreatedFor,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          BlocBuilder<TripBloc, TripState>(
            buildWhen: (previousState, currentState) =>
                currentState is PassengerCrewListFetching ||
                currentState is PassengerCrewListFetched ||
                currentState is PassengerCrewListNotFetched,
            builder: (context, state) {
              if (state is PassengerCrewListFetched) {
                return TripCreatedForExpansionTile(
                    passengerCrewDatum:
                        state.fetchTripPassengersCrewListModel.data,
                    specialReportMap: specialReportMap);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kSpecialRequestType,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          BlocBuilder<TripBloc, TripState>(
            buildWhen: (previousState, currentState) =>
                currentState is TripMasterFetching ||
                currentState is TripMasterFetched ||
                currentState is TripMasterNotFetched,
            builder: (context, state) {
              if (state is TripMasterFetched) {
                return TripSpecialRequestTypeExpansionTile(
                    specialReportMap: specialReportMap,
                    masterDatum: state.fetchTripMasterModel.data[1]);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: xxTinierSpacing),
          Text(StringConstants.kSpecialRequest,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor.black)),
          const SizedBox(height: tiniestSpacing),
          TextFieldWidget(
            value: '',
            onTextFieldChanged: (textField) {
              specialReportMap['specialrequest'] = textField;
            },
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is TripSpecialRequestAdding) {
              ProgressBar.show(context);
            } else if (state is TripSpecialRequestAdded) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
            } else if (state is TripSpecialRequestNotAdded) {
              ProgressBar.dismiss(context);
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<TripBloc>().add(TripAddSpecialRequest(
                    tripId: tripId, addSpecialRequestMap: specialReportMap));
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
