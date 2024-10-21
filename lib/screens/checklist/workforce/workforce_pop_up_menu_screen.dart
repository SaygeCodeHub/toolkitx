import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_edit_answer_screen.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_reject_reason_screen.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_view_documents_screen.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../configs/app_spacing.dart';
import '../../../blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_bloc.dart';
import '../../../blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_events.dart';
import '../../../blocs/checklist/workforce/popUpMenu/workforce_checklist_pop_up_menu_states.dart';

class WorkForcePopUpMenu extends StatelessWidget {
  final Map checklistDataMap;

  const WorkForcePopUpMenu({super.key, required this.checklistDataMap});

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkForceCheckListPopUpMenuItemsBloc>()
        .add(WorkForceCheckListFetchPopUpMenuItems(
          popUpMenuItems: [],
        ));
    return BlocBuilder<WorkForceCheckListPopUpMenuItemsBloc,
        CheckListWorkForcePopUpMenuItemsFetched>(builder: (context, state) {
      return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          iconSize: kIconSize,
          icon: const Icon(Icons.more_vert_outlined),
          offset: const Offset(0, xxTinierSpacing),
          onSelected: (value) {
            if (value == DatabaseUtil.getText('Edit')) {
              Navigator.pushNamed(context, EditAnswerListScreen.routeName,
                  arguments: checklistDataMap);
            }
            if (value == DatabaseUtil.getText('Reject')) {
              Navigator.pushNamed(context, RejectReasonsScreen.routeName,
                  arguments: checklistDataMap);
            }
            if (value == DatabaseUtil.getText('view_Details')) {
              Navigator.pushNamed(
                  context, WorkForceViewDocumentsScreen.routeName,
                  arguments: checklistDataMap);
            }
          },
          position: PopupMenuPosition.under,
          itemBuilder: (BuildContext context) {
            return List.generate(state.popUpMenuItems.length, (index) {
              return _buildPopupMenuItem(context, state.popUpMenuItems[index],
                  state.popUpMenuItems[index]);
            });
          });
    });
  }
}
