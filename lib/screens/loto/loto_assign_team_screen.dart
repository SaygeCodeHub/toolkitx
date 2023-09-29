import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_card.dart';

class LotoAssignTeamScreen extends StatelessWidget {
  static const routeName = 'LotoAssignTeamScreen';

  const LotoAssignTeamScreen({super.key});

  static String name = '';
  static int isRemove = 0;
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoDetailsBloc>()
        .add(FetchLotoAssignTeam(pageNo: pageNo, isRemove: isRemove, name: ''));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText("assign_Team")),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: leftRightMargin),
        child: BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
          buildWhen: (previousState, currentState) =>
              currentState is LotoAssignTeamFetching ||
              currentState is LotoAssignTeamFetched ||
              currentState is LotoAssignTeamError,
          builder: (context, state) {
            if (state is LotoAssignTeamFetching) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LotoAssignTeamFetched) {
              return Column(children: [
                Row(
                  children: [
                    SizedBox(
                        width: kSearchFieldWidth,
                        child: TextFieldWidget(
                            onTextFieldChanged: (textField) {
                              name = textField;
                            },
                            hintText: StringConstants.kTeam)),
                    const SizedBox(width: tinySpacing),
                    SizedBox(
                        width: kApplyButtonWidth,
                        child: PrimaryButton(
                            onPressed: () {
                              context.read<LotoDetailsBloc>().add(
                                  FetchLotoAssignTeam(
                                      pageNo: pageNo,
                                      isRemove: isRemove,
                                      name: ''));
                            },
                            textValue: StringConstants.kApply)),
                  ],
                ),
                const SizedBox(height: tinySpacing),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.fetchLotoAssignTeamModel.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              title: Text(
                                  state.fetchLotoAssignTeamModel.data[index]
                                      .name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black)),
                              subtitle: Text(
                                  state.fetchLotoAssignTeamModel.data[index]
                                      .membersCount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.grey)),
                              trailing: InkWell(
                                  onTap: () {},
                                  child: const Card(
                                      shape: CircleBorder(),
                                      elevation: kElevation,
                                      color: AppColor.paleGrey,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(xxTiniestSpacing),
                                        child: Icon(Icons.add),
                                      )))));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: tiniestSpacing);
                    },
                  ),
                )
              ]);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
