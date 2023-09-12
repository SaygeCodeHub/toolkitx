import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:toolkit/blocs/certificates/startCourseCertificates/start_course_certificate_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/certificates/get_notes_certificate_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';

class GetNotesCertificateScreen extends StatelessWidget {
  static const routeName = 'GetNotesCertificateScreen';

  const GetNotesCertificateScreen({
    Key? key,
    required this.getNotesMap,
  }) : super(key: key);
  final Map getNotesMap;
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    context
        .read<StartCourseCertificateBloc>()
        .add(GetNotesCertificate(topicId: getNotesMap["id"], pageNo: pageNo));
    return Scaffold(
      appBar: AppBar(),
      body:
          BlocBuilder<StartCourseCertificateBloc, StartCourseCertificateState>(
        buildWhen: (previousState, currentState) =>
            currentState is FetchingGetNotesCertificate ||
            currentState is GetNotesCertificateFetched ||
            currentState is GetNotesCertificateError,
        builder: (context, state) {
          if (state is FetchingGetNotesCertificate) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetNotesCertificateFetched) {
            var unescape = HtmlUnescape();
            var text = unescape.convert(state.fetchGetNotesModel.data.notes);
            return Padding(
              padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${getNotesMap["certificatename"]} -> ${getNotesMap["coursename"]}",
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w600, color: AppColor.black)),
                  const SizedBox(
                    height: tiniestSpacing,
                  ),
                  Text(getNotesMap["name"],
                      style: Theme.of(context).textTheme.small.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.mediumBlack)),
                  const SizedBox(
                    height: tinySpacing,
                  ),
                  GetNotesCertificateBody(
                    data: state.fetchGetNotesModel.data, pageNo: pageNo,
                  ),
                  // const SizedBox(
                  //   height: tinierSpacing,
                  // ),
                  // Text(pageNo != 3 ? text : '',
                  //     style: Theme.of(context).textTheme.xSmall.copyWith(
                  //         fontWeight: FontWeight.w500, color: AppColor.grey)),
                  Html(data: pageNo != 3 ? text: ''),
                  const SizedBox(
                    height: tinierSpacing,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: (pageNo > 1) ? !isVisible : isVisible,
                        child: SizedBox(
                          width: 150,
                          child: PrimaryButton(
                              onPressed: () {
                                pageNo -= 1;
                                context.read<StartCourseCertificateBloc>().add(
                                    GetNotesCertificate(
                                        topicId: getNotesMap["id"],
                                        pageNo: pageNo));
                                log("pageNo=========> $pageNo");
                              },
                              textValue: StringConstants.kPREVIOUS),
                        ),
                      ),
                      const SizedBox(
                        width: tinierSpacing,
                      ),
                      Visibility(
                        visible:
                            pageNo.toString() != state.fetchGetNotesModel.data.notescount,
                        replacement:SizedBox(
                          width: 100,
                          child: PrimaryButton(
                              onPressed: () {

                              },
                              textValue: StringConstants.kFINISH),
                        ) ,
                        child: SizedBox(
                          width: 100,
                          child: PrimaryButton(
                              onPressed: () {
                                pageNo++;
                                log("pageNo=========> $pageNo");
                                context.read<StartCourseCertificateBloc>().add(
                                    GetNotesCertificate(
                                        topicId: getNotesMap["id"],
                                        pageNo: pageNo));
                              },
                              textValue: (pageNo < 4)
                                  ? StringConstants.kNext
                                  : "Finish"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
