part of 'upload_certificate_bloc.dart';

abstract class UploadCertificateEvent {}

class UploadCertificates extends UploadCertificateEvent {
  final Map uploadCertificateMap;

  UploadCertificates(this.uploadCertificateMap);
}
