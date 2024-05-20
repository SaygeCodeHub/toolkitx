import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/incident_details_body.dart';
import 'incident_pop_up_menu_screen.dart';

class IncidentDetailsScreen extends StatelessWidget {
  final String incidentId;
  static const routeName = 'IncidentDetailsScreen';

  const IncidentDetailsScreen({Key? key, required this.incidentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<IncidentDetailsBloc>().add(FetchIncidentDetailsEvent(
        incidentId: incidentId,
        role: context.read<IncidentLisAndFilterBloc>().roleId,
        initialIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<IncidentDetailsBloc, IncidentDetailsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingIncidentDetails ||
                  currentState is IncidentDetailsFetched,
              builder: (context, state) {
                if (state is IncidentDetailsFetched) {
                  if (state.showPopUpMenu == true) {
                    return IncidentDetailsPopUpMenu(
                        incidentDetailsModel: state.incidentDetailsModel,
                        popUpMenuItems: state.incidentPopUpMenu,
                        incidentId: incidentId,
                        incidentDetailsMap: state.editIncidentDetailsMap);
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              }),
        ]),
        body: BlocConsumer<IncidentDetailsBloc, IncidentDetailsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingIncidentDetails ||
                currentState is IncidentDetailsFetched ||
                currentState is IncidentDetailsNotFetched,
            listener: (context, state) {
              if (state is GeneratingIncidentPDF) {
                ProgressBar.show(context);
              }
              if (state is IncidentPDFGenerated) {
                ProgressBar.dismiss(context);
                launchUrlString(
                    '${ApiConstants.baseDocUrl}${state.pdfLink}.pdf',
                    mode: LaunchMode.externalApplication);
              } else if (state is IncidentPDFGenerationFailed) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(
                    context,
                    DatabaseUtil.getText('some_unknown_error_please_try_again'),
                    '');
              }
            },
            builder: (context, state) {
              if (state is FetchingIncidentDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is IncidentDetailsFetched) {
                return IncidentDetailsBody(
                    incidentId: incidentId,
                    incidentDetailsModel: state.incidentDetailsModel,
                    clientId: state.clientId);
              } else if (state is IncidentDetailsNotFetched) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<IncidentDetailsBloc>().add(
                              FetchIncidentDetailsEvent(
                                  incidentId: incidentId,
                                  role: context
                                      .read<IncidentLisAndFilterBloc>()
                                      .roleId,
                                  initialIndex: 0));
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }));
  }
}
