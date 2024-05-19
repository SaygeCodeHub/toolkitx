import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../repositories/global/global_repository.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final GlobalRepository _globalRepository = getIt<GlobalRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  GlobalState get initialState => GlobalInitial();

  GlobalBloc() : super(GlobalInitial()) {
    on<UpdateCount>(_updateCount);
  }

  Future<FutureOr<void>> _updateCount(
      UpdateCount event, Emitter<GlobalState> emit) async {
    Map updateCountMap = {
      "userid": await _customerCache.getUserId(CacheKeys.userId),
      "type": event.type,
      "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
    };
    await _globalRepository.updateCount(updateCountMap);
  }
}
