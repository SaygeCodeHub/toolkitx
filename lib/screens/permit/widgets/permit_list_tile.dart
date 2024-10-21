import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../blocs/permit/permit_states.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../permit_list_screen.dart';
import 'permit_list_card.dart';

class PermitListTile extends StatelessWidget {
  const PermitListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermitBloc, PermitStates>(
        buildWhen: (previousState, currentState) =>
            ((currentState is AllPermitsFetched) ||
                (currentState is FetchingAllPermits &&
                    PermitListScreen.page == 1 &&
                    context.read<PermitBloc>().permitListData.isEmpty)),
        listener: (context, state) {
          if (state is AllPermitsFetched) {
            if (state.allPermitModel.status == 204 &&
                context.read<PermitBloc>().permitListData.isNotEmpty) {
              showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
            }
          }
        },
        builder: (context, state) {
          if (state is FetchingAllPermits) {
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: const CircularProgressIndicator()));
          } else if (state is AllPermitsFetched) {
            if (context.read<PermitBloc>().permitListData.isNotEmpty) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (!context.read<PermitBloc>().listReachedMax)
                          ? state.permitListData.length + 1
                          : state.permitListData.length,
                      itemBuilder: (context, index) {
                        if (index <
                            context.read<PermitBloc>().permitListData.length) {
                          return PermitListCard(
                              allPermitDatum: state.permitListData[index]);
                        } else if (!context.read<PermitBloc>().listReachedMax) {
                          PermitListScreen.page++;
                          context.read<PermitBloc>().add(GetAllPermits(
                              isFromHome: false, page: PermitListScreen.page));
                          return const Center(
                              child: Padding(
                                  padding: EdgeInsets.all(
                                      kCircularProgressIndicatorPadding),
                                  child: SizedBox(
                                      width: kCircularProgressIndicatorWidth,
                                      child: CircularProgressIndicator())));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      }));
            } else {
              if (state.allPermitModel.status == 204 &&
                  context.read<PermitBloc>().permitListData.isEmpty) {
                if (context.read<PermitBloc>().filters.isEmpty) {
                  return const NoRecordsText(
                      text: StringConstants.kNoRecordsFilter);
                } else {
                  return NoRecordsText(
                      text: DatabaseUtil.getText('no_records_found'));
                }
              } else {
                return NoRecordsText(
                    text: DatabaseUtil.getText('no_records_found'));
              }
            }
          } else {
            return const SizedBox();
          }
        });
  }
}
