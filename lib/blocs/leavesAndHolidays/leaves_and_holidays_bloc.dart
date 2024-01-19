import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/delete_timesheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../data/models/leavesAndHolidays/save_timesheet_model.dart';
import '../../data/models/leavesAndHolidays/submit_time_sheet_model.dart';
import '../../repositories/leavesAndHolidays/leaves_and_holidays_repository.dart';
import 'leaves_and_holidays_events.dart';
import 'leaves_and_holidays_states.dart';

class LeavesAndHolidaysBloc
    extends Bloc<LeavesAndHolidaysEvent, LeavesAndHolidaysStates> {
  final LeavesAndHolidaysRepository _leavesAndHolidaysRepository =
      getIt<LeavesAndHolidaysRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LeavesAndHolidaysStates get initialState => LeavesAndSummaryInitial();

  LeavesAndHolidaysBloc() : super(LeavesAndSummaryInitial()) {
    on<FetchLeavesSummary>(_fetchLeavesSummary);
    on<FetchLeavesDetails>(_fetchLeavesDetails);
    on<FetchLeavesAndHolidaysMaster>(_fetchMaster);
    on<SelectLeaveType>(_selectLeaveType);
    on<ApplyForLeave>(_applyForLeave);
    on<GetTimeSheet>(_getTimeSheet);
    on<FetchCheckInTimeSheet>(_fetchCheckInTimeSheet);
    on<DeleteTimeSheet>(_deleteTimeSheet);
    on<SaveTimeSheet>(_saveTimeSheet);
    on<SubmitTimeSheet>(_submitTimeSheet);
  }

  String year = "";
  String month = "";
  List timeSheetIdList = [];

  FutureOr _fetchLeavesSummary(
      FetchLeavesSummary event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(FetchingLeavesSummary());
    try {
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLeavesSummaryModel fetchLeavesSummaryModel =
          await _leavesAndHolidaysRepository.fetchLeavesSummary(
              userId!, hashCode!);
      emit(LeavesSummaryFetched(
          fetchLeavesSummaryModel: fetchLeavesSummaryModel));
    } catch (e) {
      emit(LeavesSummaryNotFetched(summaryNotFetched: e.toString()));
    }
  }

  FutureOr _fetchLeavesDetails(
      FetchLeavesDetails event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(FetchingLeavesDetails());
    try {
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLeavesDetailsModel fetchLeavesDetailsModel =
          await _leavesAndHolidaysRepository.fetchLeavesDetails(
              userId!, hashCode!, event.page);
      emit(LeavesDetailsFetched(
          fetchLeavesDetailsModel: fetchLeavesDetailsModel));
    } catch (e) {
      emit(LeavesDetailsNotFetched(detailsNotFetched: e.toString()));
    }
  }

  FutureOr _fetchMaster(FetchLeavesAndHolidaysMaster event,
      Emitter<LeavesAndHolidaysStates> emit) async {
    emit(FetchingLeavesAndHolidaysMaster());
    try {
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchLeavesAndHolidaysMasterModel fetchLeavesAndHolidaysMasterModel =
          await _leavesAndHolidaysRepository.fetchLeavesMaster(hashCode!);
      emit(LeavesAndHolidaysMasterFetched(
          fetchLeavesAndHolidaysMasterModel:
              fetchLeavesAndHolidaysMasterModel));
      add(SelectLeaveType(leaveTypeId: ''));
    } catch (e) {
      emit(LeavesAndHolidaysMasterNotFetched(masterNotFetched: e.toString()));
    }
  }

  _selectLeaveType(
      SelectLeaveType event, Emitter<LeavesAndHolidaysStates> emit) {
    emit(LeaveTypeSelected(leaveTypeId: event.leaveTypeId));
  }

  FutureOr _applyForLeave(
      ApplyForLeave event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(ApplyingForLeave());
    try {
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      if (event.applyForLeaveMap['startdate'] == null) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave: StringConstants.kStartDateValidation));
      } else if (event.applyForLeaveMap['enddate'] == null) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave: StringConstants.kEndDateValidation));
      } else if (DateFormat("dd.MM.yyy")
              .parse(event.applyForLeaveMap['startdate'])
              .compareTo(DateFormat("dd.MM.yyy")
                  .parse(event.applyForLeaveMap['enddate'])) >
          0) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave: DatabaseUtil.getText(
                'Enddateshouldbegreaterthanstartdatetime')));
      } else if (event.applyForLeaveMap['type'] == null ||
          event.applyForLeaveMap['type'].toString().isEmpty) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave: StringConstants.kTypeValidation));
      } else if (event.applyForLeaveMap['reason'] == null ||
          event.applyForLeaveMap['reason'].toString().trim().isEmpty) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave: StringConstants.kReasonValidation));
      } else if (event.applyForLeaveMap['emergencycontact'] == null ||
          event.applyForLeaveMap['emergencycontact']
              .toString()
              .trim()
              .isEmpty) {
        emit(CouldNotApplyForLeave(
            couldNotApplyForLeave:
                StringConstants.kEmergencyContactValidation));
      } else {
        Map applyForLeaveMap = {
          "userid": userId,
          "workforceid": userId,
          "hashcode": hashCode,
          "type": event.applyForLeaveMap['type'],
          "startdate": event.applyForLeaveMap['startdate'],
          "enddate": event.applyForLeaveMap['enddate'],
          "reason": event.applyForLeaveMap['reason'],
          "emergencycontact": event.applyForLeaveMap['emergencycontact']
        };
        ApplyForLeaveModel applyForLeaveModel =
            await _leavesAndHolidaysRepository.applyForLeave(applyForLeaveMap);
        if (applyForLeaveModel.status == 200) {
          emit(AppliedForLeave(applyForLeaveModel: applyForLeaveModel));
        } else {
          emit(ApplyForLeaveManagerConfirmationNeeded(
              confirmationMessage: applyForLeaveModel.message));
        }
      }
    } catch (e) {
      emit(CouldNotApplyForLeave(couldNotApplyForLeave: e.toString()));
    }
  }

  FutureOr<void> _getTimeSheet(
      GetTimeSheet event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(GetTimeSheetFetching());
    try {
      year = event.year;
      month = event.month;

      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);

      FetchTimeSheetModel fetchTimeSheetModel =
          await _leavesAndHolidaysRepository.fetchTimeSheet(
              event.year, event.month, userId!, hashCode!);

      if (fetchTimeSheetModel.status == 200) {
        emit(GetTimeSheetFetched(fetchTimeSheetModel: fetchTimeSheetModel));
      } else {
        emit(GetTimeSheetNotFetched(errorMessage: fetchTimeSheetModel.message));
      }
    } catch (e) {
      emit(GetTimeSheetNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _fetchCheckInTimeSheet(FetchCheckInTimeSheet event,
      Emitter<LeavesAndHolidaysStates> emit) async {
    emit(CheckInTimeSheetFetching());
    try {
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      FetchCheckInTimeSheetModel fetchCheckInTimeSheetModel =
          await _leavesAndHolidaysRepository.fetchCheckInTimeSheet(
              event.date, userId!, hashCode!);
      timeSheetIdList.clear();
      timeSheetIdList.add({'id': fetchCheckInTimeSheetModel.data.timesheetid});
      if (fetchCheckInTimeSheetModel.status == 200) {
        emit(CheckInTimeSheetFetched(
            fetchCheckInTimeSheetModel: fetchCheckInTimeSheetModel));
      } else {
        emit(CheckInTimeSheetNotFetched(
            errorMessage: fetchCheckInTimeSheetModel.message));
      }
    } catch (e) {
      emit(CheckInTimeSheetNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _deleteTimeSheet(
      DeleteTimeSheet event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(TimeSheetDeleting());
    try {
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      Map deleteTimeSheetMap = {
        "idm": "",
        "id": event.timeId,
        "hashcode": hashCode
      };
      DeleteTimeSheetModel deleteTimeSheetModel =
          await _leavesAndHolidaysRepository
              .deleteTimeSheetRepo(deleteTimeSheetMap);
      if (deleteTimeSheetModel.status == 200) {
        emit(TimeSheetDeleted());
      } else {
        emit(TimeSheetNotDeleted(errorMessage: deleteTimeSheetModel.message));
      }
    } catch (e) {
      emit(TimeSheetNotDeleted(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _saveTimeSheet(
      SaveTimeSheet event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(TimeSheetSaving());
    try {
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      final String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map saveTimeSheetMap = {
        "idm": "",
        "workingatid": event.saveTimeSheetMap['workingatid'],
        "workingatnumber": event.saveTimeSheetMap['working_at_number_id'],
        "reportdate": event.saveTimeSheetMap['date'],
        "starttime": event.saveTimeSheetMap['starttime'],
        "endtime": event.saveTimeSheetMap['endtime'],
        "breakmins": event.saveTimeSheetMap['breakmins'],
        "description": event.saveTimeSheetMap['description'],
        "userid": userId,
        "id": "",
        "hashcode": hashCode
      };
      SaveTimeSheetModel saveTimeSheetModel =
          await _leavesAndHolidaysRepository.saveTimeSheet(saveTimeSheetMap);

      if (saveTimeSheetModel.status == 200) {
        emit(TimeSheetSaved(saveTimeSheetModel: saveTimeSheetModel));
      } else {
        emit(TimeSheetNotSaved(errorMessage: saveTimeSheetModel.message));
      }
    } catch (e) {
      emit(TimeSheetNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _submitTimeSheet(
      SubmitTimeSheet event, Emitter<LeavesAndHolidaysStates> emit) async {
    emit(TimeSheetSubmitting());
    try {
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      Map submitTimeSheetMap = {
        "idm": timeSheetIdList,
        "timesheetids": timeSheetIdList,
        "hashcode": hashCode
      };
      SubmitTimeSheetModel submitTimeSheetModel =
          await _leavesAndHolidaysRepository
              .submitTimeSheetRepo(submitTimeSheetMap);
      if (submitTimeSheetModel.status == 200) {
        emit(TimeSheetSubmitted());
      } else {
        emit(TimeSheetNotSubmitted(errorMessage: submitTimeSheetModel.message));
      }
    } catch (e) {
      emit(TimeSheetNotSubmitted(errorMessage: e.toString()));
    }
  }
}
