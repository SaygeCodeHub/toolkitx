import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/trips/trip_filter_screen.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_app_bar.dart';
import '../../../blocs/trips/trip_bloc.dart';

class TripVesselFilterList extends StatelessWidget {
  static const routeName = "TripVesselFilterList";

  const TripVesselFilterList({super.key, required this.vesselName});

  final String vesselName;

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(FetchTripMaster());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectApplication),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: BlocBuilder<TripBloc, TripState>(
                buildWhen: (previousState, currentState) =>
                    currentState is TripMasterFetching ||
                    currentState is TripMasterFetched ||
                    currentState is TripMasterNotFetched,
                builder: (context, state) {
                  if (state is TripMasterFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TripMasterFetched) {
                    var data = state.fetchTripMasterModel.data;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: data[0].length,
                              itemBuilder: (context, index) {
                                return RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColor.deepBlue,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(data[0][index].vessel),
                                    value: data[0][index].id,
                                    groupValue: vesselName,
                                    onChanged: (value) {
                                      TripsFilterScreen
                                              .tripFilterMap['vessel'] =
                                          data[0][index].id;

                                      context.read<TripBloc>().add(
                                          SelectTripVesselFilter(
                                              selectVessel: data[0][index].id));
                                      context.read<TripBloc>().vesselName =
                                          data[0][index].vessel;
                                      Navigator.pop(context);
                                    });
                              }),
                          const SizedBox(height: xxxSmallerSpacing)
                        ]);
                  } else if (state is TripMasterNotFetched) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  }
                  return const SizedBox.shrink();
                },
              )),
        ));
  }
}
