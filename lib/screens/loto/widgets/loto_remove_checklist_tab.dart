import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../loto_view_response_screen.dart';

class LotoRemoveChecklistTab extends StatelessWidget {
  const LotoRemoveChecklistTab({
    super.key,
    required this.data,
  });

  final LotoData data;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoDetailsBloc>()
        .add(FetchLotoAssignedChecklists(isRemove: '1'));
    return Column(
      children: [
        Visibility(
          visible: true,
          child: BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
            buildWhen: (previousState, currentState) =>
                currentState is LotoAssignedChecklistFetching ||
                currentState is LotoAssignedChecklistFetched ||
                currentState is LotoAssignedChecklistNotFetched,
            builder: (context, state) {
              if (state is LotoAssignedChecklistFetching) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is LotoAssignedChecklistFetched) {
                return ListView.separated(
                  itemCount: state.fetchLotoAssignedChecklistModel.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: ListTile(
                          title: Text(
                              state.fetchLotoAssignedChecklistModel.data![index]
                                  .checklistname!,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.black)),
                          subtitle: InkWell(
                            onTap: () {
                              state.fetchLotoAssignedChecklistModel.data![index]
                                          .responseid !=
                                      null
                                  ? Navigator.pushNamed(
                                      context, LotoViewResponseScreen.routeName,
                                      arguments: state
                                          .fetchLotoAssignedChecklistModel
                                          .data![index]
                                          .checklistid)
                                  : null;
                            },
                            child: Visibility(
                              visible: state.fetchLotoAssignedChecklistModel
                                      .data![index].responseid !=
                                  null,
                              replacement: const Text(
                                StringConstants.kNoResponse,
                                style: TextStyle(color: AppColor.grey),
                              ),
                              child: Text(StringConstants.kViewResponse,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.deepBlue)),
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
