
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/text_button.dart';
import 'get_permit_roles_screen.dart';
import 'permit_filter_screen.dart';
import 'widgets/permit_list_tile.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';
  final bool isFromHome;
  static int page = 1;
  static List permitListData = [];

  const PermitListScreen({Key? key, this.isFromHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<PermitBloc>()
        .add(GetAllPermits(isFromHome: isFromHome, page: page));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('PermitToWork')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  BlocBuilder<PermitBloc, PermitStates>(
                      buildWhen: (previousState, currentState) {
                    if (currentState is FetchingAllPermits &&
                        isFromHome == true) {
                      return true;
                    } else if (currentState is AllPermitsFetched) {
                      return true;
                    }
                    return false;
                  }, builder: (context, state) {
                    if (state is AllPermitsFetched) {
                      return Visibility(
                          visible: state.filters.isNotEmpty,
                          child: CustomTextButton(
                              onPressed: () {
                                page = 1;
                                permitListData.clear();
                                PermitListTile.noMoreData = false;
                                context
                                    .read<PermitBloc>()
                                    .add(const ClearPermitFilters());
                                context.read<PermitBloc>().add(GetAllPermits(
                                    isFromHome: isFromHome, page: 1));
                              },
                              textValue: DatabaseUtil.getText('Clear')));
                    } else {
                      return const SizedBox();
                    }
                  }),
                  CustomIconButtonRow(
                      isEnabled: true,
                      primaryOnPress: () {
                        PermitFilterScreen.isFromLocation = false;
                        Navigator.pushNamed(
                            context, PermitFilterScreen.routeName);
                      },
                      secondaryOnPress: () {
                        Navigator.pushNamed(
                            context, GetPermitRolesScreen.routeName);
                      },
                      clearOnPress: () {})
                ]),
                const SizedBox(height: xxTinierSpacing),
                PermitListTile(permitListData: permitListData)
              ],
            )));
  }
}
