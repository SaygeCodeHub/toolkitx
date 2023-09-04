import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_bloc.dart';
import '../../../blocs/signInQRCode/signInLocationDetails/sign_in_location_details_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/error_section.dart';
import 'sign_in_checklist_location_details_card.dart';
import 'sign_in_loto_location_details_card.dart';
import 'sign_in_permit_location_details_card.dart';
import 'sign_in_workorder_location_details_card.dart';

class SignInLocationDetailsCards extends StatelessWidget {
  final String locationId;

  const SignInLocationDetailsCards({Key? key, required this.locationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInLocationDetailsBloc, SignInLocationDetailsStates>(
        builder: (context, state) {
      if (state is SignInLocationDetailsFetched) {
        if (state.fetchLocationDetailsSignInModel.data.permit!.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.workorder!.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.loto!.isNotEmpty ||
            state.fetchLocationDetailsSignInModel.data.checklist!.isNotEmpty) {
          if (context.read<SignInLocationDetailsBloc>().indexSelected == 0) {
            return (state.fetchLocationDetailsSignInModel.data.permit!.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoPermit,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : SignInPermitLocationDetailsCard(
                    permit: state.fetchLocationDetailsSignInModel.data.permit!);
          } else if (context.read<SignInLocationDetailsBloc>().indexSelected ==
              1) {
            return (state
                    .fetchLocationDetailsSignInModel.data.workorder!.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoWorkOrder,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : SignInWorkOrderLocationDetailsCard(
                    workOrder:
                        state.fetchLocationDetailsSignInModel.data.workorder!);
          } else if (context.read<SignInLocationDetailsBloc>().indexSelected ==
              2) {
            return (state.fetchLocationDetailsSignInModel.data.loto!.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoLoto,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : SignInLoToLocationDetailsCard(
                    loTo: state.fetchLocationDetailsSignInModel.data.loto!);
          } else {
            return (state
                    .fetchLocationDetailsSignInModel.data.checklist!.isEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: Text(StringConstants.kNoChecklist,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.mediumBlack))),
                  )
                : SignInCheckListLocationDetailsCard(
                    checkList:
                        state.fetchLocationDetailsSignInModel.data.checklist!);
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
