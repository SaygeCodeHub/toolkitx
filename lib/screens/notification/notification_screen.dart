import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_checklist_list_screen.dart';
import 'package:toolkit/screens/expense/expense_details_screen.dart';
import 'package:toolkit/screens/incident/incident_details_screen.dart';
import 'package:toolkit/screens/logBook/logbook_details_screen.dart';
import 'package:toolkit/screens/loto/loto_details_screen.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/qualityManagement/qm_details_screen.dart';
import 'package:toolkit/screens/safetyNotice/safety_notice_details_screen.dart';
import 'package:toolkit/screens/tickets/ticket_details_screen.dart';
import 'package:toolkit/screens/todo/todo_details_and_document_details_screen.dart';
import 'package:toolkit/screens/trips/trip_details_screen.dart';
import 'package:toolkit/screens/workorder/workorder_details_tab_screen.dart';
import 'package:toolkit/widgets/custom_card.dart';

import '../../blocs/global/global_bloc.dart';
import '../../blocs/notification/notification_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../certificates/get_course_certificate_screen.dart';
import '../checklist/workforce/workforce_list_screen.dart';
import '../documents/documents_list_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GlobalBloc>().add(UpdateCount(type: 'All'));
    context.read<NotificationBloc>().add(FetchMessages());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is MessagesFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MessagesFetched) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.fetchMessagesModel.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: xxTinierSpacing),
                      child: CustomCard(
                          child: Padding(
                              padding: const EdgeInsets.all(tiniestSpacing),
                              child: ListTile(
                                  onTap: () {
                                    navigateToModule(
                                        state.fetchMessagesModel.data![index]
                                            .redirect,
                                        state.fetchMessagesModel.data![index]
                                            .redirectionkey,
                                        context);
                                  },
                                  leading: const Icon(
                                    Icons.info_rounded,
                                    color: AppColor.deepBlue,
                                    size: kMessageIconSize,
                                  ),
                                  title: Text(
                                      state.fetchMessagesModel.data![index]
                                          .notificationmessage!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black)),
                                  subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          top: xxTinierSpacing),
                                      child: Text(
                                          state.fetchMessagesModel.data![index]
                                              .processedDate!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.grey)))))));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTiniestSpacing);
                },
              );
            } else if (state is MessagesNotFetched) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  navigateToModule(redirect, redirectionKey, context) {
    switch (redirect) {
      case 'permit':
        Navigator.pushNamed(context, PermitDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'hse':
        Navigator.pushNamed(context, IncidentDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'expensereport':
        Navigator.pushNamed(context, ExpenseDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'loto':
        Navigator.pushNamed(context, LotoDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'certificatecourse':
        Navigator.pushNamed(context, GetCourseCertificateScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'workorder':
        Navigator.pushNamed(context, WorkOrderDetailsTabScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'checklist':
        Navigator.pushNamed(context, SystemUserCheckListScreen.routeName,
            arguments: true);
        break;
      case 'wf_ecklist':
        Navigator.pushNamed(context, WorkForceListScreen.routeName);
        break;
      case 'sl':
        Navigator.pushNamed(context, LogBookDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'todo':
        Navigator.pushNamed(
            context, ToDoDetailsAndDocumentDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'qareport':
        Navigator.pushNamed(context, QualityManagementDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'dms':
        Navigator.pushNamed(context, DocumentsListScreen.routeName,
            arguments: true);
        break;
      case 'safetyNotice':
        Navigator.pushNamed(context, SafetyNoticeDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'tickets':
        Navigator.pushNamed(context, TicketDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'hf':
        Navigator.pushNamed(context, TripsDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
      case 'wf_trips':
        Navigator.pushNamed(context, TripsDetailsScreen.routeName,
            arguments: redirectionKey);
        break;
    }
  }
}
