import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/repositories/loto/loto_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/loto/fetch_loto_assign_workforce_model.dart';
import '../../../di/app_module.dart';
import '../../../utils/database_utils.dart';

part 'loto_details_event.dart';
part 'loto_details_state.dart';

class LotoDetailsBloc extends Bloc<LotoDetailsEvent, LotoDetailsState> {
  final LotoRepository _lotoRepository = getIt<LotoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LotoDetailsState get initialState => LotoDetailsInitial();
  List<LotoData> lotoData = [];
  String lotoId = '';
  int lotoTabIndex = 0;
  LotoDetailsBloc() : super(LotoDetailsInitial()) {
    on<FetchLotoDetails>(_fetchLotoDetails);
    on<FetchLotoAssignWorkforce>(_fetchLotoAssignWorkforce);
  }

  Future<FutureOr<void>> _fetchLotoDetails(
      FetchLotoDetails event, Emitter<LotoDetailsState> emit) async {
    emit(LotoDetailsFetching());
    try {
      lotoTabIndex = event.lotTabIndex;
      List popUpMenuItems = [
        DatabaseUtil.getText('Start'),
        DatabaseUtil.getText('assign_workforce'),
        DatabaseUtil.getText('assign_team'),
        DatabaseUtil.getText('AddComment'),
        DatabaseUtil.getText('UploadPhotos'),
        DatabaseUtil.getText('Cancel'),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoDetailsModel fetchLotoDetailsModel =
          await _lotoRepository.fetchLotoDetailsRepo(hashCode!, event.lotoId);
      if (fetchLotoDetailsModel.status == 200) {
        emit(LotoDetailsFetched(
            fetchLotoDetailsModel: fetchLotoDetailsModel,
            lotoPopUpMenu: popUpMenuItems,
            showPopUpMenu: true));
      }
    } catch (e) {
      emit(LotoDetailsNotFetched(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchLotoAssignWorkforce(
      FetchLotoAssignWorkforce event, Emitter<LotoDetailsState> emit) async {
    emit(LotoAssignWorkforceFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLotoAssignWorkforceModel fetchLotoAssignWorkforceModel =
          await _lotoRepository.fetchLotoAssignWorkforceModel(hashCode!,
              event.lotoId, event.pageNo, event.name, event.isRemove);
      if (fetchLotoAssignWorkforceModel.status == 200) {
        emit(LotoAssignWorkforceFetched(
            fetchLotoAssignWorkforceModel: fetchLotoAssignWorkforceModel));
      }
    } catch (e) {
      emit(LotoAssignWorkforceError(getError: e.toString()));
    }
  }
}
