import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/loto/widgets/loto_assign_workforce_body.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button.dart';

class LotoAssignWorkforceScreen extends StatelessWidget {
  static const routeName = 'LotoAssignWorkforceScreen';
  static String workforceName = '';
  static String isRemove = "0";
  static int pageNo = 1;
  static bool isWorkforceSearched = false;
  static TextEditingController workforceNameController =
      TextEditingController();
  const LotoAssignWorkforceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pageNo = 1;
    context.read<LotoDetailsBloc>().add(FetchLotoAssignWorkforce(
        pageNo: pageNo, isRemove: isRemove, workforceName: ''));
    context.read<LotoDetailsBloc>().lotoWorkforceReachedMax = false;
    context.read<LotoDetailsBloc>().assignWorkforceDatum = [];
    context.read<LotoDetailsBloc>().add(
        SearchLotoAssignWorkForce(isWorkforceSearched: isWorkforceSearched));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText("assign_workforce")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: leftRightMargin),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: xxxSmallestSpacing),
              child: TextFormField(
                  controller: workforceNameController,
                  onChanged: (value) {
                    context.read<LotoDetailsBloc>().lotoWorkforceName = value;
                  },
                  decoration: InputDecoration(
                      suffix: const SizedBox(),
                      suffixIcon:
                          BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
                        buildWhen: (previousState, currentState) =>
                            currentState is LotoAssignWorkforceSearched,
                        builder: (context, state) {
                          if (state is LotoAssignWorkforceSearched) {
                            return CustomIconButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (workforceNameController.text != '' ||
                                    workforceNameController.text.trim() != '') {
                                  isWorkforceSearched = !isWorkforceSearched;
                                  pageNo = 1;
                                  context
                                      .read<LotoDetailsBloc>()
                                      .assignWorkforceDatum = [];
                                  context
                                      .read<LotoDetailsBloc>()
                                      .lotoWorkforceReachedMax = false;
                                  context.read<LotoDetailsBloc>().add(
                                      SearchLotoAssignWorkForce(
                                          isWorkforceSearched:
                                              isWorkforceSearched));
                                }
                              },
                              icon: (state.isWorkforceSearched == false)
                                  ? Icons.search
                                  : Icons.clear,
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.grey),
                      hintText: StringConstants.kSearch,
                      contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.lightGrey)),
                      filled: true,
                      fillColor: AppColor.white)),
            ),
            const SizedBox(height: tinySpacing),
            const LotoAssignWorkforceBody(),
          ],
        ),
      ),
    );
  }
}
