import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../loto_assign_team_screen.dart';
import 'loto_assign_team_card.dart';

class AssignTeamList extends StatelessWidget {
  const AssignTeamList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LotoDetailsBloc, LotoDetailsState>(
      listener: (context, state) {
        if (state is LotoAssignTeamSaving) {
          ProgressBar.show(context);
        } else if (state is LotoAssignTeamSaved) {
          ProgressBar.dismiss(context);
          LotoAssignTeamScreen.pageNo = 1;
          context.read<LotoDetailsBloc>().lotoAssignTeamDatum = [];
          context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
              pageNo: LotoAssignTeamScreen.pageNo,
              isRemove: LotoAssignTeamScreen.isRemove,
              name: ''));
          showCustomSnackBar(context, StringConstants.kTeamAssigned, '');
        } else if (state is LotoAssignTeamNotSaved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong, '');
        }

        if (state is AssignTeamRemoved) {
          LotoAssignTeamScreen.pageNo = 1;
          context.read<LotoDetailsBloc>().lotoAssignTeamDatum = [];
          context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
              pageNo: LotoAssignTeamScreen.pageNo,
              isRemove: context.read<LotoDetailsBloc>().isRemove,
              name: ''));
          showCustomSnackBar(context, StringConstants.kTeamRemoved, '');
        } else if (state is LotoAssignTeamNotSaved) {
          ProgressBar.show(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong, '');
        }
        if (state is LotoAssignTeamFetched) {
          if (state.fetchLotoAssignTeamModel.status == 204 &&
              context.read<LotoDetailsBloc>().lotoAssignTeamDatum.isNotEmpty) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
      buildWhen: (previousState, currentState) =>
          (currentState is LotoAssignTeamFetching &&
              LotoAssignTeamScreen.pageNo == 1 &&
              context.read<LotoDetailsBloc>().lotoAssignTeamDatum.isNotEmpty) ||
          (currentState is LotoAssignTeamFetched) ||
          currentState is LotoAssignTeamError,
      builder: (context, state) {
        if (state is LotoAssignTeamFetching) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LotoAssignTeamFetched) {
          if (context.read<LotoDetailsBloc>().lotoAssignTeamDatum.isNotEmpty) {
            return Expanded(
              child: ListView.separated(
                itemCount: (context.read<LotoDetailsBloc>().lotoTeamReachedMax)
                    ? context.read<LotoDetailsBloc>().lotoAssignTeamDatum.length
                    : context
                            .read<LotoDetailsBloc>()
                            .lotoAssignTeamDatum
                            .length +
                        1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index <
                      context
                          .read<LotoDetailsBloc>()
                          .lotoAssignTeamDatum
                          .length) {
                    return LotoAssignTeamCard(
                      lotoAssignTeamDatum: context
                          .read<LotoDetailsBloc>()
                          .lotoAssignTeamDatum[index],
                    );
                  } else if (!context
                      .read<LotoDetailsBloc>()
                      .lotoTeamReachedMax) {
                    LotoAssignTeamScreen.pageNo++;
                    context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
                        pageNo: LotoAssignTeamScreen.pageNo,
                        isRemove: LotoAssignTeamScreen.isRemove,
                        name: ''));
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: tinierSpacing),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tiniestSpacing);
                },
              ),
            );
          } else if (state.fetchLotoAssignTeamModel.status == 204 &&
              context.read<LotoDetailsBloc>().assignWorkforceDatum.isEmpty) {
            return NoRecordsText(
                text: DatabaseUtil.getText('no_records_found'));
          } else {
            return const NoRecordsText(text: StringConstants.kNoRecordsFound);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
