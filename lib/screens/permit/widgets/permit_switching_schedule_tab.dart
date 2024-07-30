import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/permit_details_model.dart';
import 'package:toolkit/screens/permit/permit_switching_schedule_table_screen.dart';
import 'package:toolkit/utils/constants/api_constants.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PermitSwitchingScheduleTab extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;
  final String permitId;

  const PermitSwitchingScheduleTab(
      {super.key, required this.permitDetailsModel, required this.permitId});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab7.length,
        itemBuilder: (context, index) {
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context,
                            PermitSwitchingScheduleTableScreen.routeName,
                            arguments: permitDetailsModel.data.tab7[index].id);
                      },
                      title: Text(permitDetailsModel.data.tab7[index].number,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      trailing: BlocListener<PermitBloc, PermitStates>(
                        listener: (context, state) {
                          if (state is MarkSwitchingScheduleCompleting) {
                            ProgressBar.show(context);
                          } else if (state is MarkSwitchingScheduleCompleted) {
                            ProgressBar.dismiss(context);
                            context
                                .read<PermitBloc>()
                                .add(GetPermitDetails(permitId: permitId));
                          } else if (state
                              is MarkSwitchingScheduleNotCompleted) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.errorMessage, '');
                          }

                          if (state is SwitchingSchedulePdfGenerating) {
                            ProgressBar.show(context);
                          } else if (state is SwitchingSchedulePdfGenerated) {
                            ProgressBar.dismiss(context);
                            launchUrlString(
                              '${ApiConstants.baseDocUrl}${state.decryptedFile}.pdf',
                              mode: LaunchMode.externalApplication,
                            );
                          } else if (state
                              is SwitchingSchedulePdfNotGenerated) {
                            ProgressBar.dismiss(context);
                            showCustomSnackBar(context, state.errorMessage, '');
                          }
                        },
                        child: Visibility(
                          visible: isNetworkEstablished,
                          child: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    context.read<PermitBloc>().add(
                                        MarkSwitchingScheduleComplete(
                                            switchingScheduleId:
                                                permitDetailsModel
                                                    .data.tab7[index].id));
                                  },
                                  value: StringConstants.kMarkAsComplete,
                                  child: Text(StringConstants.kMarkAsComplete,
                                      style: Theme.of(context).textTheme.xxSmall),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    context.read<PermitBloc>().add(
                                        GenerateSwitchingSchedulePdf(
                                            switchingScheduleId:
                                                permitDetailsModel
                                                    .data.tab7[index].id));
                                  },
                                  value: StringConstants.kGeneratePdf,
                                  child: Text(StringConstants.kGeneratePdf,
                                      style: Theme.of(context).textTheme.xxSmall),
                                ),
                              ];
                            },
                          ),
                        ),
                      ),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(permitDetailsModel.data.tab7[index].title),
                                const SizedBox(height: xxTinierSpacing),
                                Text(permitDetailsModel.data.tab7[index].status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .xxSmall
                                        .copyWith(color: AppColor.deepBlue)),
                                const SizedBox(height: xxTiniestSpacing)
                              ])))));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
