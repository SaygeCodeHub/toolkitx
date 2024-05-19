import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/permit/widgets/transfer_and_cp_tiles.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/primary_button.dart';
import '../../blocs/permit/permit_bloc.dart';
import '../../blocs/permit/permit_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';

class PermitTransferComponentScreen extends StatelessWidget {
  static const routeName = 'PermitTransferComponentScreen';
  final String permitId;

  const PermitTransferComponentScreen({Key? key, required this.permitId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<PermitBloc>()
        .add(FetchDataForChangePermitCP(permitId: permitId));
    return Scaffold(
      appBar:
          const GenericAppBar(title: StringConstants.kTransferComponentPerson),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocConsumer<PermitBloc, PermitStates>(
            buildWhen: (previousState, currentState) =>
                currentState is DataForChangePermitCPFetching ||
                currentState is DataForChangePermitCPFetched ||
                currentState is DataForChangePermitCPNotFetched,
            listener: (context, state) {
              // if (state is MarkAsPreparedSaving) {
              //   ProgressBar.show(context);
              // } else if (state is MarkAsPreparedSaved) {
              //   ProgressBar.dismiss(context);
              //   Navigator.pop(context);
              //   Navigator.pushNamed(context, PermitDetailsScreen.routeName,
              //       arguments: permitId);
              // } else if (state is MarkAsPreparedNotSaved) {
              //   ProgressBar.dismiss(context);
              //   showCustomSnackBar(context, state.errorMessage, '');
              // }
            },
            builder: (context, state) {
              if (state is DataForChangePermitCPFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataForChangePermitCPFetched) {
                var data = state.fetchDataForChangePermitCpModel.data;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kPermitNo,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        TextFieldWidget(
                            value: data![0][0].permitName!,
                            readOnly: true,
                            onTextFieldChanged: (textField) {}),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kTransferTo,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        TransferAndCPTiles(data: data),
                        const SizedBox(height: xxTinierSpacing),
                        Text(StringConstants.kControlPerson,
                            style: Theme.of(context).textTheme.xSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        TextFieldWidget(onTextFieldChanged: (textField) {}),
                        const SizedBox(height: xxTinierSpacing),
                      ]),
                );
              } else if (state is DataForChangePermitCPNotFetched) {
                return Center(child: Text(state.errorMessage));
              }
              return const SizedBox.shrink();
            },
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(xxTinierSpacing),
        child:
            PrimaryButton(onPressed: () {}, textValue: StringConstants.kSave),
      ),
    );
  }
}
