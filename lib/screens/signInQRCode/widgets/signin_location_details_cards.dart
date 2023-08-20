import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_event.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/status_tag_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_tag.dart';

class SignInLocationDetailsCards extends StatelessWidget {
  const SignInLocationDetailsCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SignInLocationDetailsBloc>().add(FetchSignInLocationDetails());
    return BlocBuilder<SignInLocationDetailsBloc, SignInLocationDetailsStates>(
        builder: (context, state) {
      if (state is SignInLocationDetailsFetched) {
        if (state.fetchLocationDetailsSignInModel.data.permit.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.workorder.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.loto.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.checklist.isNotEmpty) {
          if (context.read<SignInLocationDetailsBloc>().indexSelected == 0) {
            return (state.fetchLocationDetailsSignInModel.data.permit.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoPermit,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : const CustomCard(
                    child: ListTile(),
                  );
          } else if (context.read<SignInLocationDetailsBloc>().indexSelected ==
              1) {
            return (state
                    .fetchLocationDetailsSignInModel.data.workorder.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoWorkOrder,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.fetchLocationDetailsSignInModel.data
                            .workorder.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: tinierSpacing),
                                  child: ListTile(
                                      onTap: () {},
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              state
                                                  .fetchLocationDetailsSignInModel
                                                  .data
                                                  .workorder[index]
                                                  .woname,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .small
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor.black)),
                                          StatusTag(tags: [
                                            StatusTagModel(
                                                title: state
                                                    .fetchLocationDetailsSignInModel
                                                    .data
                                                    .workorder[index]
                                                    .status,
                                                bgColor: AppColor.green),
                                          ])
                                        ],
                                      ),
                                      subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: tinierSpacing),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(state
                                                    .fetchLocationDetailsSignInModel
                                                    .data
                                                    .workorder[index]
                                                    .contractorname),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Text(state
                                                    .fetchLocationDetailsSignInModel
                                                    .data
                                                    .workorder[index]
                                                    .type),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                Row(children: [
                                                  Image.asset(
                                                      'assets/icons/calendar.png',
                                                      height: kImageHeight,
                                                      width: kImageWidth),
                                                  const SizedBox(
                                                      width: tiniestSpacing),
                                                  Text(state
                                                      .fetchLocationDetailsSignInModel
                                                      .data
                                                      .workorder[index]
                                                      .schedule),
                                                ]),
                                                const SizedBox(
                                                    height: tinierSpacing),
                                                PrimaryButton(
                                                    onPressed: () {},
                                                    textValue: 'Assign to me'),
                                                const SizedBox(
                                                    height: tiniestSpacing),
                                              ])))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinierSpacing);
                        }),
                  );
          } else if (context.read<SignInLocationDetailsBloc>().indexSelected ==
              2) {
            return (state.fetchLocationDetailsSignInModel.data.loto.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoLoto,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : const CustomCard(
                    child: ListTile(),
                  );
          } else {
            return (state
                    .fetchLocationDetailsSignInModel.data.checklist.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoChecklist,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : const CustomCard(
                    child: ListTile(),
                  );
          }
        } else {
          return const SizedBox.shrink();
        }
      } else if (state is SignInLocationNotFetched) {
        return GenericReloadButton(
            onPressed: () {}, textValue: StringConstants.kReload);
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
