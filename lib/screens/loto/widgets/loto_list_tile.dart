import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_details/loto_details_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/loto/loto_list_model.dart';
import '../../../widgets/custom_card.dart';
import '../loto_details_screen.dart';

class LotoListTile extends StatelessWidget {
  final LotoListDatum lotoListDatum;

  const LotoListTile({
    super.key,
    required this.lotoListDatum,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                context.read<LotoDetailsBloc>().lotoId = lotoListDatum.id;
                Navigator.pushNamed(context, LotoDetailsScreen.routeName);
              },
              title: Text(lotoListDatum.name,
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    lotoListDatum.date,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    lotoListDatum.location,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    lotoListDatum.purpose,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                ],
              ),
              trailing: Text(
                lotoListDatum.status,
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.deepBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
