import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/loto/assign_workforce_for_remove_model.dart';
import 'package:toolkit/data/models/loto/loto_details_model.dart';
import 'package:toolkit/repositories/loto/loto_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
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
    on<RemoveAssignWorkforce>(_removeAssignWorkforce);
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

  Future<FutureOr<void>> _removeAssignWorkforce(
      RemoveAssignWorkforce event, Emitter<LotoDetailsState> emit) async {
    emit(AssignWorkforceRemoving());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map workforceRemoveMap = {
        "hashcode": hashCode,
        "lotoid": lotoId,
        "peopleid": event.peopleId,
        "userid": userId
      };
      AssignWorkForceForRemoveModel assignWorkForceForRemoveModel =
          await _lotoRepository.assignWorkforceRemove(workforceRemoveMap);
      if (assignWorkForceForRemoveModel.status == 200) {
        emit(AssignWorkforceRemoved(
            assignWorkForceForRemoveModel: assignWorkForceForRemoveModel));
      }
    } catch (e) {
      emit(AssignWorkforceRemoveError(getError: e.toString()));
    }
  }
}
