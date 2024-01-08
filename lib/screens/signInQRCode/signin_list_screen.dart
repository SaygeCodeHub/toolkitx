import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/signInQRCode/signInList/sign_in_list_bloc.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/signInQRCode/process_signin.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_dimensions.dart';
import '../../widgets/primary_button.dart';
import 'widgets/signin_location_details_body.dart';

class SignInListScreen extends StatelessWidget {
  static const routeName = 'SignInListScreen';

  const SignInListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SignInListBloc>().add(SignInList());
    return Scaffold(
      appBar: GenericAppBar(
        title: DatabaseUtil.getText('ticket_signin'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: PrimaryButton(
            textValue: DatabaseUtil.getText('ticket_signin'),
            onPressed: () {
              ProcessSignInScreen.isSignOut = false;
              Navigator.pushNamed(context, ProcessSignInScreen.routeName);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SafeArea(
          child: BlocBuilder<SignInListBloc, SignInListState>(
            builder: (context, state) {
              if (state is FetchingSignInList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SignInListFetched) {
                return Column(
                  children: [
                    CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.only(top: tinierSpacing),
                        child: ListTile(
                          title: Text(
                              state.currentSignInListModel.data.location,
                              style: Theme.of(context).textTheme.small.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black)),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: tinierSpacing),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/calendar.png',
                                    height: kImageHeight, width: kImageWidth),
                                const SizedBox(width: xxTiniestSpacing),
                                Text(state
                                    .currentSignInListModel.data.submitdate),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                ProcessSignInScreen.isSignOut = true;
                                Navigator.pushNamed(
                                    context, ProcessSignInScreen.routeName);
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: AppColor.errorRed,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: xxxSmallerSpacing,
                    ),
                    SignInLocationDetailsBody(
                        locationId:
                            state.currentSignInListModel.data.locationid)
                  ],
                );
              } else if (state is SignInListError) {
                return const Center(
                    child: Text(StringConstants.kNoRecordsFound));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
