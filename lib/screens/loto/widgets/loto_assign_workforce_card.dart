import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/fetch_loto_assign_workforce_model.dart';
import '../../../widgets/custom_card.dart';

class LotoAssignWorkforceCard extends StatelessWidget {
  const LotoAssignWorkforceCard({super.key, required this.workForceDatum});

  final LotoWorkforceDatum workForceDatum;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
            title: Text(workForceDatum.name,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.black)),
            subtitle: Text(workForceDatum.jobTitle,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.grey)),
            trailing: InkWell(
                onTap: () {
                  if (context.read<LotoDetailsBloc>().isWorkforceRemove ==
                      "1") {
                    context.read<LotoDetailsBloc>().add(
                        RemoveAssignWorkforce(peopleId: workForceDatum.id));
                  } else {
                    context.read<LotoDetailsBloc>().add(
                        SaveLotoAssignWorkForce(peopleId: workForceDatum.id));
                  }
                },
                child: const Card(
                    shape: CircleBorder(),
                    elevation: kElevation,
                    color: AppColor.paleGrey,
                    child: Padding(
                        padding: EdgeInsets.all(xxTiniestSpacing),
                        child: Icon(Icons.add))))));
  }
}
