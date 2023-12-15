import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../assets_manage_downtime_screen.dart';
import 'assets_downtime_popup_menu.dart';

class AssetsManageDowntimeBody extends StatelessWidget {
  const AssetsManageDowntimeBody({
    super.key,
    required this.assetDowntimeDatum,
    required this.assetsPopUpMenu,
  });

  final List assetDowntimeDatum;
  final List assetsPopUpMenu;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: (context.read<AssetsBloc>().hasDowntimeReachedMax)
          ? assetDowntimeDatum.length
          : assetDowntimeDatum.length + 1,
      itemBuilder: (context, index) {
        if (index < assetDowntimeDatum.length) {
          var hours = assetDowntimeDatum[index].totalmins ~/ 60;
          var remainingMin = assetDowntimeDatum[index].totalmins % 60;
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: xxxTinierSpacing, bottom: xxxTinierSpacing),
                  child: ListTile(
                    title: Row(children: [
                      Expanded(
                        child: Text(
                            "${assetDowntimeDatum[index].startdatetime} - ${assetDowntimeDatum[index].enddatetime}",
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                      ),
                      SizedBox(
                          width: smallerSpacing,
                          child: AssetsDowntimePopUpMenu(
                              popUpMenuItems: assetsPopUpMenu,
                              downtimeId: assetDowntimeDatum[index].id))
                    ]),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${hours}hr : ${remainingMin}m",
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.grey)),
                          const SizedBox(height: tiniestSpacing),
                          Text(assetDowntimeDatum[index].note,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.grey)),
                        ]),
                  )));
        } else if (!context.read<AssetsBloc>().hasDowntimeReachedMax) {
          AssetsManageDownTimeScreen.pageNo++;
          context.read<AssetsBloc>().add(FetchAssetsGetDownTime(
              assetId: context.read<AssetsBloc>().assetId,
              pageNo: AssetsManageDownTimeScreen.pageNo));
          return const Center(child: CircularProgressIndicator());
        } else{
          return const SizedBox.shrink();
        }
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: tinierSpacing);
      },
    );
  }
}
