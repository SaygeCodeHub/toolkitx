import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/permit_list_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/progress_bar.dart';

class SurrenderPermitScreen extends StatelessWidget {
  static const routeName = 'SurrenderPermitScreen';
  final String permitId;

  const SurrenderPermitScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(FetchPermitBasicDetails(permitId: permitId));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSurrenderPermit),
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
                    Navigator.pushNamed(context, PermitListScreen.routeName,
                        arguments: false);
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
            child: Expanded(
                child: PrimaryButton(
                    onPressed: () {
                      context
                          .read<PermitBloc>()
                          .add(SurrenderPermit(permitId: permitId));
                    },
                    textValue: StringConstants.kAcceptPermit))));
  }
}