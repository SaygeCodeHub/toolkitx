import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/generic_no_records_text.dart';
import '../../../widgets/progress_bar.dart';
import '../loto_assign_workfoce_screen.dart';
import 'loto_assign_workforce_card.dart';

class LotoAssignWorkforceBody extends StatelessWidget {
  const LotoAssignWorkforceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LotoDetailsBloc, LotoDetailsState>(
      buildWhen: (previousState, currentState) =>
          (currentState is LotoAssignWorkforceFetching &&
              LotoAssignWorkforceScreen.pageNo == 1 &&
              context.read<LotoDetailsBloc>().assignWorkforceDatum.isEmpty) ||
          currentState is LotoAssignWorkforceFetched ||
          currentState is LotoAssignWorkforceError ||
          currentState is LotoAssignWorkforceSearched,
      listener: (context, state) {
        if (state is LotoAssignWorkforceSaving) {
          ProgressBar.show(context);
        } else if (state is LotoAssignWorkforceSaved) {
          ProgressBar.dismiss(context);
          LotoAssignWorkforceScreen.pageNo = 1;
          context.read<LotoDetailsBloc>().assignWorkforceDatum = [];
          context.read<LotoDetailsBloc>().add(FetchLotoAssignWorkforce(
              pageNo: 1,
              isRemove: LotoAssignWorkforceScreen.isRemove,
              workforceName: ''));
          showCustomSnackBar(context, StringConstants.kWorkforceAssigned, '');
        } else if (state is LotoAssignWorkforceNotSaved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong, '');
        }
        if (state is LotoAssignWorkforceFetched) {
          if (state.fetchLotoAssignWorkforceModel.status == 204 &&
              context.read<LotoDetailsBloc>().assignWorkforceDatum.isNotEmpty) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
      builder: (context, state) {
        if (state is LotoAssignWorkforceFetching) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is LotoAssignWorkforceFetched) {
          if (context.read<LotoDetailsBloc>().assignWorkforceDatum.isNotEmpty) {
            return Expanded(
                child: ListView.separated(
                    itemCount: context
                                .read<LotoDetailsBloc>()
                                .lotoWorkforceReachedMax ==
                            true
                        ? context
                            .read<LotoDetailsBloc>()
                            .assignWorkforceDatum
                            .length
                        : context
                                .read<LotoDetailsBloc>()
                                .assignWorkforceDatum
                                .length +
                            1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index <
                          context
                              .read<LotoDetailsBloc>()
                              .assignWorkforceDatum
                              .length) {
                        return LotoAssignWorkforceCard(
                          workForceDatum: context
                              .read<LotoDetailsBloc>()
                              .assignWorkforceDatum[index],
                        );
                      } else if (!context
                          .read<LotoDetailsBloc>()
                          .lotoWorkforceReachedMax) {
                        LotoAssignWorkforceScreen.pageNo++;
                        context.read<LotoDetailsBloc>().add(
                            FetchLotoAssignWorkforce(
                                pageNo: LotoAssignWorkforceScreen.pageNo,
                                isRemove: LotoAssignWorkforceScreen.isRemove,
                                workforceName: ''));
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
                      return const SizedBox(height: tiniestSpacing);
                    }));
          } else if (state.fetchLotoAssignWorkforceModel.status == 204 &&
              context.read<LotoDetailsBloc>().assignWorkforceDatum.isEmpty) {
            return NoRecordsText(
                text: DatabaseUtil.getText('no_records_found'));
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
