import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/loto/loto_list/loto_list_bloc.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import 'loto_filter_screen.dart';
import 'loto_list_body.dart';

class LotoListScreen extends StatelessWidget {
  static const routeName = 'LotoListScreen';
  static int pageNo = 1;

  const LotoListScreen({super.key, this.isFromHome = false});

  static List lotoListData = [];
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context
        .read<LotoListBloc>()
        .add(FetchLotoList(pageNo: pageNo, isFromHome: isFromHome));
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('LOTO'),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<LotoListBloc, LotoListState>(
                    buildWhen: (previous, current) {
                  return current is LotoListFetched ||
                      current is FetchingLotoList;
                }, builder: (context, state) {
                  if (state is LotoListFetched || state is FetchingLotoList) {
                    return CustomIconButtonRow(
                        secondaryVisible: false,
                        clearVisible:
                            context.read<LotoListBloc>().filters.isNotEmpty,
                        isEnabled: true,
                        primaryOnPress: () {
                          Navigator.pushNamed(
                              context, LotoFilterScreen.routeName);
                        },
                        secondaryOnPress: () {},
                        clearOnPress: () {
                          pageNo = 1;
                          context.read<LotoListBloc>().data.clear();
                          context
                              .read<LotoListBloc>()
                              .add(ClearLotoListFilter());
                          context.read<LotoListBloc>().add(FetchLotoList(
                              pageNo: pageNo, isFromHome: isFromHome));
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                })
              ]),
              const SizedBox(height: xxTinierSpacing),
              const LotoList()
            ])));
  }
}
