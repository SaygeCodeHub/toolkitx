import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/certificates/get_certificate_details_model.dart';
import 'package:toolkit/repositories/certificates/certificates_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/certificates/certificate_list_model.dart';
import '../../../di/app_module.dart';

part 'certificate_list_event.dart';

part 'certificate_list_state.dart';

class CertificateListBloc
    extends Bloc<CertificateListEvent, CertificateListState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final FetchCertificateDetailsModel fetchCertificateDetailsModel =
      FetchCertificateDetailsModel();

  CertificateListState get initialState => CertificateListInitial();

  CertificateListBloc() : super(CertificateListInitial()) {
    on<FetchCertificateList>(_fetchCertificateList);
    on<FetchCertificateDetails>(_fetchCertificateDetails);
  }

  Future<FutureOr<void>> _fetchCertificateList(
      FetchCertificateList event, Emitter<CertificateListState> emit) async {
    emit(FetchingCertificateList());
    // try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId) ?? '';
      FetchCertificatesModel fetchCertificatesModel =
          await _certificateRepository.fetchCertificatesRepository(
              event.pageNo, hashCode!, userId!);
      emit(FetchedCertificateList(
          fetchCertificatesModel: fetchCertificatesModel, clientId: clientId));
    // } catch (e) {
    //   emit(CertificateListError(errorMsg: e.toString()));
    // }
  }

  Future<FutureOr<void>> _fetchCertificateDetails(
      FetchCertificateDetails event, Emitter<CertificateListState> emit) async {
    emit(CertificateDetailsFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchCertificateDetailsModel fetchCertificateDetailsModel =
          await _certificateRepository.fetchCertificateDetails(
              hashCode!, userId!, event.certificateId);
      if (fetchCertificateDetailsModel.status == 200) {
        emit(CertificateDetailsFetched(
            fetchCertificateDetailsModel: fetchCertificateDetailsModel));
      }
    } catch (e) {
      emit(CertificateDetailsError(errorMsg: e.toString()));
    }
  }
}
