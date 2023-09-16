import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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

  CertificateListState get initialState => CertificateListInitial();
  final List<CertificateListDatum> data = [];
  bool hasReachedMax = false;
  CertificateListBloc() : super(CertificateListInitial()) {
    on<FetchCertificateList>(_fetchCertificateList);
  }

  Future<FutureOr<void>> _fetchCertificateList(
      FetchCertificateList event, Emitter<CertificateListState> emit) async {
    emit(FetchingCertificateList());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchCertificatesModel fetchCertificatesModel =
          await _certificateRepository.fetchCertificatesRepository(
              event.pageNo, hashCode!, userId!);
      data.addAll(fetchCertificatesModel.data);
      emit(FetchedCertificateList(
          fetchCertificatesModel: fetchCertificatesModel,
          data: data,
          hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(CertificateListError(errorMsg: e.toString()));
    }
  }
}
