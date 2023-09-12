import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/certificates/upload_certificate_model.dart';
import '../../../repositories/certificates/certificates_repository.dart';

part 'upload_certificate_event.dart';
part 'upload_certificate_state.dart';

class UploadCertificateBloc
    extends Bloc<UploadCertificateEvent, UploadCertificateState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  UploadCertificateState get initialState => UploadCertificateInitial();
  UploadCertificateBloc() : super(UploadCertificateInitial()) {
    on<UploadCertificates>(_uploadCertificate);
  }

  FutureOr<void> _uploadCertificate(
      UploadCertificates event, Emitter<UploadCertificateState> emit) async {
    emit(UploadCertificateSaving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      Map uploadCertificatesMap = {
        "hashcode": hashCode,
        "certificateid": event.uploadCertificateMap['certificateid'],
        "workforceid": userid,
        "startdate": event.uploadCertificateMap['startdate'],
        "enddate": event.uploadCertificateMap['enddate'],
        "name": event.uploadCertificateMap['name']
      };
      UploadCertificateModel uploadCertificateModel =
          await _certificateRepository
              .uploadCertificates(uploadCertificatesMap);
      if (uploadCertificateModel.status == 200) {
        emit(UploadCertificateSaved(
            uploadCertificateModel: uploadCertificateModel));
      } else if (uploadCertificateModel.status == 406) {
        emit(CertificateApprovalPending(
            certificateApprovalPending: uploadCertificateModel.message));
      }
    } catch (e) {
      emit(UploadCertificateNotSaved(certificateNotSaved: e.toString()));
    }
  }
}
