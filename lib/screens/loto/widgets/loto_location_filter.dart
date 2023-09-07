import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_list_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/loto_location_list.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';

class LotoLocationFilter extends StatelessWidget {
  final Map lotoLocationMap;
  final List locationList;

  const LotoLocationFilter(
      {Key? key, required this.lotoLocationMap, required this.locationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LotoListBloc>().add(SelectLotoLocationFilter(
        selectLocationName: (lotoLocationMap['location_name'] == null)
            ? ''
            : lotoLocationMap['location_name']));
    return BlocBuilder<LotoListBloc, LotoListState>(
        buildWhen: (previousState, currentState) =>
            currentState is LotoLocationFilterSelected,
        builder: (context, state) {
          if (state is LotoLocationFilterSelected) {
            lotoLocationMap['location_name'] = state.selectLocationName;
            return Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LotoLocationFilterList(
                                    selectLocationName:
                                        state.selectLocationName,
                                    data: locationList,
                                  )));
                    },
                    title: Text(DatabaseUtil.getText('Location'),
                        style: Theme.of(context)
                            .textTheme
                            .xSmall
                            .copyWith(fontWeight: FontWeight.w600)),
                    subtitle: (state.selectLocationName == '')
                        ? null
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: xxxTinierSpacing),
                            child: Text(state.selectLocationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(color: AppColor.black)),
                          ),
                    trailing: const Icon(Icons.navigate_next_rounded,
                        size: kIconSize)),
                Visibility(
                    visible: state.selectLocationName ==
                        DatabaseUtil.getText('Other'),
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
                                lotoLocationMap['location'] =
                                    (state.selectLocationName == 'Other'
                                        ? textField
                                        : '');
                              })
                        ])),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
