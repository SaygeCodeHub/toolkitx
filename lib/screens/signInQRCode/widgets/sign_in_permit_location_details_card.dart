import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import 'package:toolkit/blocs/signInQRCode/signInLocationDetails/sign_in_location_details_event.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/progress_bar.dart';

import '../../../blocs/signInQRCode/SignInAssignToMe/sign_in_assign_to_me_bloc.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_tag.dart';

class SignInPermitLocationDetailsCard extends StatelessWidget {
  final List<Permit> permit;
  final String locationId;

  const SignInPermitLocationDetailsCard(
      {Key? key, required this.permit, required this.locationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: permit.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: Padding(
                    padding: const EdgeInsets.only(top: tinierSpacing),
                    child: ListTile(
                        onTap: () {},
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(permit[index].pcompany,
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black)),
                            StatusTag(tags: [
                              StatusTagModel(
                                  title: permit[index].status,
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
                                  Text(permit[index].permit),
                                  const SizedBox(height: tinierSpacing),
                                  Text(permit[index].location),
                                  const SizedBox(height: tinierSpacing),
                                  Text(permit[index].description),
                                  const SizedBox(height: tinierSpacing),
                                  Row(children: [
                                    Image.asset('assets/icons/calendar.png',
                                        height: kImageHeight,
                                        width: kImageWidth),
                                    const SizedBox(width: tiniestSpacing),
                                    Text(permit[index].schedule),
                                  ]),
                                  const SizedBox(height: tinierSpacing),
                                  BlocListener<SignInAssignToMeBloc,
                                      SignInAssignToMeState>(
                                    listener: (context, state) {
                                      if (state is PermitAssigning) {
                                        ProgressBar.show(context);
                                      } else if (state is PermitAssigned) {
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(
                                            context,
                                            StringConstants.kPermitAssigned,
                                            '');
                                        context
                                            .read<SignInLocationDetailsBloc>()
                                            .add(FetchSignInLocationDetails(
                                                locationId: locationId));
                                      } else if (state is PermitAssignError) {
                                        ProgressBar.dismiss(context);
                                        showCustomSnackBar(context,
                                            StringConstants.kPermitError, '');
                                      }
                                    },
                                    child: PrimaryButton(
                                        onPressed: () {
                                          Map assignToMePermitMap = {
                                            "permitid": permit[index].id,
                                          };
                                          context
                                              .read<SignInAssignToMeBloc>()
                                              .add(AssignToMePermit(
                                                  assignToMePermitsMap:
                                                      assignToMePermitMap));
                                        },
                                        textValue:
                                            StringConstants.kAssignedToMe),
                                  ),
                                  PrimaryButton(
                                      onPressed: () {},
                                      textValue: StringConstants.kAssignedToMe),
                                  const SizedBox(height: tiniestSpacing),
                                ])))));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
