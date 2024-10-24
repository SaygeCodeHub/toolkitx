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

import '../../blocs/trips/trip_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class EditSpecialRequestScreen extends StatelessWidget {
  static const routeName = 'EditSpecialRequestScreen';
  final String tripId;
  final String requestId;

  const EditSpecialRequestScreen(
      {super.key, required this.tripId, required this.requestId});

  @override
  Widget build(BuildContext context) {
    context
        .read<TripBloc>()
        .add(FetchTripSpecialRequest(tripId: tripId, requestId: requestId));
    Map editSpecialRequestMap = {};
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kManageSpecialRequest),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing,
            bottom: xxTinierSpacing),
        child: BlocBuilder<TripBloc, TripState>(
          buildWhen: (previousState, currentState) =>
              currentState is TripSpecialRequestFetching ||
              currentState is TripSpecialRequestFetched ||
              currentState is TripSpecialRequestNotFetched,
          builder: (context, state) {
            if (state is TripSpecialRequestFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripSpecialRequestFetched) {
              var data = state.fetchTripSpecialRequestModel.data;
              editSpecialRequestMap['specialrequest'] = data.specialrequest;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringConstants.kCreatedFor,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TripCreatedForExpansionTile(
                        passengerCrewDatum: state.passengerCrewDatum,
                        specialRequestMap: editSpecialRequestMap,
                        editName: data.createdforname,
                        editValue: data.createdfor),
                    const SizedBox(height: xxTinierSpacing),
                    Text(StringConstants.kSpecialRequestType,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TripSpecialRequestTypeExpansionTile(
                      specialRequestMap: editSpecialRequestMap,
                      masterDatum: state.masterDatum,
                      editName: data.specialrequesttypename,
                      editValue: data.specialrequesttypeid,
                    ),
                    const SizedBox(height: xxTinierSpacing),
                    Text(StringConstants.kSpecialRequest,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                      value:
                          data.specialrequest != '' ? data.specialrequest : '',
                      onTextFieldChanged: (textField) {
                        editSpecialRequestMap['specialrequest'] = textField;
                      },
                    ),
                  ]);
            } else if (state is TripSpecialRequestNotFetched) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<TripBloc, TripState>(
          listener: (context, state) {
            if (state is TripSpecialRequestUpdating) {
              ProgressBar.show(context);
            } else if (state is TripSpecialRequestUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context
                  .read<TripBloc>()
                  .add(FetchTripsDetails(tripId: tripId, tripTabIndex: 2));
            } else if (state is TripSpecialRequestNotUpdated) {
              ProgressBar.dismiss(context);
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<TripBloc>().add(UpdateTripSpecialRequest(
                    requestId: requestId,
                    updateSpecialRequestMap: editSpecialRequestMap));
              },
              textValue: StringConstants.kSave),
        ),
      ),
    );
  }
}
