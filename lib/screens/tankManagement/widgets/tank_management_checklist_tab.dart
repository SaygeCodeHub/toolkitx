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

class TankManagementChecklistTab extends StatefulWidget {
  const TankManagementChecklistTab({super.key, required this.nominationId});

  final String nominationId;

  @override
  _TankManagementChecklistTabState createState() => _TankManagementChecklistTabState();
}

class _TankManagementChecklistTabState extends State<TankManagementChecklistTab> {
  @override
  void initState() {
    super.initState();
    _fetchChecklist();
  }

  void _fetchChecklist() {
    context.read<TankManagementBloc>().add(FetchNominationChecklist(nominationId: widget.nominationId, tabIndex: 0));
  }

  void _navigateAndRefresh(String routeName, Map arguments) async {
    await Navigator.pushNamed(context, routeName, arguments: arguments);
    if (mounted) {
      _fetchChecklist();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "executionId": data[index].executionid,
                'title': data[index].checklistname,
                'nominationId': widget.nominationId
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
                        _navigateAndRefresh(SubmitTankChecklistScreen.routeName, tankChecklistMap);
                      },
                      child: Text(StringConstants.kSubmitResponse,
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
                        _navigateAndRefresh(TankViewResponseScreen.routeName, tankChecklistMap);
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