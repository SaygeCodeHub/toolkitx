import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/loto/loto_list/loto_list_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_app_bar.dart';

class LotoLocationFilterList extends StatelessWidget {
  static const String routeName = "LotoLocationFilterList";

  final String selectLocationName;

  const LotoLocationFilterList({Key? key, required this.selectLocationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            context.read<LotoListBloc>().masterData[0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(context
                                  .read<LotoListBloc>()
                                  .masterData[0][index]
                                  .name),
                              value: context
                                  .read<LotoListBloc>()
                                  .masterData[0][index]
                                  .id
                                  .toString(),
                              groupValue: selectLocationName,
                              onChanged: (value) {
                                context
                                    .read<LotoListBloc>()
                                    .add(SelectLotoLocationFilter(
                                      selectLocationName: context
                                          .read<LotoListBloc>()
                                          .masterData[0][index]
                                          .name,
                                      selectLocationId: context
                                          .read<LotoListBloc>()
                                          .masterData[0][index]
                                          .id
                                          .toString(),
                                    ));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
