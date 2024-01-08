import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_bloc.dart';
import 'package:toolkit/blocs/LogBook/logbook_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/LogBook/logbook_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/LogBook/fetch_logbook_master_model.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import 'logbook_list_screen.dart';
import 'widgets/logbook_activity_expansion_tile.dart';
import 'widgets/logbook_handover_expansion_tile.dart';
import 'widgets/logbook_location_list_tile.dart';
import 'widgets/logbook_priority_expansion_tile.dart';
import 'widgets/register_new_logbook_type_expansion_tile.dart';

class ReportNewLogBookScreen extends StatelessWidget {
  final List<List<LogBokFetchMaster>> data;
  final Map addLogbookMap;

  ReportNewLogBookScreen(
      {Key? key, required this.data, required this.addLogbookMap})
      : super(key: key);
  final Map reportNewLogBookMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ReportNewLog')),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              textValue: DatabaseUtil.getText('buttonBack'),
            )),
            const SizedBox(width: xxTinierSpacing),
            BlocListener<LogbookBloc, LogbookStates>(
              listener: (context, state) {
                if (state is NewLogBookReporting) {
                  ProgressBar.show(context);
                } else if (state is NewLogBookReported) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, LogbookListScreen.routeName,
                      arguments: false);
                } else if (state is NewLogBookNotReported) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(context, state.logbookNotReported, '');
                }
              },
              child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      reportNewLogBookMap['logbookid'] =
                          addLogbookMap['logbookId'].toString();
                      context.read<LogbookBloc>().add(
                          ReportNewLogBook(reportLogbook: reportNewLogBookMap));
                    },
                    textValue: DatabaseUtil.getText('Save')),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCard(
                  child: Padding(
                padding: const EdgeInsets.all(xxTinySpacing),
                child: Row(
                  children: [
                    Text('${DatabaseUtil.getText('Name')}:',
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black)),
                    const SizedBox(width: xxxTinierSpacing),
                    Text(addLogbookMap['logbookName'],
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500))
                  ],
                ),
              )),
              const SizedBox(height: tinySpacing),
              Text(DatabaseUtil.getText('Eventdate'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              DatePickerTextField(
                onDateChanged: (String date) {
                  reportNewLogBookMap['eventdate'] = date;
                },
              ),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Eventtime'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TimePickerTextField(
                onTimeChanged: (String time) {
                  reportNewLogBookMap['eventtime'] = time;
                },
              ),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Component'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: '',
                  maxLength: 100,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  onTextFieldChanged: (String textField) {
                    reportNewLogBookMap['component'] = textField;
                  }),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Description'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              TextFieldWidget(
                  value: '',
                  maxLength: 250,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  onTextFieldChanged: (String textField) {
                    reportNewLogBookMap['description'] = textField;
                  }),
              LogBookLocationListTile(
                  data: data, reportNewLogBookMap: reportNewLogBookMap),
              Text(DatabaseUtil.getText('type'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              RegisterNewLogBookTypeExpansionTile(
                  data: data, reportNewLogBookMap: reportNewLogBookMap),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Activity'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              LogBookActivityExpansionTile(
                  data: data, reportNewLogBookMap: reportNewLogBookMap),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('Priority'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              LogBookPriorityExpansionTile(
                  reportNewLogBookMap: reportNewLogBookMap),
              const SizedBox(height: xxTinySpacing),
              Text(DatabaseUtil.getText('HandoverLog'),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              LogBookHandoverExpansionTile(
                  reportNewLogBookMap: reportNewLogBookMap),
              const SizedBox(height: xxTinySpacing),
            ],
          ),
        ),
      ),
    );
  }
}
