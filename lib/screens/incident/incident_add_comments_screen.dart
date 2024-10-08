import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/incident/widgets/incident_add_comments_bottom_navbar.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/incident_details_model.dart';
import 'widgets/incident_common_comments_section.dart';

class IncidentAddCommentsScreen extends StatelessWidget {
  final String incidentId;
  final IncidentDetailsModel incidentDetailsModel;
  final bool showStatusControl;
  final bool isFromAddComment;
  final bool showClassification;

  IncidentAddCommentsScreen(
      {super.key,
      required this.incidentId,
      required this.incidentDetailsModel,
      required this.showStatusControl,
      this.isFromAddComment = false,
      required this.showClassification});

  final Map incidentCommentsMap = {};

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    incidentCommentsMap['incidentId'] = incidentId;
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Comments')),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                IncidentCommonCommentsSection(
                    onPhotosUploaded: (List uploadList) {
                      incidentCommentsMap['file_name'] = uploadList;
                    },
                    onTextFieldValue: (String textValue) {
                      incidentCommentsMap['comments'] = textValue;
                    },
                    incidentCommentsMap: incidentCommentsMap,
                    incidentDetailsModel: incidentDetailsModel,
                    showStatusControl: showStatusControl,
                    showClassification: showClassification)
              ]))),
      bottomNavigationBar: IncidentAddCommentsBottomNavbar(
          incidentCommentsMap: incidentCommentsMap,
          incidentId: incidentId,
          isFromAddComment: isFromAddComment),
    );
  }
}
