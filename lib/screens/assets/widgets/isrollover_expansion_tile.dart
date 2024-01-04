import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/expansion_tile_border.dart';

class IsRolloverExpansionTile extends StatelessWidget {
  const IsRolloverExpansionTile({
    super.key,
    required this.rolloverMap,
    required this.meterReadingMap,
  });

  final Map rolloverMap;
  final Map meterReadingMap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
            currentState is AssetsRollOverSelected,
        builder: (context, state) {
          if (state is AssetsRollOverSelected) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: AppColor.transparent),
                child: ExpansionTile(
                    shape: ExpansionTileBorder().buildOutlineInputBorder(),
                    collapsedBackgroundColor: AppColor.white,
                    backgroundColor: AppColor.white,
                    collapsedShape:
                        ExpansionTileBorder().buildOutlineInputBorder(),
                    key: GlobalKey(),
                    title: Text(state.isRollover),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: xxTinierSpacing),
                                    title: Text(rolloverMap.values
                                        .elementAt(listIndex)),
                                    onTap: () {
                                      meterReadingMap['isrollover'] =
                                          rolloverMap.keys.elementAt(listIndex);
                                      context.read<AssetsBloc>().add(
                                          SelectAssetsRollOver(
                                              id: rolloverMap.keys
                                                  .elementAt(listIndex),
                                              isRollover: rolloverMap.values
                                                  .elementAt(listIndex)));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
