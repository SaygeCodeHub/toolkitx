part of 'certificate_list_bloc.dart';

abstract class CertificateListState {}

class CertificateListInitial extends CertificateListState {}

class FetchingCertificateList extends CertificateListState {}

class FetchedCertificateList extends CertificateListState {
  final FetchCertificatesModel fetchCertificatesModel;

  FetchedCertificateList({required this.fetchCertificatesModel});
}

class CertificateListError extends CertificateListState {
  final String errorMsg;

  CertificateListError({required this.errorMsg});
}

class CertificateDetailsFetching extends CertificateListState {}

class CertificateDetailsFetched extends CertificateListState {
  final FetchCertificateDetailsModel fetchCertificateDetailsModel;

  CertificateDetailsFetched({
    required this.fetchCertificateDetailsModel,
  });
}

class CertificateDetailsError extends CertificateListState {
  final String errorMsg;

  CertificateDetailsError({required this.errorMsg});
}
