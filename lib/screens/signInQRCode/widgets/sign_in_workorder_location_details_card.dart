import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/signInQRCode/SignInAssignToMe/sign_in_assign_to_me_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/status_tag.dart';

class SignInWorkOrderLocationDetailsCard extends StatelessWidget {
  final List<Workorder> workOrder;

  const SignInWorkOrderLocationDetailsCard({Key? key, required this.workOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: workOrder.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: Padding(
                    padding: const EdgeInsets.only(top: tinierSpacing),
                    child: ListTile(
                        onTap: () {},
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(workOrder[index].woname,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black)),
                            StatusTag(tags: [
                              StatusTagModel(
                                  title: workOrder[index].status,
                                  bgColor: AppColor.green),
                            ])
                          ],
                        ),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: tinierSpacing),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(workOrder[index].contractorname),
                                  const SizedBox(height: tinierSpacing),
                                  Text(workOrder[index].type),
                                  const SizedBox(height: tinierSpacing),
                                  Text(workOrder[index].subject),
                                  const SizedBox(height: tinierSpacing),
                                  Row(children: [
                                    Image.asset('assets/icons/calendar.png',
                                        height: kImageHeight,
                                        width: kImageWidth),
                                    const SizedBox(width: tiniestSpacing),
                                    Text(workOrder[index].schedule),
                                  ]),
                                  const SizedBox(height: tinierSpacing),
                                  BlocListener<SignInAssignToMeBloc, SignInAssignToMeState>(
                                    listener: (context, state) {
                                      if(state is WorkOrderAssigning){
                                        ProgressBar.show(context);
                                      } else if(state is WorkOrderAssigned){
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(context, 'Workorder Assigned', '');
                                        context.read<SignInLocationDetailsBloc>().add(FetchSignInLocationDetails(locationId: ''));
                                      } else if(state is WorkOrderAssignError){
                                        showCustomSnackBar(context, 'Workorder Error', '');
                                      }
                                    },
                                    child: PrimaryButton(
                                        onPressed: () {
                                          Map assignToMeWorkOrderMap = {
                                          "woid": workOrder[index].id,
                                        };
                                          context.read<SignInAssignToMeBloc>().add(AssignToMeWorkOrder(assignToMeWorkOrdersMap: assignToMeWorkOrderMap));
                                          },
                                        textValue: StringConstants.kAssignToMe),
                                  ),
                                  const SizedBox(height: tiniestSpacing),
                                ])))));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
