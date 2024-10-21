import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/qualityManagement/widgets/qm_common_comments_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../blocs/qualityManagement/qm_states.dart';
import '../../../data/enums/qm_status_enum.dart';
import '../../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class QualityManagementMarkAsResolvedScreen extends StatelessWidget {
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;

  QualityManagementMarkAsResolvedScreen(
      {super.key, required this.fetchQualityManagementDetailsModel});
  final Map qmCommentsMap = {};
  static int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kResolve),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              QualityManagementCommonCommentsSection(
                  onPhotosUploaded: (List<dynamic> uploadList) {
                    qmCommentsMap['filenames'] = uploadList
                        .toString()
                        .replaceAll("[", '')
                        .replaceAll(']', '');
                  },
                  onTextFieldValue: (String textValue) {
                    qmCommentsMap['comments'] = textValue;
                  },
                  qmCommentsMap: qmCommentsMap,
                  fetchQualityManagementDetailsModel:
                      fetchQualityManagementDetailsModel,
                  imageIndex: imageIndex),
              BlocListener<QualityManagementBloc, QualityManagementStates>(
                  listener: (context, state) {
                    if (state is QualityManagementSavingComments) {
                      ProgressBar.show(context);
                    } else if (state is QualityManagementCommentsSaved) {
                      ProgressBar.dismiss(context);
                      Navigator.pop(context);
                      context.read<QualityManagementBloc>().add(
                          FetchQualityManagementDetails(
                              initialIndex: 0, qmId: state.qmId));
                    } else if (state is QualityManagementCommentsNotSaved) {
                      ProgressBar.dismiss(context);
                      showCustomSnackBar(context, state.commentsNotSaved, '');
                    }
                  },
                  child: PrimaryButton(
                      onPressed: () {
                        qmCommentsMap['status'] =
                            QualityManagementStatusEnum.resolved.value;
                        context.read<QualityManagementBloc>().add(
                            SaveQualityManagementComments(
                                saveCommentsMap: qmCommentsMap));
                      },
                      textValue: StringConstants.kSave)),
            ],
          ),
        ),
      ),
    );
  }
}
