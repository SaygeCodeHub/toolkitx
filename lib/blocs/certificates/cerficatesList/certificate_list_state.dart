part of 'certificate_list_bloc.dart';

abstract class CertificateListState {}

class CertificateListInitial extends CertificateListState {}

class FetchingCertificateList extends CertificateListState {}

class FetchedCertificateList extends CertificateListState {
  final FetchCertificateListModel fetchCertificateListModel;
  final List<CertificateListDatum> data;
  final bool hasReachedMax;

  FetchedCertificateList(
      {required this.fetchCertificateListModel,
      required this.data,
      required this.hasReachedMax});
}

class CertificateListError extends CertificateListState {
  final String errorMsg;

  CertificateListError({required this.errorMsg});
}
