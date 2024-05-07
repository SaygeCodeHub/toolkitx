import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/certificate_util.dart';
import '../../../../configs/app_color.dart';
import '../../../../utils/database_utils.dart';
import '../../../../widgets/expansion_tile_border.dart';

typedef FeedbackAnswerCallBack = Function(String questionId, String answer);

class FeedbackAnswerExpansionTile extends StatefulWidget {
  final FeedbackAnswerCallBack onFeedbackAnswerChecked;
  final String? editValue;

  const FeedbackAnswerExpansionTile(
      {Key? key,
      required this.onFeedbackAnswerChecked,
      required this.editValue})
      : super(key: key);

  @override
  State<FeedbackAnswerExpansionTile> createState() =>
      _FeedbackAnswerExpansionTileState();
}

class _FeedbackAnswerExpansionTileState
    extends State<FeedbackAnswerExpansionTile> {
  String radioValue = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            collapsedShape: ExpansionTileBorder().buildOutlineInputBorder(),
            collapsedBackgroundColor: AppColor.white,
            backgroundColor: AppColor.white,
            shape: ExpansionTileBorder().buildOutlineInputBorder(),
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                (radioValue == '')
                    ? DatabaseUtil.getText('select_item')
                    : radioValue,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: CertificateUtil().answerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: xxTinierSpacing),
                      child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: AppColor.deepBlue,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(
                              CertificateUtil().answerList[index]['answer']!),
                          value: CertificateUtil().answerList[index]['value'],
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              value =
                                  CertificateUtil().answerList[index]['value'];
                              radioValue = CertificateUtil().answerList[index]
                                  ['answer']!;
                              widget.onFeedbackAnswerChecked(value!, value!);
                            });
                          }),
                    );
                  })
            ]));
  }
}
