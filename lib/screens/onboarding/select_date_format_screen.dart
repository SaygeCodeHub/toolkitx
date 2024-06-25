import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/dateFormat/date_format_bloc.dart';
import '../../blocs/dateFormat/date_format_events.dart';
import '../../blocs/dateFormat/date_format_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';
import 'widgets/select_date_format_body.dart';

class SelectDateFormatScreen extends StatelessWidget {
  static const routeName = 'SelectDateFormatScreen';
  final bool isFromProfile;

  const SelectDateFormatScreen({Key? key, this.isFromProfile = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<DateFormatBloc>()
        .add(SetDateFormat(isFromProfile: isFromProfile));
    return Scaffold(
      appBar: AppBar(
          title: Text((isFromProfile == true)
              ? DatabaseUtil.getText('changedateformat')
              : StringConstants.kSelectDateFormat),
          titleTextStyle: Theme.of(context).textTheme.mediumLarge),
      body: BlocBuilder<DateFormatBloc, DateFormatStates>(
          builder: (context, state) {
        if (state is DateFormatSelected) {
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: topBottomPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectDateFormatBody(
                          dateFormatString: state.dateFormatString,
                          isFromProfile: isFromProfile,
                        ),
                        const SizedBox(height: xxxSmallerSpacing),
                        PrimaryButton(
                            onPressed: () {
                              if (isFromProfile == true) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              }
                            },
                            textValue: DatabaseUtil.getText('buttonSave'))
                      ])));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
