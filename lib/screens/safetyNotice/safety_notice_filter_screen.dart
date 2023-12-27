import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../blocs/safetyNotice/safety_notice_bloc.dart';
import '../../blocs/safetyNotice/safety_notice_events.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/primary_button.dart';
import 'safety_notice_screen.dart';
import 'widgets/safety_notice_status_filter_expansion_tile.dart';

class SafetyNoticeFilterScreen extends StatelessWidget {
  static const routeName = 'SafetyNoticeFilterScreen';
  static Map safetyNoticeFilterMap = {};

  const SafetyNoticeFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kApplyFilter),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomPadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DatabaseUtil.getText('Keywords'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: xxTinierSpacing),
                TextFieldWidget(onTextFieldChanged: (String textField) {
                  safetyNoticeFilterMap['keyword'] = textField;
                }),
                const SizedBox(height: xxTinySpacing),
                Text(DatabaseUtil.getText('Status'),
                    style: Theme.of(context)
                        .textTheme
                        .xSmall
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: xxTinierSpacing),
                const SafetyNoticeStatusFilterExpansionTile(),
                const SizedBox(height: xxxSmallerSpacing),
                PrimaryButton(
                    onPressed: () {
                      context.read<SafetyNoticeBloc>().add(
                          SafetyNoticeApplyFilter(
                              safetyNoticeFilterMap: safetyNoticeFilterMap));
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, SafetyNoticeScreen.routeName,
                          arguments: false);
                    },
                    textValue: DatabaseUtil.getText('Apply'))
              ])),
    );
  }
}
