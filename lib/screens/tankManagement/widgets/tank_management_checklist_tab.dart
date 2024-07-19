import 'package:flutter/material.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/loto/loto_view_response_screen.dart';
import '../../../blocs/loto/loto_details/loto_details_bloc.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class TankManagementChecklistTab extends StatelessWidget {
  const TankManagementChecklistTab({super.key, required this.nominationId});

  final String nominationId;

  @override
  Widget build(BuildContext context) {
    context
        .read<TankManagementBloc>()
        .add(FetchNominationChecklist(nominationId: nominationId));
    return BlocBuilder<TankManagementBloc, TankManagementState>(
      builder: (context, state) {
        if (state is NominationChecklistFetching) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NominationChecklistFetched) {
          var data = state.fetchNominationChecklistModel.data;
          return ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CustomCard(
                child: ListTile(
                    title: Text(data[index].checklistname,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black)),
                    subtitle: InkWell(
                      onTap: () {

                      },
                      child: Visibility(
                        visible: data[index].cansubmitresponse == '1',
                        replacement: const Text(
                          StringConstants.kViewResponse,
                          style: TextStyle(color: AppColor.grey),
                        ),
                        child: Text('submit response',
                            style: Theme.of(context).textTheme.xSmall.copyWith(
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
        } else if (state is NominationChecklistNotFetched) {
          return const Center(child: Text(StringConstants.kNoRecordsFound));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
