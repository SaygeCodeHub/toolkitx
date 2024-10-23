import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import 'widgets/open_ticket_two_expansion_tile.dart';

class OpenTicketTwoScreen extends StatelessWidget {
  static const routeName = 'OpenTicketTwoScreen';

  const OpenTicketTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String voValue = '';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(xxTinySpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringConstants.kVoNeeded,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    const SizedBox(height: xxTinierSpacing),
                    OpenTicketTwoExpansionTile(
                      createdForVoValue: (value) {
                        voValue = value;
                      },
                    ),
                    const SizedBox(height: xxTinySpacing),
                    Row(
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                textValue: StringConstants.kClose)),
                        const SizedBox(width: xxTinySpacing),
                        Expanded(
                            child: BlocListener<Tickets2Bloc, Tickets2States>(
                          listener: (context, state) {
                            if (state is OpenTicket2Saving) {
                              ProgressBar.show(context);
                            }
                            if (state is OpenTicket2Saved) {
                              ProgressBar.dismiss(context);
                              Navigator.pop(context);
                              context.read<Tickets2Bloc>().add(
                                  FetchTicket2Details(
                                      ticketId: context
                                          .read<Tickets2Bloc>()
                                          .ticket2Id,
                                      ticketTabIndex: 0));
                            }
                            if (state is OpenTicket2NotSaved) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.errorMessage, '');
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context
                                    .read<Tickets2Bloc>()
                                    .add(SaveOpenTicket2(value: voValue));
                              },
                              textValue: StringConstants.kSave),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
