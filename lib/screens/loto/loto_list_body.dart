import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/loto/widgets/loto_list_tile.dart';
import '../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/generic_no_records_text.dart';
import 'loto_list_screen.dart';

class LotoList extends StatelessWidget {
  final bool isFromHome;

  const LotoList({Key? key, required this.isFromHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LotoListBloc, LotoListState>(
      buildWhen: (previousState, currentState) =>
          ((currentState is LotoListFetched) ||
              (currentState is FetchingLotoList && LotoListScreen.pageNo == 1)),
      listener: (context, state) {
        if (state is LotoListFetched) {
          if (state.fetchLotoListModel.status == 204 &&
              context.read<LotoListBloc>().data.isNotEmpty) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
      builder: (context, state) {
        if (state is FetchingLotoList) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is LotoListFetched) {
          if (context.read<LotoListBloc>().data.isNotEmpty) {
            return Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: context.read<LotoListBloc>().hasReachedMax
                      ? context.read<LotoListBloc>().data.length
                      : context.read<LotoListBloc>().data.length + 1,
                  itemBuilder: (context, index) {
                    if (index < context.read<LotoListBloc>().data.length) {
                      return LotoListTile(index: index);
                    } else if (!state.hasReachedMax) {
                      LotoListScreen.pageNo++;
                      context.read<LotoListBloc>().add(FetchLotoList(
                            pageNo: LotoListScreen.pageNo,
                            isFromHome: isFromHome,
                          ));
                      return const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.all(kCircularProgressIndicatorPadding),
                          child: SizedBox(
                              width: kCircularProgressIndicatorWidth,
                              child: CircularProgressIndicator()),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: tinierSpacing);
                  }),
            );
          } else if (state.fetchLotoListModel.status == 204 &&
              context.read<LotoListBloc>().data.isEmpty) {
            if (context.read<LotoListBloc>().filters.isNotEmpty) {
              return const NoRecordsText(
                  text: StringConstants.kNoRecordsFilter);
            } else {
              return NoRecordsText(
                  text: DatabaseUtil.getText('no_records_found'));
            }
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
