import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/widgets/save_permit_edit_safety_notice_button.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/permit/edit_safety_document_plot_util.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

class PermitEditSafetyDocumentScreen extends StatelessWidget {
  static const routeName = 'PermitEditSafetyDocumentScreen';
  final String permitId;
  final Map editSafetyDocumentMap = {};

  PermitEditSafetyDocumentScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(FetchDataForOpenPermit(permitId: permitId));
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kEditSafetyDocument),
      bottomNavigationBar: SavePermitEditSafetyNoticeButton(
          editSafetyDocumentMap: editSafetyDocumentMap, permitId: permitId),
      body: BlocBuilder<PermitBloc, PermitStates>(
        buildWhen: (previousState, currentState) =>
            currentState is DataForOpenPermitFetching ||
            currentState is DataForOpenPermitFetched ||
            currentState is DataForOpenPermitNotFetched,
        builder: (context, state) {
          if (state is DataForOpenPermitFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataForOpenPermitFetched) {
            editSafetyDocumentMap['panel_12'] =
                state.fetchDataForOpenPermitModel.data?.panel12;
            editSafetyDocumentMap['panel_15'] =
                state.fetchDataForOpenPermitModel.data?.panel15;
            editSafetyDocumentMap['panel_16'] =
                state.fetchDataForOpenPermitModel.data?.panel16;
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: topBottomPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringConstants.kPermitNo,
                          style: Theme.of(context)
                              .textTheme
                              .xSmall
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: xxxTinierSpacing),
                      TextFieldWidget(
                          value: state.fetchDataForOpenPermitModel.data
                                  ?.permitName ??
                              '',
                          readOnly: true,
                          onTextFieldChanged: (String textValue) {}),
                      const SizedBox(height: xxTinySpacing),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.questions.length,
                          itemBuilder: (context, index) {
                            return EditSafetyDocumentPlotUtil().renderUI(
                                state.questions[index].questionNo,
                                context,
                                editSafetyDocumentMap,
                                state.fetchDataForOpenPermitModel);
                          }),
                    ],
                  )),
            );
          } else if (state is DataForOpenPermitNotFetched) {
            return const NoRecordsText(text: StringConstants.kNoRecordsFound);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
