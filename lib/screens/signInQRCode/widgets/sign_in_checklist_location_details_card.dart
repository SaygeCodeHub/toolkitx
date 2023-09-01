import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/signInQRCode/SignInAssignToMe/sign_in_assign_to_me_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_event.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/progress_bar.dart';

class SignInCheckListLocationDetailsCard extends StatelessWidget {
  final List<Checklist> checkList;
  final String locationId;

  const SignInCheckListLocationDetailsCard(
      {Key? key, required this.checkList, required this.locationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: checkList.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: Padding(
                    padding: const EdgeInsets.only(top: tinierSpacing),
                    child: ListTile(
                        onTap: () {},
                        title: Text(checkList[index].name,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.black)),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: tinierSpacing),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(checkList[index].categoryname),
                                  const SizedBox(height: tinierSpacing),
                                  Text(checkList[index].subcategoryname),
                                  const SizedBox(height: tinierSpacing),
                                  BlocListener<SignInAssignToMeBloc,
                                      SignInAssignToMeState>(
                                    listener: (context, state) {
                                      if (state is ChecklistAssigning) {
                                        ProgressBar.show(context);
                                      } else if (state is ChecklistAssigned) {
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(
                                            context,
                                            StringConstants.kChecklistAssigned,
                                            '');
                                        context
                                            .read<SignInLocationDetailsBloc>()
                                            .add(FetchSignInLocationDetails(
                                                locationId: locationId));
                                      } else if (state
                                          is ChecklistAssignError) {
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(
                                            context,
                                            StringConstants.kChecklistError,
                                            '');
                                      }
                                    },
                                    child: PrimaryButton(
                                        onPressed: () {
                                          Map assignToMeChecklistMap = {
                                            "checklistid": checkList[index].id,
                                          };
                                          context
                                              .read<SignInAssignToMeBloc>()
                                              .add(AssignToMeChecklist(
                                                  assignToMeChecklistsMap:
                                                      assignToMeChecklistMap));
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
