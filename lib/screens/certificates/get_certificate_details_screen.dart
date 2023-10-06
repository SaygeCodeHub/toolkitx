import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/certificates/cerficatesList/certificate_list_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class GetCertificateDetailsScreen extends StatelessWidget {
  static const routeName = 'ApprovalPendingScreen';

  const GetCertificateDetailsScreen({super.key, required this.certificateMap});

  final Map certificateMap;

  @override
  Widget build(BuildContext context) {
    context
        .read<CertificateListBloc>()
        .add(FetchCertificateDetails(certificateId: certificateMap["id"]));
    return Scaffold(
        appBar: const GenericAppBar(),
        body: Padding(
            padding: const EdgeInsets.only(
                left: xxxSmallestSpacing,
                right: xxxSmallestSpacing,
                top: xxxSmallestSpacing),
            child: BlocBuilder<CertificateListBloc, CertificateListState>(
                buildWhen: (previousState, currentState) =>
                    currentState is CertificateDetailsFetching ||
                    currentState is CertificateDetailsFetched ||
                    currentState is CertificateDetailsError,
                builder: (context, state) {
                  if (state is CertificateDetailsFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CertificateDetailsFetched) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(certificateMap["title"],
                              style: Theme.of(context).textTheme.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black)),
                          const SizedBox(height: tinierSpacing),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: AppColor.lightGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(tiniestSpacing),
                              child: Text(StringConstants.kApprovalPending,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xxSmall
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey)),
                            ),
                          ),
                          const SizedBox(height: smallerSpacing),
                          Text(StringConstants.kLastUploaded,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mediumBlack)),
                          const SizedBox(height: tinierSpacing),
                          Row(
                            children: [
                              Image.asset('assets/icons/calendar.png',
                                  height: kImageHeight, width: kImageWidth),
                              const SizedBox(width: tinierSpacing),
                              Text(
                                  state.fetchCertificateDetailsModel.data!
                                      .newEndDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .xxSmall
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.mediumBlack)),
                            ],
                          ),
                          const SizedBox(height: smallerSpacing),
                          Text(StringConstants.kViewCertificate,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mediumBlack)),
                          const SizedBox(height: tinierSpacing),
                          Image.asset('assets/icons/certificate.png',
                              height: xImageHeight, width: xImageHeight),
                          const SizedBox(height: smallerSpacing),
                          Text(StringConstants.kUploadNewCertificate,
                              style: Theme.of(context)
                                  .textTheme
                                  .xSmall
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mediumBlack)),
                          const SizedBox(height: tinierSpacing),
                          Text(StringConstants.kPendingSelectedCertificate,
                              style: Theme.of(context)
                                  .textTheme
                                  .xxSmall
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.grey))
                        ]);
                  } else {
                    return const SizedBox.shrink();
                  }
                })));
  }
}
