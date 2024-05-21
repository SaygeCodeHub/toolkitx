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
import 'package:toolkit/screens/permit/permit_sign_as_sap_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/generic_text_field.dart';
import 'package:toolkit/widgets/primary_button.dart';

class TransferPermitOfflineScreen extends StatelessWidget {
  static const routeName = 'TransferPermitOfflineScreen';
  final PermitDetailsModel permitDetailsModel;
  final Map saveTransferMap = {};

  TransferPermitOfflineScreen({super.key, required this.permitDetailsModel});

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(
        FetchDataForChangePermitCP(permitId: permitDetailsModel.data.tab1.id));
    return Scaffold(
      appBar:
          const GenericAppBar(title: StringConstants.kTransferComponentPerson),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: BlocBuilder<PermitBloc, PermitStates>(
          buildWhen: (previousState, currentState) =>
              currentState is DataForChangePermitCPFetched ||
              currentState is DataForChangePermitCPNotFetched,
          builder: (context, state) {
            if (state is DataForChangePermitCPFetched) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: context.read<PermitBloc>().showTransferWarning,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.errorRed)),
                        child: const Padding(
                          padding: EdgeInsets.all(xxTinierSpacing),
                          child: Text(
                            StringConstants.kPermitTransferWarning,
                            style: TextStyle(color: AppColor.errorRed),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: xxTinierSpacing),
                    Text(StringConstants.kPermitNo,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(
                        value: permitDetailsModel.data.tab1.permit,
                        readOnly: true,
                        onTextFieldChanged: (textField) {}),
                    const SizedBox(height: xxTinierSpacing),
                    Text(StringConstants.kControlPerson,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    TextFieldWidget(onTextFieldChanged: (textField) {
                      saveTransferMap['controlPerson'] = textField;
                    }),
                    const SizedBox(height: xxTinierSpacing),
                  ],
                ),
              );
            } else if (state is DataForChangePermitCPNotFetched) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child: PrimaryButton(
            onPressed: () {
              if (saveTransferMap['controlPerson'] == null ||
                  saveTransferMap['controlPerson'] == '') {
                showCustomSnackBar(
                    context, StringConstants.kPleaseFillControlPerson, '');
              } else {
                Navigator.pushNamed(context, PermitSignAsSapScreen.routeName,
                    arguments: PermitCpSapModel(sapCpMap: {
                      'permitid': permitDetailsModel.data.tab1.id,
                      'controlPerson': saveTransferMap['controlPerson'],
                    }, previousScreen: TransferPermitOfflineScreen.routeName));
              }
            },
            textValue: StringConstants.kSave),
      ),
    );
  }
}
