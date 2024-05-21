import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/permit_details_model.dart';
import 'package:toolkit/data/models/permit/permit_sap_cp_model.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/screens/permit/permit_sing_as_cp_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class SurrenderPermitScreen extends StatelessWidget {
  static const routeName = 'SurrenderPermitScreen';
  final PermitDetailsModel permitDetailsModel;

  const SurrenderPermitScreen({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(
        FetchPermitBasicDetails(permitId: permitDetailsModel.data.tab1.id));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSurrenderPermit),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocConsumer<PermitBloc, PermitStates>(
                listener: (context, state) {
                  if (state is SurrenderingPermit) {
                    ProgressBar.show(context);
                  } else if (state is PermitSurrendered) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, PermitListScreen.routeName,
                        arguments: true);
                  } else if (state is PermitNotSurrender) {
                    ProgressBar.dismiss(context);
                    showCustomSnackBar(context, state.errorMessage, '');
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is PermitBasicDetailsFetching ||
                    currentState is PermitBasicDetailsFetched ||
                    currentState is PermitBasicDetailsNotFetched,
                builder: (context, state) {
                  if (state is PermitBasicDetailsFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PermitBasicDetailsFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringConstants.kPermitNo,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black)),
                          const SizedBox(height: tiniestSpacing),
                          TextFieldWidget(
                              value: permitDetailsModel.data.tab1.permit,
                              readOnly: true,
                              onTextFieldChanged: (textField) {}),
                          const SizedBox(height: xxTinierSpacing),
                          Text(StringConstants.kStatus,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black)),
                          const SizedBox(height: tiniestSpacing),
                          TextFieldWidget(
                              value: permitDetailsModel.data.tab1.status,
                              readOnly: true,
                              onTextFieldChanged: (textField) {}),
                        ]);
                  } else if (state is PermitBasicDetailsNotFetched) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox.shrink();
                })),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: PrimaryButton(
                onPressed: () {
                  if (isNetworkEstablished) {
                    context.read<PermitBloc>().add(SurrenderPermit(
                        permitId: permitDetailsModel.data.tab1.id,
                        surrenderPermitMap: {}));
                  } else {
                    Navigator.pushNamed(context, PermitSignAsCpScreen.routeName,
                        arguments: PermitCpSapModel(sapCpMap: {
                          "permitid": permitDetailsModel.data.tab1.id,
                          "action_key": "surrender_permit"
                        }, previousScreen: routeName));
                  }
                },
                textValue: StringConstants.kSurrenderPermit)));
  }
}
