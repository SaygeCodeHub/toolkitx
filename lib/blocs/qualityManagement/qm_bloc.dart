import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_events.dart';
import 'package:toolkit/blocs/qualityManagement/qm_states.dart';
import 'package:toolkit/repositories/qualityManagement/qm_repository.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/cache/cache_keys.dart';
import '../../data/models/qualityManagement/fetch_qm_list_model.dart';

class QualityManagementBloc
    extends Bloc<QualityManagementEvent, QualityManagementStates> {
  final QualityManagementRepository _qualityManagementRepository =
      getIt<QualityManagementRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map filters = {};
  String roleId = '';

  QualityManagementStates get initialState => QualityManagementInitial();

  QualityManagementBloc() : super(QualityManagementInitial()) {
    on<FetchQualityManagementList>(_fetchList);
  }

  FutureOr<void> _fetchList(FetchQualityManagementList event,
      Emitter<QualityManagementStates> emit) async {
    emit(FetchingQualityManagementList());
    try {
      String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      FetchQualityManagementListModel fetchQualityManagementListModel =
          await _qualityManagementRepository.fetchQualityManagementList(
              event.pageNo, userId, hashCode, '', '');
      emit(QualityManagementListFetched(
        fetchQualityManagementListModel: fetchQualityManagementListModel,
      ));
    } catch (e) {
      e.toString();
    }
  }
}
