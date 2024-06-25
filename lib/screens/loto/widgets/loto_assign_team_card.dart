import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/fetch_loto_assign_team_model.dart';
import '../../../widgets/custom_card.dart';

class LotoAssignTeamCard extends StatelessWidget {
  const LotoAssignTeamCard({
    super.key,
    required this.lotoAssignTeamDatum,
    required this.isRemoveOperation,
  });

  final LotoAssignTeamDatum lotoAssignTeamDatum;
  final String isRemoveOperation;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
            title: Text(lotoAssignTeamDatum.name,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            subtitle: Text(lotoAssignTeamDatum.membersCount,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.grey)),
            trailing: InkWell(
                onTap: () {
                  isRemoveOperation != "1"
                      ? context.read<LotoDetailsBloc>().add(
                          SaveLotoAssignTeam(teamId: lotoAssignTeamDatum.id))
                      : context.read<LotoDetailsBloc>().add(
                          RemoveAssignTeam(teamId: lotoAssignTeamDatum.id));
                },
                child: const Card(
                    shape: CircleBorder(),
                    elevation: kElevation,
                    color: AppColor.paleGrey,
                    child: Padding(
                      padding: EdgeInsets.all(xxTiniestSpacing),
                      child: Icon(Icons.add),
                    )))));
  }
}
