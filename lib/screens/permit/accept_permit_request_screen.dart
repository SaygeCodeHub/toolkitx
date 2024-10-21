import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/permit/permit_details_model.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/permit/permit_sing_as_cp_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/utils/global.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import 'package:toolkit/widgets/view_offline_permit_screen.dart';
import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/permit/permit_sap_cp_model.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';

class AcceptPermitRequestScreen extends StatelessWidget {
  static const routeName = 'AcceptPermitRequestScreen';
  final PermitDetailsModel permitDetailsModel;

  const AcceptPermitRequestScreen(
      {super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(
        FetchPermitBasicDetails(permitId: permitDetailsModel.data.tab1.id));
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kAcceptPermitRequest),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocConsumer<PermitBloc, PermitStates>(
                listener: (context, state) {
                  if (state is PermitRequestAccepting) {
                    ProgressBar.show(context);
                  } else if (state is PermitRequestAccepted) {
                    ProgressBar.dismiss(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, PermitDetailsScreen.routeName,
                        arguments: permitDetailsModel.data.tab1.id);
                  } else if (state is PermitRequestNotAccepted) {
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
                              onTextFieldChanged: (textField) {})
                        ]);
                  } else if (state is PermitBasicDetailsNotFetched) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox.shrink();
                })),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(xxTinierSpacing),
            child: Row(children: [
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        if (isNetworkEstablished) {
                          context.read<PermitBloc>().add(
                              GeneratePDF(permitDetailsModel.data.tab1.id));
                        } else {
                          Navigator.pushNamed(
                              context, OfflineHtmlViewerScreen.routeName,
                              arguments: permitDetailsModel.data.tab1.id);
                        }
                      },
                      textValue: DatabaseUtil.getText('generatepdf'))),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        if (isNetworkEstablished) {
                          context.read<PermitBloc>().add(AcceptPermitRequest(
                              permitId: permitDetailsModel.data.tab1.id,
                              acceptPermitMap: {}));
                        } else {
                          Navigator.pushNamed(
                              context, PermitSignAsCpScreen.routeName,
                              arguments: PermitCpSapModel(sapCpMap: {
                                "permitid": permitDetailsModel.data.tab1.id,
                                "action_key": "accept_permit_request"
                              }, previousScreen: routeName));
                        }
                      },
                      textValue: StringConstants.kAcceptPermit))
            ])));
  }
}
