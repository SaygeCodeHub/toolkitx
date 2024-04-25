import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/certificates/widgets/certificate_list_card.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/certificates/cerficatesList/certificate_list_bloc.dart';
import '../../configs/app_spacing.dart';

class CertificatesListScreen extends StatelessWidget {
  static const routeName = 'CertificatesListScreen';

  const CertificatesListScreen({super.key});

  static int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    context
        .read<CertificateListBloc>()
        .add(FetchCertificateList(pageNo: pageNo));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('Certificates')),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: SafeArea(
                child: BlocBuilder<CertificateListBloc, CertificateListState>(
                    buildWhen: (previousState, currentState) =>
                        currentState is FetchingCertificateList ||
                        currentState is FetchedCertificateList ||
                        currentState is CertificateListError,
                    builder: (context, state) {
                      if (state is FetchingCertificateList) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FetchedCertificateList) {
                          return Column(children: [
                            Expanded(
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.fetchCertificatesModel.data.length,
                                    itemBuilder: (context, index) {
                                        return CertificateListCard(
                                          data: state.fetchCertificatesModel.data[index],
                                        );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                          height: tinierSpacing);
                                    })),
                            const SizedBox(height: xxxSmallestSpacing),
                          ]);
                      }
                      return const SizedBox.shrink();
                    }))));
  }
}
