import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../loto_details_screen.dart';
import '../loto_list_screen.dart';

class LotoListTile extends StatelessWidget {
  final int index;

  const LotoListTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: tinierSpacing),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, LotoDetailsScreen.routeName,
                        arguments: context.read<LotoListBloc>().data[index].id)
                    .then((_) => {
                          LotoListScreen.pageNo = 1,
                          context.read<LotoListBloc>().data.clear(),
                          context.read<LotoListBloc>().add(FetchLotoList(
                              pageNo: LotoListScreen.pageNo, isFromHome: false))
                        });
              },
              title: Text(context.read<LotoListBloc>().data[index].name,
                  style: Theme.of(context).textTheme.small.copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    context.read<LotoListBloc>().data[index].date,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    context.read<LotoListBloc>().data[index].location,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                  Text(
                    context.read<LotoListBloc>().data[index].purpose,
                    style: Theme.of(context).textTheme.xSmall.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: xxxTinierSpacing,
                  ),
                ],
              ),
              trailing: Text(
                context.read<LotoListBloc>().data[index].status,
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
