import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/loto/loto_list_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/loto/loto_list_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/text_button.dart';
import 'loto_filter_screen.dart';

class LotoListScreen extends StatelessWidget {
  static const routeName = 'LotoListScreen';

  const LotoListScreen({super.key, this.isFromHome = false});
  static List lotoListData = [];
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoListBloc>()
        .add(FetchLotoList(pageNo: 1, isFromHome: isFromHome));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('LOTO')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<LotoListBloc, LotoListState>(
                  buildWhen: (previousState, currentState) {
                    if (currentState is FetchingLotoList &&
                        isFromHome == true) {
                      return true;
                    } else if (currentState is LotoListFetched) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    if (state is LotoListFetched) {
                      return Visibility(
                          visible: state.filtersMap.isNotEmpty,
                          child: CustomTextButton(
                              onPressed: () {
                                LotoListBody.pageNo = 1;
                                lotoListData.clear();
                                context
                                    .read<LotoListBloc>()
                                    .add(ClearLotoListFilter());
                                context.read<LotoListBloc>().add(FetchLotoList(
                                    pageNo: 1, isFromHome: isFromHome));
                              },
                              textValue: DatabaseUtil.getText('Clear')));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                CustomIconButtonRow(
                  isEnabled: true,
                  primaryOnPress: () {
                    Navigator.pushNamed(context, LotoFilterScreen.routeName);
                  },
                  secondaryVisible: false,
                  clearVisible: false,
                  secondaryOnPress: () {},
                  clearOnPress: () {},
                ),
              ],
            ),
            const LotoListBody(),
          ],
        ),
      ),
    );
  }
}
