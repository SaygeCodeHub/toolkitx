part of 'certificate_list_bloc.dart';

abstract class CertificateListEvent {}

class FetchCertificateList extends CertificateListEvent {
  final int pageNo;

  FetchCertificateList({required this.pageNo});
}
