import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforceList/workforce_list_events.dart';
import 'package:toolkit/blocs/checklist/workforce/workforceList/workforce_list_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/workforce/workforce_list_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/workforce/workforce_repository.dart';

class WorkForceListBloc extends Bloc<FetchWorkForceList, WorkForceListStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  WorkForceListBloc() : super(FetchListInitial()) {
    on<FetchWorkForceList>(_fetchList);
  }

  Map checkListMap = {};

  FutureOr<void> _fetchList(
      FetchWorkForceList event, Emitter<WorkForceListStates> emit) async {
    emit(FetchingList());
    // try {
    String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
    String userId = (await _customerCache.getUserId(CacheKeys.userId))!;
    WorkforceGetCheckListModel workforceGetCheckListModel =
        await _workForceRepository.fetchWorkforceList(userId, hashCode);
    for (int i = 0; i < workforceGetCheckListModel.data!.length; i++) {
      checkListMap['isDraft'] = workforceGetCheckListModel.data![i].isdraft;
      checkListMap['isRejected'] =
          workforceGetCheckListModel.data![i].isrejected;
    }
    emit(ListFetched(workforceGetCheckListModel: workforceGetCheckListModel));
    // } catch (e) {
    //   emit(ListNotFetched());
    // }
  }
}
