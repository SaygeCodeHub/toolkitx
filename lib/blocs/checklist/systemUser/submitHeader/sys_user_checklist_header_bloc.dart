import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/sys_user_checklist_header_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_edit_header_details_model.dart';
import '../../../../data/models/checklist/systemUser/sys_user_submit_header_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../../../../utils/database_utils.dart';

class CheckListHeaderBloc
    extends Bloc<CheckListHeaderEvent, CheckListHeaderStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  CheckListHeaderStates get initialState => CheckListHeaderInitial();

  CheckListHeaderBloc() : super(CheckListHeaderInitial()) {
    on<FetchCheckListEditHeader>(_fetchEditHeader);
    on<CheckListSubmitHeader>(_submitHeader);
  }

  FutureOr<void> _fetchEditHeader(FetchCheckListEditHeader event,
      Emitter<CheckListHeaderStates> emit) async {
    emit(FetchingCheckListEditHeader(scheduleId: event.scheduleId));
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      CheckListEditHeaderDetailsModel checkListEditHeaderDetailsModel =
          await _sysUserCheckListRepository.fetchCheckListEditHeader(
              event.scheduleId, hashCode);
      if (checkListEditHeaderDetailsModel.status == 200) {
        emit(CheckListEditHeaderFetched(
            getCheckListEditHeaderModel: checkListEditHeaderDetailsModel));
      } else {
        emit(CheckListEditHeaderError(
            noHeaderMessage: StringConstants.kNoHeader));
      }
    } catch (e) {
      emit(CheckListEditHeaderError(
          noHeaderMessage: StringConstants.kSomethingWentWrong));
    }
  }

  FutureOr<void> _submitHeader(
      CheckListSubmitHeader event, Emitter<CheckListHeaderStates> emit) async {
    emit(SubmittingCheckListHeader());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.submitHeaderList[0]["value"] == "" &&
          event.submitHeaderList[0]["ismandatory"] == 1) {
        emit(CheckListHeaderNotSubmitted(
            message: DatabaseUtil.getText('Pleaseanswerthemandatoryquestion')));
      } else if (event.submitHeaderList[1]["value"] == "" &&
          event.submitHeaderList[1]["ismandatory"] == 1) {
        emit(CheckListHeaderNotSubmitted(
            message: DatabaseUtil.getText('Pleaseanswerthemandatoryquestion')));
      } else if (event.submitHeaderList[2]["value"] == "" &&
          event.submitHeaderList[2]["ismandatory"] == 1) {
        emit(CheckListHeaderNotSubmitted(
            message: DatabaseUtil.getText('Pleaseanswerthemandatoryquestion')));
      } else {
        Map postEditHeaderMap = {
          "hashcode": hashCode,
          "answers": event.submitHeaderList,
          "scheduleid": event.scheduleId
        };
        ChecklistSubmitHeaderModel checklistSubmitHeaderModel =
            await _sysUserCheckListRepository
                .submitCheckListHeader(postEditHeaderMap);
        emit(CheckListHeaderSubmitted(
            checklistSubmitHeaderModel: checklistSubmitHeaderModel,
            headerMessage: 'The data has been saved successfully!'));
      }
    } catch (e) {
      emit(CheckListHeaderNotSubmitted(message: e.toString()));
    }
  }
}
