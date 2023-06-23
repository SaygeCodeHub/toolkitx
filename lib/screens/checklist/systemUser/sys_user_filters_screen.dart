import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_filter_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'FiltersScreen';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SysUserCheckListBloc>().add(FetchCheckListMaster());
    return Scaffold(
        appBar: const GenericAppBar(
          title: StringConstants.kFilters,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: FilterSection()));
  }
}
