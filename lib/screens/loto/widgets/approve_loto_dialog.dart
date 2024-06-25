import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';

class ApproveLotoDialog extends StatelessWidget {
  const ApproveLotoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LotoDetailsBloc, LotoDetailsState>(
        listener: (context, state) {
          if (state is LotoAccepting) {
            ProgressBar.show(context);
          } else if (state is LotoAccepted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, StringConstants.kLotoAccepted, '');
            Navigator.pop(context);
            context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                lotoTabIndex: 0,
                lotoId: context.read<LotoDetailsBloc>().lotoId));
          } else if (state is LotoNotAccepted) {
            ProgressBar.dismiss(context);
            showCustomSnackBar(context, state.getError, '');
          }
        },
        child: AndroidPopUp(
            titleValue: DatabaseUtil.getText('ApproveLotoTitle'),
            contentValue: DatabaseUtil.getText('ApproveLotoMessage'),
            onPrimaryButton: () {
              context.read<LotoDetailsBloc>().add(AcceptLotoEvent());
              context.read<LotoDetailsBloc>().add(FetchLotoDetails(
                  lotoTabIndex: context.read<LotoDetailsBloc>().lotoTabIndex,
                  lotoId: context.read<LotoDetailsBloc>().lotoId));
            }));
  }
}
