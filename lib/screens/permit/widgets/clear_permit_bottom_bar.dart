import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class ClearPermitBottomBar extends StatelessWidget {
  final String permitId;
  final Map clearPermitMap;

  const ClearPermitBottomBar(
      {super.key, required this.clearPermitMap, required this.permitId});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          BlocListener<PermitBloc, PermitStates>(
            listener: (context, state) {
              if (state is SavingClearPermit) {
                ProgressBar.show(context);
              } else if (state is ClearPermitSaved) {
                ProgressBar.dismiss(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, PermitDetailsScreen.routeName,
                    arguments: permitId);
              } else if (state is ClearPermitNotSaved) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.errorMessage, '');
              }
            },
            child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: StringConstants.kBack)),
          ),
          const SizedBox(width: xxTinierSpacing),
          Expanded(
            child: PrimaryButton(
                onPressed: () {
                  if (clearPermitMap['customfields'][0]['answer'] == null ||
                      clearPermitMap['customfields'][0]['answer'] == '') {
                    showCustomSnackBar(
                        context, StringConstants.kAllGearsValidation, '');
                  } else {
                    clearPermitMap['permit_id'] = permitId;
                    context
                        .read<PermitBloc>()
                        .add(SaveClearPermit(clearPermitMap: clearPermitMap));
                  }
                },
                textValue: StringConstants.kClearPermitCap),
          ),
        ],
      ),
    );
  }
}
