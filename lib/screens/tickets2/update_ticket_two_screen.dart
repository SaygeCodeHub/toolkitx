import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_application_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_distribution_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_priority_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_bug_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';

class UpdateTicketTwoScreen extends StatelessWidget {
  static const routeName = 'UpdateTicketTwoScreen';
  final String ticketTwoId;

  const UpdateTicketTwoScreen({super.key, required this.ticketTwoId});

  @override
  Widget build(BuildContext context) {
    context.read<Tickets2Bloc>().add(FetchTicket2Master(responsequeid: ''));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEditTicket),
      body: BlocBuilder<Tickets2Bloc, Tickets2States>(
        buildWhen: (previousState, currentState) =>
            currentState is Ticket2MasterFetching ||
            currentState is Ticket2MasterFetched ||
            currentState is Ticket2MasterNotFetched,
        builder: (context, state) {
          if (state is Ticket2MasterFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Ticket2MasterFetched) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinierSpacing),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DatabaseUtil.getText('ticket_header'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        value: context
                                .read<Tickets2Bloc>()
                                .updateTicketTwoMap['header'] ??
                            '',
                        onTextFieldChanged: (textField) {
                          context
                              .read<Tickets2Bloc>()
                              .updateTicketTwoMap['header'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('ticket_application'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2ApplicationTile(
                          saveTicketMap:
                              context.read<Tickets2Bloc>().updateTicketTwoMap,
                          appList: state.fetchTicket2MasterModel.data[0]),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('Priority'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2PriorityTile(
                          priorityList: state.fetchTicket2MasterModel.data[1],
                          saveTicketMap:
                              context.read<Tickets2Bloc>().updateTicketTwoMap),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('ticket_bug'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TicketTwoBugExpansionTile(
                          saveTicketMap:
                              context.read<Tickets2Bloc>().updateTicketTwoMap),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('Description'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        value: context
                                .read<Tickets2Bloc>()
                                .updateTicketTwoMap['description'] ??
                            '',
                        maxLines: 6,
                        onTextFieldChanged: (textField) {
                          context
                              .read<Tickets2Bloc>()
                              .updateTicketTwoMap['description'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('DistributionList'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2DistributionTile(
                        saveTicketMap:
                            context.read<Tickets2Bloc>().updateTicketTwoMap,
                        distList: state.fetchTicket2MasterModel.data[2],
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text('Responsibility',
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        value: context
                                .read<Tickets2Bloc>()
                                .updateTicketTwoMap['responsibility'] ??
                            '',
                        maxLength: 255,
                        onTextFieldChanged: (textField) {
                          context
                              .read<Tickets2Bloc>()
                              .updateTicketTwoMap['responsibility'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text(StringConstants.kAffectedEquipment,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        value: context
                                .read<Tickets2Bloc>()
                                .updateTicketTwoMap['affectedequipment'] ??
                            '',
                        maxLength: 255,
                        onTextFieldChanged: (textField) {
                          context
                                  .read<Tickets2Bloc>()
                                  .updateTicketTwoMap['affectedequipment'] =
                              textField;
                        },
                      )
                    ]),
              ),
            );
          } else if (state is Ticket2MasterNotFetched) {
            return const Center(child: Text(StringConstants.kNoRecordsFound));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocListener<Tickets2Bloc, Tickets2States>(
          listener: (context, state) {
            if (state is UpdatingTicketTwo) {
              ProgressBar.show(context);
            } else if (state is TicketTwoUpdated) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context.read<Tickets2Bloc>().add(FetchTicket2Details(
                  ticketId: ticketTwoId, ticketTabIndex: 0));
            } else if (state is TicketTwoNotUpdated) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<Tickets2Bloc>().updateTicketTwoMap['id'] =
                    ticketTwoId;
                context.read<Tickets2Bloc>().add(UpdateTicketTwo());
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
