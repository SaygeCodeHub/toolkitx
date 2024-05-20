import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tickets/tickets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets/widgets/open_ticket_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

class OpenTicketScreen extends StatelessWidget {
  static const routeName = 'OpenTicketScreen';

  const OpenTicketScreen({super.key});

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
                    OpenTicketExpansionTile(
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
                            child: BlocListener<TicketsBloc, TicketsStates>(
                          listener: (context, state) {
                            if (state is OpenTicketSaving) {
                              ProgressBar.show(context);
                            }
                            if (state is OpenTicketSaved) {
                              ProgressBar.dismiss(context);
                              Navigator.pop(context);
                              context.read<TicketsBloc>().add(
                                  FetchTicketDetails(
                                      ticketId:
                                          context.read<TicketsBloc>().ticketId,
                                      ticketTabIndex: 0));
                            }
                            if (state is OpenTicketNotSaved) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.errorMessage, '');
                            }
                          },
                          child: PrimaryButton(
                              onPressed: () {
                                context
                                    .read<TicketsBloc>()
                                    .add(SaveOpenTicket(value: voValue));
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
