import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/get_notes_certificate_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class GetNotesCertificateScreen extends StatelessWidget {
  static const routeName = 'GetNotesCertificateScreen';

  const GetNotesCertificateScreen({Key? key, required this.getNotesMap})
      : super(key: key);
  final Map getNotesMap;
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    String noteCount = '';
    pageNo = 1;
    context
        .read<StartCourseCertificateBloc>()
        .add(GetNotesCertificate(topicId: getNotesMap["id"], pageNo: 1));
    return Scaffold(
      appBar: const GenericAppBar(),
      body:
          BlocBuilder<StartCourseCertificateBloc, StartCourseCertificateState>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingGetNotesCertificate ||
            currentState is GetNotesCertificateFetched ||
            currentState is GetNotesCertificateError,
        builder: (context, state) {
          if (state is FetchingGetNotesCertificate) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetNotesCertificateFetched) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: xxTinierSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${getNotesMap["certificatename"]} -> ${getNotesMap["coursename"]}",
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w600, color: AppColor.black)),
                  const SizedBox(height: tiniestSpacing),
                  Text(getNotesMap["name"],
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.mediumBlack)),
                  const SizedBox(height: tinySpacing),
                  GetNotesCertificateBody(
                    data: state.fetchGetNotesModel.data,
                    pageNo: pageNo,
                    clientId: state.clientId,
                  ),
                  const SizedBox(height: tinierSpacing),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: BlocConsumer<StartCourseCertificateBloc,
            StartCourseCertificateState>(
          listener: (context, state) {
            if (state is UserTrackUpdating) {
              ProgressBar.show(context);
            } else if (state is UserTrackUpdated) {
              ProgressBar.dismiss(context);
              if (pageNo.toString() == noteCount) {
                Navigator.pop(context);
                context.read<StartCourseCertificateBloc>().add(
                    GetTopicCertificate(
                        courseId: context
                            .read<StartCourseCertificateBloc>()
                            .courseId));
              } else {
                pageNo++;
                context.read<StartCourseCertificateBloc>().add(
                    GetNotesCertificate(
                        topicId: getNotesMap["id"], pageNo: pageNo));
              }
            } else if (state is UserTrackUpdateError) {
              ProgressBar.dismiss(context);
              showCustomSnackBar(context, state.error, '');
            }
          },
          buildWhen: (previousState, currentState) =>
              currentState is FetchingGetNotesCertificate ||
              currentState is GetNotesCertificateFetched ||
              currentState is GetNotesCertificateError,
          builder: (context, state) {
            if (state is GetNotesCertificateFetched) {
              noteCount = state.fetchGetNotesModel.data.notescount;
              return Row(
                children: [
                  Visibility(
                      visible: (pageNo > 1) ? !isVisible : isVisible,
                      child: Expanded(
                          child: PrimaryButton(
                              onPressed: () {
                                pageNo -= 1;
                                context.read<StartCourseCertificateBloc>().add(
                                    GetNotesCertificate(
                                        topicId: getNotesMap["id"],
                                        pageNo: pageNo));
                              },
                              textValue: StringConstants.kPREVIOUS))),
                  const SizedBox(width: tinierSpacing),
                  Visibility(
                      visible: pageNo.toString() !=
                          state.fetchGetNotesModel.data.notescount,
                      replacement: Expanded(
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<StartCourseCertificateBloc>().add(
                                    UpdateUserTrack(
                                        certificateId: context
                                            .read<StartCourseCertificateBloc>()
                                            .certificateId,
                                        noteId:
                                            state.fetchGetNotesModel.data.id,
                                        idm: getNotesMap["id"]));
                              },
                              textValue: StringConstants.kFINISH)),
                      child: Expanded(
                          child: PrimaryButton(
                              onPressed: () {
                                context.read<StartCourseCertificateBloc>().add(
                                    UpdateUserTrack(
                                        certificateId: context
                                            .read<StartCourseCertificateBloc>()
                                            .certificateId,
                                        noteId:
                                            state.fetchGetNotesModel.data.id,
                                        idm: getNotesMap["id"]));
                              },
                              textValue: StringConstants.kNext))),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
