import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../data/models/permit/permit_details_model.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/close_permit_body.dart';

class ClosePermitScreen extends StatelessWidget {
  static const routeName = 'ClosePermitScreen';
  final PermitDetailsModel permitDetailsModel;
  final closePermitMap = {};

  ClosePermitScreen({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    context
        .read<PermitBloc>()
        .add(FetchClosePermitDetails(permitDetailsModel.data.tab1.id));
    return Scaffold(
        appBar: const GenericAppBar(title: 'Close Permit'),
        body: BlocConsumer<PermitBloc, PermitStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingClosePermitDetails ||
                currentState is ClosePermitDetailsFetched,
            listener: (context, state) {
              if (state is ClosingPermit) {
                ProgressBar.show(context);
              }
              if (state is PermitClosed) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, PermitListScreen.routeName,arguments: false);
              }
              if (state is ClosePermitError) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
              if (state is ClosePermitDetailsError) {
                Navigator.pop(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
            },
            builder: (context, state) {
              if (state is FetchingClosePermitDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClosePermitDetailsFetched) {
                closePermitMap
                    .addAll(state.closePermitDetailsModel.data.toJson());
                closePermitMap['permitId'] = permitDetailsModel.data.tab1.id;
                return ClosePermitBody(
                    closePermitMap: closePermitMap,
                    getClosePermitData: state.closePermitDetailsModel.data);
              } else {
                return const SizedBox();
              }
            }));
  }
}
