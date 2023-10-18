import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/assets/assets_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/generic_text_field.dart';
import 'assets_location_filter_list.dart';

class AssetsLocationFilter extends StatelessWidget {
  const AssetsLocationFilter(
      {super.key,
      required this.assetsFilterMap,
      required this.assetsLocationList});

  final Map assetsFilterMap;
  final List assetsLocationList;

  @override
  Widget build(BuildContext context) {
    context.read<AssetsBloc>().add(
        SelectAssetsLocation(selectLocationName: assetsFilterMap['loc'] ?? ''));
    return BlocBuilder<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
            currentState is AssetsLocationSelected,
        builder: (context, state) {
          if (state is AssetsLocationSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, AssetsLocationFilterList.routeName,
                        arguments: state.selectLocationName);
                  },
                  title: Text(DatabaseUtil.getText('Location'),
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w600)),
                  subtitle: (context.read<AssetsBloc>().selectLocationName ==
                          '')
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: xxxTinierSpacing),
                          child: Text(
                              context.read<AssetsBloc>().selectLocationName,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(color: AppColor.black)),
                        ),
                  trailing:
                      const Icon(Icons.navigate_next_rounded, size: kIconSize)),
              Visibility(
                  visible:
                      state.selectLocationName == DatabaseUtil.getText('Other'),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kOther,
                            style: Theme.of(context)
                                .textTheme
                                .xSmall
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: xxxTinierSpacing),
                        TextFieldWidget(
                            hintText: DatabaseUtil.getText('OtherLocation'),
                            onTextFieldChanged: (String textField) {
                              assetsFilterMap['loc'] =
                                  (state.selectLocationName == 'Other'
                                      ? textField
                                      : '');
                            })
                      ]))
            ]);
          } else {
            return const SizedBox();
          }
        });
  }
}
