import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_filter_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/tankManagement/tank_management_list_body.dart';

class TankManagementListScreen extends StatelessWidget {
  static const routeName = 'TankManagementListScreen';
  final bool isFromHome;
  static int pageNo = 1;

  const TankManagementListScreen({super.key, this.isFromHome = false});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<TankManagementBloc>().hasReachedMax = false;
    context.read<TankManagementBloc>().tankDatum.clear();
    context
        .read<TankManagementBloc>()
        .add(FetchTankManagementList(pageNo: 1, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('tanks')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing,
                bottom: xxTinierSpacing),
            child: Column(children: [
              BlocBuilder<TankManagementBloc, TankManagementState>(
                buildWhen: (previousState, currentState) {
                  if (currentState is TankManagementListFetching &&
                      isFromHome == true) {
                    return true;
                  } else if (currentState is TankManagementListFetched) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is TankManagementListFetched) {
                    return CustomIconButtonRow(
                        primaryOnPress: () {
                          Navigator.pushNamed(
                              context, TankFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        secondaryVisible: false,
                        clearVisible:
                            state.filterMap.isNotEmpty && isFromHome != true,
                        clearOnPress: () {
                          pageNo = 1;
                          context.read<TankManagementBloc>().hasReachedMax =
                              false;
                          context.read<TankManagementBloc>().filterMap.clear();
                          context.read<TankManagementBloc>().tankDatum.clear();
                          context
                              .read<TankManagementBloc>()
                              .add(ClearTankFilter());
                          context.read<TankManagementBloc>().add(
                              FetchTankManagementList(
                                  pageNo: 1, isFromHome: isFromHome));
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Expanded(
                  child: BlocConsumer<TankManagementBloc, TankManagementState>(
                      buildWhen: (previousState, currentState) =>
                          (currentState is TankManagementListFetching &&
                              pageNo == 1) ||
                          (currentState is TankManagementListFetched),
                      listener: (context, state) {
                        if (state is TankManagementListFetched &&
                            context.read<TankManagementBloc>().hasReachedMax) {
                          showCustomSnackBar(
                              context, StringConstants.kAllDataLoaded, '');
                        }
                      },
                      builder: (context, state) {
                        if (state is TankManagementListFetching) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is TankManagementListFetched) {
                          if (state.tankDatum.isNotEmpty) {
                            return TankManagementListBody(
                                tankDatum: state.tankDatum);
                          } else {
                            return const Center(
                                child: Text(StringConstants.kNoRecordsFound));
                          }
                        } else {
                          return const SizedBox.shrink();
                        }
                      }))
            ])));
  }
}
