import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import '../../blocs/qualityManagement/qm_events.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/qualityManagement/fetch_qm_details_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import 'widgets/qm_common_comments_section.dart';

class QualityManagementAddCommentsScreen extends StatelessWidget {
  static const routeName = 'QualityManagementAddCommentsScreen';
  final FetchQualityManagementDetailsModel fetchQualityManagementDetailsModel;

  QualityManagementAddCommentsScreen(
      {Key? key, required this.fetchQualityManagementDetailsModel})
      : super(key: key);
  final Map qmCommentsMap = {};
  static int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('Comments')),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar:
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
              child: Padding(
                padding: const EdgeInsets.all(xxTinierSpacing),
                child: PrimaryButton(
                    onPressed: () {
                      qmCommentsMap['status'] =
                          fetchQualityManagementDetailsModel.data.nextStatus;
                      context.read<QualityManagementBloc>().add(
                          SaveQualityManagementComments(
                              saveCommentsMap: qmCommentsMap));
                    },
                    textValue: StringConstants.kSave),
              )),
    );
  }
}
