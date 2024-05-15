import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_states.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../utils/database_utils.dart';
import 'widgets/open_permit_body.dart';

class OpenPermitScreen extends StatelessWidget {
  static const routeName = 'OpenPermitScreen';
  final PermitDetailsModel permitDetailsModel;
  final Map openPermitMap = {};

  OpenPermitScreen({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    context
        .read<PermitBloc>()
        .add(FetchOpenPermitDetails(permitDetailsModel.data.tab1.id));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kOpenPermit),
        body: BlocConsumer<PermitBloc, PermitStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingOpenPermitDetails ||
                currentState is OpenPermitDetailsFetched,
            listener: (BuildContext context, state) {
              if (state is OpenPermitDetailsError) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
              if (state is OpeningPermit) {
                ProgressBar.show(context);
              }
              if (state is PermitOpened) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, PermitDetailsScreen.routeName,
                    arguments: permitDetailsModel.data.tab1.id);
              }
              if (state is OpenPermitError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
            builder: (context, state) {
              if (state is FetchingOpenPermitDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OpenPermitDetailsFetched) {
                openPermitMap
                    .addAll(state.openPermitDetailsModel.data.toJson());
                openPermitMap['customfields'] = state.customFields;
                openPermitMap['permitId'] = permitDetailsModel.data.tab1.id;
                return OpenPermitBody(
                    openPermitMap: openPermitMap,
                    getOpenPermitData: state.openPermitDetailsModel.data);
              } else {
                return const SizedBox();
              }
            }));
  }
}
