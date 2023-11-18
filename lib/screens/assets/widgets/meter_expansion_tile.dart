import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/assets/assets_master_model.dart';

class MeterExpansionTile extends StatelessWidget {
  const MeterExpansionTile({
    super.key,
    required this.data,
    required this.meterReadingMap,
  });

  final List<List<Datum>> data;
  final Map meterReadingMap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsBloc, AssetsState>(
      buildWhen: (previousState, currentState) =>
          currentState is AssetsMeterSelected,
      builder: (context, state) {
        if (state is AssetsMeterSelected) {
          return Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColor.transparent),
              child: ExpansionTile(
                  key: GlobalKey(),
                  collapsedBackgroundColor: AppColor.white,
                  backgroundColor: AppColor.white,
                  title: Text(state.meterName),
                  children: [
                    MediaQuery(
                        data: MediaQuery.of(context)
                            .removePadding(removeTop: true),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data[3].length,
                            itemBuilder: (context, listIndex) {
                              return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: xxTinierSpacing),
                                  title: Text(data[3][listIndex].meter),
                                  onTap: () {
                                    meterReadingMap["meterid"] =
                                        data[3][listIndex].id;
                                    // state.yearList.clear();
                                    context.read<AssetsBloc>().add(
                                        SelectAssetsMeter(
                                            id: meterReadingMap["meterid"],
                                            meterName:
                                                data[3][listIndex].meter));
                                  });
                            }))
                  ]));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
