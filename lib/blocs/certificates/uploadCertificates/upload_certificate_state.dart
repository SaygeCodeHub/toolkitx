part of 'upload_certificate_bloc.dart';

abstract class UploadCertificateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadCertificateInitial extends UploadCertificateState {}

class UploadCertificateSaving extends UploadCertificateState {}

class UploadCertificateSaved extends UploadCertificateState {
  final UploadCertificateModel uploadCertificateModel;
  UploadCertificateSaved({required this.uploadCertificateModel});
}

class UploadCertificateNotSaved extends UploadCertificateState {
  final String certificateNotSaved;
  UploadCertificateNotSaved({required this.certificateNotSaved});
}

class CertificateApprovalPending extends UploadCertificateState {
  final String certificateApprovalPending;
  CertificateApprovalPending({required this.certificateApprovalPending});
}
