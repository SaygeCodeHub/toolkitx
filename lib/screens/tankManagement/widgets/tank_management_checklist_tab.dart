import 'package:flutter/material.dart';
import 'package:toolkit/blocs/tankManagement/tank_management_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/tankManagement/widgets/submit_tank_checklist_screen.dart';
import 'package:toolkit/screens/tankManagement/widgets/tank_view_response_screen.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class TankManagementChecklistTab extends StatelessWidget {
  const TankManagementChecklistTab({super.key, required this.nominationId});

  final String nominationId;

  @override
  Widget build(BuildContext context) {
    context
        .read<TankManagementBloc>()
        .add(FetchNominationChecklist(nominationId: nominationId, tabIndex: 1));
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
              Map tankChecklistMap = {
                "scheduleId": data[index].scheduleid,
                'title': data[index].checklistname
              };
              return CustomCard(
                child: ListTile(
                    title: Text(data[index].checklistname,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black)),
                    subtitle: data[index].cansubmitresponse == '1'
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context,
                                      SubmitTankChecklistScreen.routeName,
                                      arguments: tankChecklistMap)
                                  .then((value) => context
                                      .read<TankManagementBloc>()
                                      .add(FetchNominationChecklist(
                                          nominationId: nominationId,
                                          tabIndex: 1)));
                            },
                            child: Text('submit response',
                                style: Theme.of(context)
                                    .textTheme
                                    .xSmall
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.deepBlue)),
                          )
                        : data[index].canviewresponse == '1'
                            ? InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                          TankViewResponseScreen.routeName,
                                          arguments: tankChecklistMap)
                                      .then((value) => context
                                          .read<TankManagementBloc>()
                                          .add(FetchNominationChecklist(
                                              nominationId: nominationId,
                                              tabIndex: 1)));
                                },
                                child: Text(
                                  StringConstants.kViewResponse,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.deepBlue),
                                ),
                              )
                            : const SizedBox.shrink()),
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
