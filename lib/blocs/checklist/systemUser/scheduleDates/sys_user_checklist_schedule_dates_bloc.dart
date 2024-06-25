import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_checklist_schedule_dates_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import 'sys_user_checklist_schedule_dates_event.dart';

class CheckListScheduleDatesBloc extends Bloc<FetchCheckListScheduleDatesEvent,
    CheckListScheduleDatesStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String checklistId = '';

  CheckListScheduleDatesStates get initialState =>
      CheckListScheduleDatesInitial();

  CheckListScheduleDatesBloc() : super(CheckListScheduleDatesInitial()) {
    on<FetchCheckListScheduleDatesEvent>(_fetchScheduleDatesList);
  }

  FutureOr<void> _fetchScheduleDatesList(FetchCheckListScheduleDatesEvent event,
      Emitter<CheckListScheduleDatesStates> emit) async {
    emit(FetchingCheckListScheduleDates());
    try {
      checklistId = event.checklistId;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      ChecklistScheduledByDatesModel getChecklistDetailsModel =
          await _sysUserCheckListRepository.fetchCheckListScheduleDates(
              event.checklistId, hashCode);
      if (getChecklistDetailsModel.status == 200) {
        emit(CheckListDatesScheduled(
            checklistScheduledByDatesModel: getChecklistDetailsModel,
            allChecklistDataMap: const {}));
      } else {
        emit(CheckListDatesNotScheduled(
            noDatesScheduled: StringConstants.kNoDatesScheduled));
      }
    } catch (e) {
      emit(CheckListDatesNotScheduled(
          noDatesScheduled: StringConstants.kSomethingWentWrong));
    }
  }
}
