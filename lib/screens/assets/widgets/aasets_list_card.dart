import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/assets/assets_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/assets/assets_list_model.dart';
import 'package:toolkit/screens/assets/assets_list_screen.dart';

import '../../../configs/app_color.dart';
import '../../../widgets/custom_card.dart';
import '../assets_details_screen.dart';

class AssetsListCard extends StatelessWidget {
  const AssetsListCard({super.key, required this.data});
  final AssetsListDatum data;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(children: [
      ListTile(
          onTap: () {
            context.read<AssetsBloc>().assetId = data.id;
            Navigator.pushNamed(context, AssetsDetailsScreen.routeName)
                .then((_) => {
                      AssetsListScreen.pageNo = 1,
                      context.read<AssetsBloc>().assetsDatum.clear(),
                      context.read<AssetsBloc>().add(FetchAssetsList(
                          pageNo: AssetsListScreen.pageNo, isFromHome: false))
                    });
          },
          title: Text(data.name,
              style: Theme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.black)),
          subtitle: Text(data.tag,
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(fontWeight: FontWeight.w500, color: AppColor.grey)),
          trailing: Text(data.status,
              style: Theme.of(context).textTheme.xSmall.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.deepBlue)))
    ]));
  }
}
