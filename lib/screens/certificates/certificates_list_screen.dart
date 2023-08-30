import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/text_button.dart';
import '../../blocs/certificates/cerficatesList/certificate_list_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';

class CertificatesListScreen extends StatelessWidget {
  static const routeName = 'CertificatesListScreen';
  const CertificatesListScreen({super.key});
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    context.read<CertificateListBloc>().data.clear();
    context.read<CertificateListBloc>().hasReachedMax = false;
    context
        .read<CertificateListBloc>()
        .add(FetchCertificateList(pageNo: pageNo));
    return Scaffold(
      backgroundColor: AppColor.lightestGrey,
      appBar: GenericAppBar(title: DatabaseUtil.getText('Certificates')),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SafeArea(
          child: BlocConsumer<CertificateListBloc, CertificateListState>(
            buildWhen: (previousState, currentState) =>
                ((currentState is FetchedCertificateList ||
                    currentState is FetchingCertificateList && pageNo == 1)),
            listener: (context, state) {
              if (state is FetchedCertificateList) {
                if (state.fetchCertificateListModel.status == 204) {
                  showCustomSnackBar(
                      context, StringConstants.kAllDataLoaded, '');
                  context.read<CertificateListBloc>().hasReachedMax = true;
                }
              }
            },
            builder: (context, state) {
              if (state is FetchingCertificateList) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchedCertificateList) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.fetchCertificateListModel.data.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: tinierSpacing),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {},
                                title: Text(
                                    state.fetchCertificateListModel.data[index]
                                        .name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.black)),
                                subtitle: const Text('Not Available'),
                              ),
                              const Divider(
                                color: AppColor.lightestGrey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: CustomTextButton(
                                          onPressed: () {},
                                          textValue: 'Upload')),
                                  Expanded(
                                      child: CustomTextButton(
                                          onPressed: () {},
                                          textValue: 'Download')),
                                  Expanded(
                                      child: CustomTextButton(
                                          onPressed: () {},
                                          textValue: 'Start Course')),
                                  Expanded(
                                      child: CustomTextButton(
                                          onPressed: () {},
                                          textValue: 'Feedback')),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: tinierSpacing);
                    });
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
