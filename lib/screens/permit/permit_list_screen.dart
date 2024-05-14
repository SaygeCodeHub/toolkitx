import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_events.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/progress_bar.dart';
import 'get_permit_roles_screen.dart';
import 'permit_filter_screen.dart';
import 'widgets/permit_list_tile.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';
  final bool isFromHome;
  static int page = 1;

  const PermitListScreen({Key? key, this.isFromHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    page = 1;
    context.read<PermitBloc>().listReachedMax = false;
    context.read<PermitBloc>().permitListData = [];
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
            child: BlocConsumer<PermitBloc, PermitStates>(
                listener: (context, state) {
              if (state is PreparingPermitLocalDatabase) {
                ProgressBar.show(context);
              }
              if (state is PermitLocalDatabasePrepared) {
                showCustomSnackBar(
                    context, StringConstants.kOfflineDataReady, '');
                ProgressBar.dismiss(context);
              }
              if (state is PreparingPermitLocalDatabaseFailed) {
                showCustomSnackBar(context,
                    StringConstants.kOfflineFailedInDataPreparation, '');
                ProgressBar.dismiss(context);
              }
            }, builder: (context, state) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<PermitBloc, PermitStates>(
                        builder: (context, state) {
                      return CustomIconButtonRow(
                          downloadVisible: true,
                          onDownloadPress: () {
                            context
                                .read<PermitBloc>()
                                .add(PreparePermitLocalDatabase());
                          },
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
                          clearVisible:
                              context.read<PermitBloc>().filters.isNotEmpty,
                          clearOnPress: () {
                            page = 1;
                            context
                                .read<PermitBloc>()
                                .add(const ClearPermitFilters());
                            context.read<PermitBloc>().add(
                                GetAllPermits(isFromHome: isFromHome, page: 1));
                          });
                    }),
                    const SizedBox(height: xxTinierSpacing),
                    const PermitListTile()
                  ]);
            })));
  }
}
