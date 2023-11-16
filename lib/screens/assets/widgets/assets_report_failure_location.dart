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
import 'assets_report_failure_location_list.dart';

class AssetsReportFailureLocation extends StatelessWidget {
  const AssetsReportFailureLocation(
      {super.key,
        required this.assetsReportFailureMap,
        required this.reportFailureLocationList});

  final Map assetsReportFailureMap;
  final List reportFailureLocationList;

  @override
  Widget build(BuildContext context) {

    context.read<AssetsBloc>().add(SelectAssetsReportFailureLocation(selectLocationName: assetsReportFailureMap['location'] ?? ''));
    return BlocBuilder<AssetsBloc, AssetsState>(
        buildWhen: (previousState, currentState) =>
        currentState is AssetsReportFailureLocationSelected,
        builder: (context, state) {
          if (state is AssetsReportFailureLocationSelected) {
            return Column(children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, AssetsReportFailureLocationList.routeName,
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
                              assetsReportFailureMap['location'] =
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
