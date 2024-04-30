import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_text_field.dart';

import '../configs/app_color.dart';
import '../configs/app_spacing.dart';
import '../data/models/expense/expense_item_custom_field_model.dart';
import 'constants/string_constants.dart';

typedef ExpenseCustomFieldCallBack = Function(String answers);

class ExpenseAddItemCustomFieldUtil {
  viewCustomFields(context, List<CustomFieldData> data,
      List<Map<String, dynamic>> expenseCustomFieldList) {
    return Visibility(
      visible: data.isNotEmpty,
      child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            print('custom fields ${data[index].optiontextid}');
            expenseCustomFieldList.add({
              // 'questionid': ,
              // 'answer':
            });
            switch (data[index].type) {
              case 1:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxTinierSpacing),
                    TextFieldWidget(
                        maxLines: 1,
                        maxLength: 250,
                        textInputAction: TextInputAction.done,
                        value: '',
                        onTextFieldChanged: (String textValue) {
                          expenseCustomFieldList[index]['questionid'] =
                              data[index].id;
                          expenseCustomFieldList[index]['answer'] = textValue;
                        }),
                    const SizedBox(height: xxTinierSpacing),
                  ],
                );
              case 3:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: xxTinierSpacing),
                    CustomQuestionsRadioTile(
                      queOption: data[index].queoptions,
                      expenseCustomFieldCallBack: (String answers) {
                        expenseCustomFieldList[index]['questionid'] =
                            data[index].id;
                        expenseCustomFieldList[index]['answer'] = answers;
                      },
                    )
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          }),
    );
  }
}

class CustomQuestionsRadioTile extends StatefulWidget {
  final ExpenseCustomFieldCallBack expenseCustomFieldCallBack;
  final List<QueOption> queOption;

  const CustomQuestionsRadioTile(
      {super.key,
      required this.queOption,
      required this.expenseCustomFieldCallBack});

  @override
  State<CustomQuestionsRadioTile> createState() =>
      _CustomQuestionsRadioTileState();
}

class _CustomQuestionsRadioTileState extends State<CustomQuestionsRadioTile> {
  String questionId = '';
  String questionAnswer = StringConstants.kSelect;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
      child: ExpansionTile(
        maintainState: true,
        key: GlobalKey(),
        title: Text(questionAnswer, style: Theme.of(context).textTheme.xSmall),
        children: [
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.queOption.length,
              itemBuilder: (context, itemIndex) {
                return RadioListTile(
                    activeColor: AppColor.deepBlue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.queOption[itemIndex].queoptiontext),
                    value: widget.queOption[itemIndex].queoptionid.toString(),
                    groupValue: questionId,
                    onChanged: (val) {
                      setState(() {
                        questionId =
                            widget.queOption[itemIndex].queoptionid.toString();
                        questionAnswer =
                            widget.queOption[itemIndex].queoptiontext;
                        widget.expenseCustomFieldCallBack(questionId);
                      });
                    });
              })
        ],
      ),
    );
  }
}
