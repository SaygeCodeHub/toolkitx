import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_application_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_distribution_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket2_priority_tile.dart';
import 'package:toolkit/screens/tickets2/widgets/ticket_two_bug_expansion_tile.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/tickets2/tickets2_bloc.dart';
import '../../blocs/tickets2/tickets2_event.dart';
import '../../blocs/tickets2/tickets2_state.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';

class AddTicket2Screen extends StatelessWidget {
  static const routeName = 'AddTicket2Screen';
  final String responsequeid;

  const AddTicket2Screen({super.key, required this.responsequeid});

  static Map saveTicketMap = {};

  @override
  Widget build(BuildContext context) {
    saveTicketMap.clear();
    context
        .read<Tickets2Bloc>()
        .add(FetchTicket2Master(responsequeid: responsequeid));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ticket_addticket')),
      body: BlocBuilder<Tickets2Bloc, Tickets2States>(
        buildWhen: (previousState, currentState) =>
            currentState is Ticket2MasterFetching ||
            currentState is Ticket2MasterFetched ||
            currentState is Ticket2MasterNotFetched,
        builder: (context, state) {
          if (state is Ticket2MasterFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Ticket2MasterFetched) {
            saveTicketMap['description'] = state.desc;
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
                        onTextFieldChanged: (textField) {
                          saveTicketMap['header'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('ticket_application'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2ApplicationTile(
                          saveTicketMap: saveTicketMap,
                          appList: state.fetchTicket2MasterModel.data[0]),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('Priority'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2PriorityTile(
                          priorityList: state.fetchTicket2MasterModel.data[1],
                          saveTicketMap: saveTicketMap),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('ticket_bug'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TicketTwoBugExpansionTile(saveTicketMap: saveTicketMap),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('Description'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        value: state.desc.isNotEmpty ? state.desc : '',
                        maxLines: 6,
                        onTextFieldChanged: (textField) {
                          saveTicketMap['description'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text(DatabaseUtil.getText('DistributionList'),
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      Ticket2DistributionTile(
                        saveTicketMap: saveTicketMap,
                        distList: state.fetchTicket2MasterModel.data[2],
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text('Responsibility',
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        maxLength: 255,
                        onTextFieldChanged: (textField) {
                          saveTicketMap['responsibility'] = textField;
                        },
                      ),
                      const SizedBox(height: xxTinierSpacing),
                      Text('Affected Equipment',
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.black)),
                      const SizedBox(height: tiniestSpacing),
                      TextFieldWidget(
                        maxLength: 255,
                        onTextFieldChanged: (textField) {
                          saveTicketMap['affectedequipment'] = textField;
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
            if (state is Ticket2Saving) {
              ProgressBar.show(context);
            } else if (state is Ticket2Saved) {
              ProgressBar.dismiss(context);
              Navigator.pop(context);
              context
                  .read<Tickets2Bloc>()
                  .add(FetchTickets2(pageNo: 1, isFromHome: false));
            } else if (state is Ticket2NotSaved) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.errorMessage, '');
            }
          },
          child: PrimaryButton(
              onPressed: () {
                saveTicketMap['responsequeid'] = responsequeid;
                context
                    .read<Tickets2Bloc>()
                    .add(SaveTicket2(saveTicket2Map: saveTicketMap));
              },
              textValue: DatabaseUtil.getText('buttonSave')),
        ),
      ),
    );
  }
}
