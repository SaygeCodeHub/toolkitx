import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/checklist_schedule_dates_response_states.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_schedule_by_dates_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_workforce_list_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/database_utils.dart';

class CheckListScheduleDatesResponseBloc extends Bloc<
    CheckListScheduleDatesResponseEvent, CheckListScheduleDatesResponseStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  List responsesIdsList = [];
  String responseId = '';
  String scheduleId = '';
  String responseCount = '';
  GetChecklistDetailsData? getChecklistDetailsData;

  CheckListScheduleDatesResponseStates get initialState =>
      CheckListScheduleDatesResponseInitial();

  CheckListScheduleDatesResponseBloc()
      : super(CheckListScheduleDatesResponseInitial()) {
    on<CheckCheckListScheduleDatesResponse>(_checkResponse);
    on<CheckListWorkForceListFetch>(_workforceListFetch);
    on<CheckListCheckBoxCheck>(_checkBoxCheck);
    on<FetchCheckListPopUpMenu>(_fetchPopUpMenuItems);
  }

  _checkResponse(CheckCheckListScheduleDatesResponse event,
      Emitter<CheckListScheduleDatesResponseStates> emit) {
    scheduleId = event.scheduleId;
    getChecklistDetailsData = event.getChecklistDetailsData;
    if (event.getChecklistDetailsData.responsecount != 0) {
      add(CheckListWorkForceListFetch(
          responseIds: const [],
          role: event.role,
          scheduleId: event.scheduleId));
    } else {
      emit(CheckListNoResponseFound(
          noResponseMessage: 'No response found!',
          scheduleId: event.scheduleId));
    }
  }

  FutureOr<void> _workforceListFetch(CheckListWorkForceListFetch event,
      Emitter<CheckListScheduleDatesResponseStates> emit) async {
    emit(FetchingCheckListWorkforceList());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      CheckListWorkforceListModel checkListWorkforceListModel =
          await _sysUserCheckListRepository.fetchCheckListWorkforceList(
              event.scheduleId, hashCode, event.role);
      add(CheckListCheckBoxCheck(
          responseId: '',
          checkListWorkforceListModel: checkListWorkforceListModel,
          responseIdList: const []));
    } catch (e) {
      emit(CheckListWorkforceListError());
    }
  }

  _checkBoxCheck(CheckListCheckBoxCheck event,
      Emitter<CheckListScheduleDatesResponseStates> emit) {
    List responseIdsList = List.from(event.responseIdList);
    if (event.responseId != '') {
      if (event.responseIdList.contains(event.responseId) != true) {
        responseIdsList.add(event.responseId);
        event.popUpBuilder = true;
      } else {
        responseIdsList.remove(event.responseId);
        event.popUpBuilder = false;
      }
    }
    responsesIdsList = List.from(responseIdsList);
    emit(CheckListWorkforceListFetched(
        checkListWorkforceListModel: event.checkListWorkforceListModel,
        selectedIResponseIdList: responsesIdsList,
        popUpMenuBuilder: event.popUpBuilder));
  }

  _fetchPopUpMenuItems(FetchCheckListPopUpMenu event,
      Emitter<CheckListScheduleDatesResponseStates> emit) {
    List popUpMenuItems = [
      DatabaseUtil.getText('approve'),
      DatabaseUtil.getText('Reject'),
      StringConstants.kThirdParty,
      StringConstants.kEditHeader
    ];
    // if (event.popUpMenuBuilder == false) {
    //   popUpMenuItems.removeAt(2);
    //   popUpMenuItems.removeAt(1);
    //   popUpMenuItems.removeAt(0);
    // }
    emit(CheckListPopUpMenuItemsFetched(popUpMenuItems: popUpMenuItems));
  }
}
