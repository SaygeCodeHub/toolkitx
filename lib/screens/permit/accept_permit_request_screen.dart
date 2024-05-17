import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';

class AcceptPermitRequestScreen extends StatelessWidget {
  static const routeName = 'AcceptPermitRequestScreen';
  final String permitId;

  const AcceptPermitRequestScreen({Key? key, required this.permitId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(FetchPermitBasicDetails(permitId: permitId));
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
                        arguments: permitId);
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
                              value: state
                                  .fetchPermitBasicDetailsModel.data!.permit!,
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
                              value: state
                                  .fetchPermitBasicDetailsModel.data!.status!,
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
            child: Row(children: [
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        context.read<PermitBloc>().add(GeneratePDF(permitId));
                      },
                      textValue: DatabaseUtil.getText('generatepdf'))),
              const SizedBox(width: xxTinierSpacing),
              Expanded(
                  child: PrimaryButton(
                      onPressed: () {
                        context
                            .read<PermitBloc>()
                            .add(AcceptPermitRequest(permitId: permitId));
                      },
                      textValue: StringConstants.kAcceptPermit))
            ])));
  }
}
