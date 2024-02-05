import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/leavesAndHolidays/fetch_time_sheet_details_model.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../di/app_module.dart';
import '../../data/models/expense/expense_working_at_number_model.dart';
import '../../data/models/leavesAndHolidays/apply_for_leave_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_checkin_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/delete_timesheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_get_time_sheet_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_and_holidays_master_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_details_model.dart';
import '../../data/models/leavesAndHolidays/fetch_leaves_summary_model.dart';
import '../../data/models/leavesAndHolidays/save_timesheet_model.dart';
import '../../data/models/leavesAndHolidays/submit_time_sheet_model.dart';
import '../../repositories/expense/expense_repository.dart';
import '../../repositories/leavesAndHolidays/leaves_and_holidays_repository.dart';
import '../../screens/leavesAndHolidays/add_and_edit_timesheet_screen.dart';
import '../../screens/leavesAndHolidays/widgtes/working_at_number_timesheet_tile.dart';
import '../../screens/leavesAndHolidays/widgtes/working_at_timesheet_tile.dart';
import '../../screens/leavesAndHolidays/leaves_and_holidays_checkbox.dart';
import 'leaves_and_holidays_events.dart';
import 'leaves_and_holidays_states.dart';

class LeavesAndHolidaysBloc
    extends Bloc<LeavesAndHolidaysEvent, LeavesAndHolidaysStates> {
  final LeavesAndHolidaysRepository _leavesAndHolidaysRepository =
      getIt<LeavesAndHolidaysRepository>();
  final ExpenseRepository _expenseRepository = getIt<ExpenseRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  LeavesAndHolidaysStates get initialState => LeavesAndSummaryInitial();

  LeavesAndHolidaysBloc() : super(LeavesAndSummaryInitial()) {
    on<FetchLeavesSummary>(_fetchLeavesSummary);
    on<FetchLeavesDetails>(_fetchLeavesDetails);
    on<FetchLeavesAndHolidaysMaster>(_fetchMaster);
    on<SelectLeaveType>(_selectLeaveType);
    on<SelectTimeSheetWorkingAtOption>(_selectTimeSheetWorkingAtOption);
    on<SelectTimeSheetWorkingAtNumber>(_selectTimeSheetWorkingAtNumber);
    on<ApplyForLeave>(_applyForLeave);
    on<GetTimeSheet>(_getTimeSheet);
    on<FetchCheckInTimeSheet>(_fetchCheckInTimeSheet);
    on<DeleteTimeSheet>(_deleteTimeSheet);
    on<SaveTimeSheet>(_saveTimeSheet);
    on<SubmitTimeSheet>(_submitTimeSheet);
    on<FetchTimeSheetWorkingAtNumberData>(_fetchTimeSheetWorkingAtNumberData);
    on<FetchTimeSheetDetails>(_fetchTimeSheetDetails);
    on<SelectCheckBox>(_selectCheckBox);
    on<SelectAllCheckBox>(_selectAllCheckBox);
  }

  String year = "";
  String month = "";
  List timeSheetIdList = [];
  Map timeSheetWorkingAtMap = {};
  Map timeSheetWorkingAtNumberMap = {};
  bool isChecked = true;

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

  _selectTimeSheetWorkingAtOption(SelectTimeSheetWorkingAtOption event,
      Emitter<LeavesAndHolidaysStates> emit) {
    if (timeSheetWorkingAtMap.isNotEmpty) {
      for (int i = 0; i < timeSheetWorkingAtMap.values.length; i++) {
        WorkingAtTimeSheetTile.workingAt =
            timeSheetWorkingAtMap.values.elementAt(i);
        WorkingAtTimeSheetTile.workingAtValue =
            timeSheetWorkingAtMap.keys.elementAt(i);
        AddAndEditTimeSheetScreen.saveTimeSheetMap['workingatid'] =
            WorkingAtTimeSheetTile.workingAt;
      }
    } else {
      WorkingAtTimeSheetTile.workingAt = event.workingAt;
      WorkingAtTimeSheetTile.workingAtValue = event.workingAtValue;
    }
    emit(TimeSheetWorkingAtOptionSelected(
        workingAt: WorkingAtTimeSheetTile.workingAt,
        workingAtValue: WorkingAtTimeSheetTile.workingAtValue));
    add(FetchTimeSheetWorkingAtNumberData(
        groupBy: WorkingAtTimeSheetTile.workingAt));
  }

  FutureOr<void> _selectTimeSheetWorkingAtNumber(
      SelectTimeSheetWorkingAtNumber event,
      Emitter<LeavesAndHolidaysStates> emit) {
    if (timeSheetWorkingAtNumberMap.isNotEmpty) {
      for (int j = 0; j < timeSheetWorkingAtNumberMap.values.length; j++) {
        TimSheetWorkingAtNumberListTile.workingAtNumberMap = {
          "working_at_number_id":
              timeSheetWorkingAtNumberMap.values.elementAt(j),
          "working_at_number": timeSheetWorkingAtMap.values.elementAt(0)
        };
        AddAndEditTimeSheetScreen.saveTimeSheetMap['workingatnumber'] =
            TimSheetWorkingAtNumberListTile
                .workingAtNumberMap['working_at_number_id'];
      }
    } else {
      TimSheetWorkingAtNumberListTile.workingAtNumberMap =
          event.timeSheetWorkingAtNumberMap;
    }
    emit(TimeSheetWorkingAtNumberSelected(
        timeSheetWorkingAtNumberMap:
            TimSheetWorkingAtNumberListTile.workingAtNumberMap));
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

  FutureOr<void> _fetchTimeSheetWorkingAtNumberData(
      FetchTimeSheetWorkingAtNumberData event,
      Emitter<LeavesAndHolidaysStates> emit) async {
    try {
      emit(FetchingTimeSheetWorkingAtNumberData());
      ExpenseWorkingAtNumberDataModel expenseWorkingAtNumberDataModel =
          await _expenseRepository.fetchWorkingAtNumberData({
        "groupby": event.groupBy,
        "userid": await _customerCache.getUserId(CacheKeys.userId),
        "hashcode": await _customerCache.getHashCode(CacheKeys.hashcode)
      });
      if (expenseWorkingAtNumberDataModel.data.isNotEmpty) {
        emit(TimeSheetWorkingAtNumberDataFetched(
            expenseWorkingAtNumberDataModel: expenseWorkingAtNumberDataModel));
      } else {
        emit(TimeSheetWorkingAtNumberDataNotFetched(
            dataNotFetched: StringConstants.kNoRecordsFound));
      }
    } catch (e) {
      emit(
          TimeSheetWorkingAtNumberDataNotFetched(dataNotFetched: e.toString()));
    }
  }

  FutureOr _fetchTimeSheetDetails(FetchTimeSheetDetails event,
      Emitter<LeavesAndHolidaysStates> emit) async {
    try {
      emit(FetchingTimeSheetDetails());
      final String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchTimeSheetDetailsModel fetchTimeSheetDetailsModel =
          await _leavesAndHolidaysRepository.fetchTimeSheetDetails(
              hashCode!, event.timeSheetDetailsId);
      AddAndEditTimeSheetScreen.saveTimeSheetMap["starttime"] =
          fetchTimeSheetDetailsModel.data.starttime;
      AddAndEditTimeSheetScreen.saveTimeSheetMap["endtime"] =
          fetchTimeSheetDetailsModel.data.endtime;
      AddAndEditTimeSheetScreen.saveTimeSheetMap["breakmins"] =
          fetchTimeSheetDetailsModel.data.breakmins;
      AddAndEditTimeSheetScreen.saveTimeSheetMap["description"] =
          fetchTimeSheetDetailsModel.data.description;
      emit(TimeSheetDetailsFetched(
          fetchTimeSheetDetailsModel: fetchTimeSheetDetailsModel));
      if (fetchTimeSheetDetailsModel.data.toJson().isNotEmpty) {
        for (int i = 0;
            i < fetchTimeSheetDetailsModel.data.toJson().keys.length;
            i++) {
          switch (fetchTimeSheetDetailsModel.data.toJson().keys.elementAt(i)) {
            case "woid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(i) !=
                  '') {
                timeSheetWorkingAtMap['Workorder'] = "wo";
              }
              break;
            case "wbsid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(i) !=
                  '') {
                timeSheetWorkingAtMap['WBS'] = "wbs";
              }
              break;
            case "projectid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(i) !=
                  '') {
                timeSheetWorkingAtMap['Project'] = "project";
              }
              break;
            case "generalwbsid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(i) !=
                  '') {
                timeSheetWorkingAtMap['General WBS'] = "generalwbs";
              }
              break;
          }
        }

        for (int j = 0;
            j < fetchTimeSheetDetailsModel.data.toJson().keys.length;
            j++) {
          switch (fetchTimeSheetDetailsModel.data.toJson().keys.elementAt(j)) {
            case "woid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(j) !=
                  '') {
                timeSheetWorkingAtNumberMap['wo'] = fetchTimeSheetDetailsModel
                    .data
                    .toJson()
                    .values
                    .elementAt(j);
              }
              break;
            case "wbsid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(j) !=
                  '') {
                timeSheetWorkingAtNumberMap['wbs'] = fetchTimeSheetDetailsModel
                    .data
                    .toJson()
                    .values
                    .elementAt(j);
              }

              break;
            case "projectid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(j) !=
                  '') {
                timeSheetWorkingAtNumberMap['project'] =
                    fetchTimeSheetDetailsModel.data
                        .toJson()
                        .values
                        .elementAt(j);
              }

              break;
            case "generalwbsid":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(j) !=
                  '') {
                timeSheetWorkingAtNumberMap['general_wbs'] =
                    fetchTimeSheetDetailsModel.data
                        .toJson()
                        .values
                        .elementAt(j);
              }

              break;
            case "workingat":
              if (fetchTimeSheetDetailsModel.data
                      .toJson()
                      .values
                      .elementAt(j) !=
                  '') {
                timeSheetWorkingAtNumberMap['working_at'] =
                    timeSheetWorkingAtNumberMap['general_wbs'] =
                        fetchTimeSheetDetailsModel.data
                            .toJson()
                            .values
                            .elementAt(j);
              }
          }
        }
        emit(TimeSheetDetailsFetched(
            fetchTimeSheetDetailsModel: fetchTimeSheetDetailsModel));
      } else {
        emit(TimeSheetDetailsNotFetched(
            errorMessage: fetchTimeSheetDetailsModel.message));
      }
    } catch (e) {
      emit(TimeSheetDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectCheckBox(
      SelectCheckBox event, Emitter<LeavesAndHolidaysStates> emit) {
    emit(CheckBoxSelected(isChecked: event.isChecked));
    isChecked = event.isChecked;
  }

  FutureOr<void> _selectAllCheckBox(
      SelectAllCheckBox event, Emitter<LeavesAndHolidaysStates> emit) {
    for (int i = 0; i <= event.dates.length - 1; i++) {
      TimeSheetCheckbox.idsList.add(event.dates[i].id);
      add(SelectCheckBox(isChecked: isChecked));
    }
  }
}
