import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class LotoViewChecklistTab extends StatelessWidget {
  const LotoViewChecklistTab({
    super.key,
    required this.data,
  });

  final LotoData data;

  @override
  Widget build(BuildContext context) {
    context
        .read<LotoDetailsBloc>()
        .add(FetchLotoAssignedChecklists(isRemove: '0'));
    return Column(
      children: [
        Visibility(
          visible: data.isremove == '1' ? false : true,
          child: BlocBuilder<LotoDetailsBloc, LotoDetailsState>(
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
                            onTap: () {},
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
