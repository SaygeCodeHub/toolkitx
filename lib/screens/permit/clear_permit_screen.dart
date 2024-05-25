import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/screens/permit/widgets/clear_permit_bottom_bar.dart';
import 'package:toolkit/screens/permit/widgets/clear_permit_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../blocs/permit/permit_events.dart';

class ClearPermitScreen extends StatelessWidget {
  static const routeName = 'ClearPermitScreen';
  final String permitId;
  final Map clearPermitMap = {};

  ClearPermitScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(FetchClearPermit(permitId: permitId));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kClearPermitRequest),
        bottomNavigationBar: ClearPermitBottomBar(
            permitId: permitId, clearPermitMap: clearPermitMap),
        body: BlocBuilder<PermitBloc, PermitStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingClearPermitDetails ||
                currentState is ClearPermitDetailsFetched ||
                currentState is ClearPermitDetailsCouldNotFetched,
            builder: (context, state) {
              if (state is FetchingClearPermitDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClearPermitDetailsFetched) {
                clearPermitMap['customfields'] = state.customFields;
                return ClearPermitSection(
                    clearPermitMap: clearPermitMap,
                    data: state.fetchClearPermitDetailsModel.data);
              } else if (state is ClearPermitDetailsCouldNotFetched) {
                return NoRecordsText(text: state.errorMessage);
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
