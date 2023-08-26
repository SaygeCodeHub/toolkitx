import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/text_button.dart';
import '../../blocs/certificates/cerficatesList/certificate_list_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';

class CertificatesListScreen extends StatelessWidget {
  static const routeName = 'CertificatesListScreen';
  const CertificatesListScreen({super.key});
  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
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
          top: xxTinierSpacing,
        ),
        child: SafeArea(
          child: BlocConsumer<CertificateListBloc, CertificateListState>(
            buildWhen: (previousState, currentState) =>
                ((currentState is FetchedCertificateList &&
                        context.read<CertificateListBloc>().hasReachedMax ==
                            false) ||
                    (currentState is FetchingCertificateList &&
                        CertificatesListScreen.pageNo == 1)),
            listener: (context, state) {
              if (state is FetchedCertificateList) {
                if (state.fetchCertificatesModel.status == 204) {
                  context.read<CertificateListBloc>().hasReachedMax = true;
                  showCustomSnackBar(
                      context, StringConstants.kAllDataLoaded, '');
                }
              }
            },
            builder: (context, state) {
              if (state is FetchingCertificateList) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchedCertificateList) {
                if (state.fetchCertificatesModel.data.isNotEmpty) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.hasReachedMax
                                ? state.data.length
                                : state.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.data.length) {
                                return CustomCard(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: tinierSpacing),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {},
                                          title: Text(state.data[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .small
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.black)),
                                          subtitle: const Text('Not Available'),
                                          trailing: Image.asset(
                                              'assets/icons/certificate.png',
                                              height: kImageHeight,
                                              width: kImageWidth),
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
                              } else if (!state.hasReachedMax) {
                                CertificatesListScreen.pageNo++;
                                context.read<CertificateListBloc>().add(
                                    FetchCertificateList(
                                        pageNo: CertificatesListScreen.pageNo));
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        kCircularProgressIndicatorPadding),
                                    child: SizedBox(
                                        width: kCircularProgressIndicatorWidth,
                                        child: CircularProgressIndicator()),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: tinierSpacing);
                            }),
                      ),
                      const SizedBox(height: xxxSmallestSpacing),
                    ],
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
