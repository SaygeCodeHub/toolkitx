import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_bloc.dart';
import 'package:toolkit/blocs/accounting/accounting_state.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/enums/accounting/accounting_billable_enum.dart';
import '../../../../utils/constants/string_constants.dart';

class ProjectDropdown extends StatefulWidget {
  final void Function(String selectedValue) onProjectChanged;
  final String initialValue;
  const ProjectDropdown({super.key, required this.onProjectChanged,  this.initialValue=""});

  @override
  State<ProjectDropdown> createState() => _ProjectDropdownState();
}

class _ProjectDropdownState extends State<ProjectDropdown> {
  String selectedText = '';
  String selectedValue = '';
  @override
void initState() {

    super.initState();
    selectedText= widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
            maintainState: true,
            key: GlobalKey(),
            title: Text(
                (selectedText.isEmpty) ? StringConstants.kSelect : selectedText,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              BlocBuilder<AccountingBloc, AccountingState>(
                buildWhen: (previousState, currentState) =>
                    currentState is AccountingProjectListFetching ||
                    currentState is AccountingProjectListFetched ||
                    currentState is AccountingProjectListNotFetched,
                builder: (context, state) {
                  if (state is AccountingProjectListFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AccountingProjectListFetched) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.projectList.length,
                        itemBuilder: (context, index) {
                          final project = state.projectList[index];
                          return ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: xxxTinierSpacing),
                              title: Text(state.projectList[index].name,
                                  style: Theme.of(context).textTheme.xSmall),
                              onTap: () {
                                setState(() {
                                  selectedText = project.name;
                                  selectedValue = AccountingBillableEnum
                                      .values[index].billValue;
                                });
                                widget.onProjectChanged(selectedValue);
                              });
                        });
                  } else if (state is AccountingProjectListNotFetched) {
                    return const Center(
                        child: Text(StringConstants.kNoRecordsFound));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ]));
  }
}
