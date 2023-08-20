import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_event.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import 'signin_location_details_cards.dart';

class SignInLocationDetailsBody extends StatelessWidget {
  const SignInLocationDetailsBody({Key? key}) : super(key: key);
  static int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    context.read<SignInLocationDetailsBloc>().add(FetchSignInLocationDetails());

    return Expanded(
      child: Column(
        children: [
          BlocBuilder<SignInLocationDetailsBloc, SignInLocationDetailsStates>(
              builder: (context, state) {
            if (state is SignInLocationDetailsFetched) {
              return Visibility(
                visible: state.fetchLocationDetailsSignInModel.data.permit
                        .isNotEmpty ||
                    state.fetchLocationDetailsSignInModel.data.workorder
                        .isNotEmpty ||
                    state
                        .fetchLocationDetailsSignInModel.data.loto.isNotEmpty ||
                    state.fetchLocationDetailsSignInModel.data.checklist
                        .isNotEmpty,
                child: ToggleSwitch(
                  animate: true,
                  minWidth: kToggleSwitchMinWidth,
                  initialLabelIndex: indexSelected,
                  cornerRadius: 10,
                  activeFgColor: AppColor.black,
                  inactiveBgColor: AppColor.blueGrey,
                  inactiveFgColor: AppColor.black,
                  totalSwitches: 4,
                  labels: [
                    DatabaseUtil.getText('Permit'),
                    DatabaseUtil.getText('WorkOrder'),
                    DatabaseUtil.getText('LOTO'),
                    DatabaseUtil.getText('Checklist'),
                  ],
                  activeBgColors: const [
                    [AppColor.lightBlue],
                    [AppColor.lightBlue],
                    [AppColor.lightBlue],
                    [AppColor.lightBlue]
                  ],
                  onToggle: (index) {
                    indexSelected = index!;
                    context.read<SignInLocationDetailsBloc>().add(
                        ToggleSwitchIndex(
                            selectedIndex: index,
                            fetchLocationDetailsSignInModel:
                                state.fetchLocationDetailsSignInModel));
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SizedBox(height: xxTinySpacing),
          const SignInLocationDetailsCards()
        ],
      ),
    );
  }
}
