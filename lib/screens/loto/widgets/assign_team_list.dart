
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_no_records_text.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';
import '../loto_assign_team_screen.dart';

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
          LotoAssignTeamScreen.data.clear();
          LotoAssignTeamScreen.hasReachedMax = false;
          context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
              pageNo: LotoAssignTeamScreen.pageNo,
              isRemove: LotoAssignTeamScreen.isRemove,
              name: LotoAssignTeamScreen.name));
        } else if (state is LotoAssignTeamNotSaved) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong, '');
        } else if (state is LotoAssignTeamFetched &&
            LotoAssignTeamScreen.hasReachedMax == true) {
          showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
        }
        if (state is AssignTeamRemoved) {
          LotoAssignTeamScreen.pageNo = 1;
          LotoAssignTeamScreen.data = [];
          context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
              pageNo: LotoAssignTeamScreen.pageNo,
              isRemove: LotoAssignTeamScreen.isRemove,
              name: LotoAssignTeamScreen.name));
          showCustomSnackBar(context, StringConstants.kTeamRemoved, '');
        } else if (state is LotoAssignTeamNotSaved) {
          ProgressBar.show(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong, '');
        }
        if (state is LotoAssignTeamFetched) {
          if (state.fetchLotoAssignTeamModel.status == 204 &&
              LotoAssignTeamScreen.data.isNotEmpty) {
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
      buildWhen: (previousState, currentState) =>
          (currentState is LotoAssignTeamFetching &&
              LotoAssignTeamScreen.pageNo == 1) ||
          (currentState is LotoAssignTeamFetched) ||
          currentState is LotoAssignTeamError,
      builder: (context, state) {
        if (state is LotoAssignTeamFetching) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is LotoAssignTeamFetched) {
          if (LotoAssignTeamScreen.data.isNotEmpty) {
            return Expanded(
              child: ListView.separated(
                itemCount: (LotoAssignTeamScreen.hasReachedMax)
                    ? LotoAssignTeamScreen.data.length
                    : LotoAssignTeamScreen.data.length + 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < LotoAssignTeamScreen.data.length) {
                    return CustomCard(
                        child: ListTile(
                            title: Text(LotoAssignTeamScreen.data[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black)),
                            subtitle: Text(
                                LotoAssignTeamScreen.data[index].membersCount,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.grey)),
                            trailing: InkWell(
                                onTap: () {
                                  context.read<LotoDetailsBloc>().isWorkforceRemove !=
                                      "1" ? context.read<LotoDetailsBloc>().add(
                                      SaveLotoAssignTeam(
                                          teamId: LotoAssignTeamScreen
                                              .data[index].id)) :
                                  context.read<LotoDetailsBloc>().add(
                                      RemoveAssignTeam(
                                          teamId: LotoAssignTeamScreen
                                              .data[index].id));
                                },
                                child: const Card(
                                    shape: CircleBorder(),
                                    elevation: kElevation,
                                    color: AppColor.paleGrey,
                                    child: Padding(
                                      padding: EdgeInsets.all(xxTiniestSpacing),
                                      child: Icon(Icons.add),
                                    )))));
                  } else {
                    LotoAssignTeamScreen.pageNo++;
                    context.read<LotoDetailsBloc>().add(FetchLotoAssignTeam(
                        pageNo: LotoAssignTeamScreen.pageNo,
                        isRemove: LotoAssignTeamScreen.isRemove,
                        name: LotoAssignTeamScreen.name));
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: tinierSpacing),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: tiniestSpacing);
                },
              ),
            );
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
