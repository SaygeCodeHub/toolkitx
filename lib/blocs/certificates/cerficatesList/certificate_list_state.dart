part of 'certificate_list_bloc.dart';

abstract class CertificateListState {}

class CertificateListInitial extends CertificateListState {}

class FetchingCertificateList extends CertificateListState {}

class FetchedCertificateList extends CertificateListState {
  final FetchCertificatesModel fetchCertificatesModel;
  final List<CertificateListDatum> data;
  final bool hasReachedMax;

  FetchedCertificateList(
      {required this.fetchCertificatesModel,
      required this.data,
      required this.hasReachedMax});
}

class CertificateListError extends CertificateListState {
  final String errorMsg;

  CertificateListError({required this.errorMsg});
}
