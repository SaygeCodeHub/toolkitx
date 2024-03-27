import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_master_model.dart';
import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';
import 'package:toolkit/data/models/tickets/save_ticket_comment_model.dart';
import 'package:toolkit/data/models/tickets/save_ticket_model.dart';
import 'package:toolkit/data/models/tickets/update_ticket_status_model.dart';
import 'package:toolkit/repositories/tickets/tickets_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/tickets/fetch_ticket_details_model.dart';
import '../../di/app_module.dart';
import '../../utils/database_utils.dart';

part 'tickets_event.dart';

part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvents, TicketsStates> {
  final TicketsRepository _ticketsRepository = getIt<TicketsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TicketsStates get initialState => TicketsInitial();

  TicketsBloc() : super(TicketsInitial()) {
    on<FetchTickets>(_fetchTickets);
    on<FetchTicketMaster>(_fetchTicketMaster);
    on<SelectTicketStatusFilter>(_selectTicketStatusFilter);
    on<SelectTicketBugFilter>(_selectTicketBugFilter);
    on<SelectTicketApplication>(_selectTicketApplication);
    on<ApplyTicketsFilter>(_applyTicketsFilter);
    on<ClearTicketsFilter>(_clearTicketsFilterFilter);
    on<FetchTicketDetails>(_fetchTicketDetails);
    on<SaveTicket>(_saveTicket);
    on<SelectPriority>(_selectPriority);
    on<SelectBugType>(_selectBugType);
    on<SaveTicketComment>(_saveTicketComment);
    on<UpdateTicketStatus>(_updateTicketStatus);
  }

  String selectApplicationName = '';
  bool hasReachedMax = false;
  List<TicketListDatum> ticketDatum = [];
  Map filters = {};
  int ticketTabIndex = 0;
  String ticketId = '';

  Future<FutureOr<void>> _fetchTickets(
      FetchTickets event, Emitter<TicketsStates> emit) async {
    emit(TicketsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      if (event.isFromHome == true) {
        FetchTicketsModel fetchTicketsModel =
            await _ticketsRepository.fetchTickets(event.pageNo, hashCode, '');
        ticketDatum.addAll(fetchTicketsModel.data);
        hasReachedMax = fetchTicketsModel.data.isEmpty;
        emit(TicketsFetched(
            ticketData: ticketDatum,
            filterMap: {},
            fetchTicketsModel: fetchTicketsModel));
      } else {
        FetchTicketsModel fetchTicketsModel = await _ticketsRepository
            .fetchTickets(event.pageNo, hashCode, jsonEncode(filters));
        ticketDatum.addAll((fetchTicketsModel.data));
        hasReachedMax = fetchTicketsModel.data.isEmpty;
        emit(TicketsFetched(
            ticketData: ticketDatum,
            filterMap: filters,
            fetchTicketsModel: fetchTicketsModel));
      }
    } catch (e) {
      emit(TicketsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTicketMaster(
      FetchTicketMaster event, Emitter<TicketsStates> emit) async {
    emit(TicketMasterFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchTicketMasterModel fetchTicketMasterModel =
          await _ticketsRepository.fetchTicketMaster(hashCode);
      if (fetchTicketMasterModel.status == 200) {
        emit(TicketMasterFetched(
            fetchTicketMasterModel: fetchTicketMasterModel));
      } else {
        emit(TicketMasterNotFetched(
            errorMessage: fetchTicketMasterModel.message));
      }
    } catch (e) {
      emit(TicketMasterNotFetched(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectTicketStatusFilter(
      SelectTicketStatusFilter event, Emitter<TicketsStates> emit) {
    emit(TicketStatusFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _selectTicketBugFilter(
      SelectTicketBugFilter event, Emitter<TicketsStates> emit) {
    emit(TicketBugFilterSelected(
        selected: event.selected, selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _selectTicketApplication(
      SelectTicketApplication event, Emitter<TicketsStates> emit) {
    emit(TicketApplicationFilterSelected(
        selectApplicationName: event.selectApplicationName));
  }

  FutureOr<void> _applyTicketsFilter(
      ApplyTicketsFilter event, Emitter<TicketsStates> emit) {
    filters = event.ticketsFilterMap;
  }

  FutureOr<void> _clearTicketsFilterFilter(
      ClearTicketsFilter event, Emitter<TicketsStates> emit) {
    filters = {};
  }

  Future<FutureOr<void>> _fetchTicketDetails(
      FetchTicketDetails event, Emitter<TicketsStates> emit) async {
    ticketTabIndex = event.ticketTabIndex;
    emit(TicketDetailsFetching());
    try {
      List popUpMenuItemsList = [
        DatabaseUtil.getText('AddComments'),
        DatabaseUtil.getText('AddDocuments'),
        DatabaseUtil.getText('ticket_close'),
        DatabaseUtil.getText('Cancel'),
      ];

      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      FetchTicketDetailsModel fetchTicketDetailsModel = await _ticketsRepository
          .fetchTicketDetails(hashCode, event.ticketId, userId);
      ticketId = event.ticketId;
      if (fetchTicketDetailsModel.data.candeferred == '1') {
        popUpMenuItemsList.insert(1, DatabaseUtil.getText('ticket_defer'));
      }
      if (fetchTicketDetailsModel.data.canestimateedt == '1') {
        popUpMenuItemsList.insert(
            2, DatabaseUtil.getText('ticket_estimateedt'));
      }
      if (fetchTicketDetailsModel.data.candevelopment == '1') {
        popUpMenuItemsList.insert(
            2, DatabaseUtil.getText('ticket_development'));
      }
      if (fetchTicketDetailsModel.data.canapprovedfordevelopment == '1') {
        popUpMenuItemsList.insert(
            3, DatabaseUtil.getText('ticket_approvefordevelopment'));
      }
      if (fetchTicketDetailsModel.data.canwaitingfordevelopmentapproval ==
          '1') {
        popUpMenuItemsList.insert(
            3, DatabaseUtil.getText('ticket_waitingfordevelopmentapproval'));
      }
      if (fetchTicketDetailsModel.data.cantesting == '1') {
        popUpMenuItemsList.insert(3, DatabaseUtil.getText('ticket_testing'));
      }
      if (fetchTicketDetailsModel.data.canapproved == '1') {
        popUpMenuItemsList.insert(3, DatabaseUtil.getText('approve'));
      }
      if (fetchTicketDetailsModel.data.canrolledout == '1') {
        popUpMenuItemsList.insert(3, DatabaseUtil.getText('ticket_rollout'));
      }

      if (fetchTicketDetailsModel.status == 200) {
        emit(TicketDetailsFetched(
            fetchTicketDetailsModel: fetchTicketDetailsModel,
            ticketPopUpMenu: popUpMenuItemsList));
      } else {
        emit(TicketDetailsNotFetched(
            errorMessage: fetchTicketDetailsModel.message));
      }
    } catch (e) {
      emit(TicketDetailsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _saveTicket(
      SaveTicket event, Emitter<TicketsStates> emit) async {
    emit(TicketSaving());
    try {
      event.saveTicketMap['hashcode'] =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      event.saveTicketMap['userid'] =
          await _customerCache.getUserId(CacheKeys.userId) ?? '';
      SaveTicketModel saveTicketModel =
          await _ticketsRepository.saveTicketModel(event.saveTicketMap);
      if (saveTicketModel.status == 200) {
        emit(TicketSaved(saveTicketModel: saveTicketModel));
      } else {
        emit(TicketNotSaved(errorMessage: saveTicketModel.message));
      }
    } catch (e) {
      emit(TicketNotSaved(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _selectPriority(
      SelectPriority event, Emitter<TicketsStates> emit) {
    emit(PrioritySelected(
        priorityId: event.priorityId, priorityName: event.priorityName));
  }

  FutureOr<void> _selectBugType(
      SelectBugType event, Emitter<TicketsStates> emit) {
    emit(BugTypeSelected(bugType: event.bugType, bugValue: event.bugValue));
  }

  Future<FutureOr<void>> _saveTicketComment(
      SaveTicketComment event, Emitter<TicketsStates> emit) async {
    emit(TicketCommentSaving());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map saveCommentMap = {
        "hashcode": hashCode,
        "ticketid": ticketId,
        "comments": event.comment,
        "commentid": "",
        "userid": userId
      };
      SaveTicketCommentModel saveTicketCommentModel =
          await _ticketsRepository.saveTicketComment(saveCommentMap);
      if (saveTicketCommentModel.message == '1') {
        emit(TicketCommentSaved());
      } else {
        emit(TicketNotSaved(errorMessage: saveTicketCommentModel.message));
      }
    } catch (e) {
      emit(TicketNotSaved(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _updateTicketStatus(
      UpdateTicketStatus event, Emitter<TicketsStates> emit) async {
    emit(TicketStatusUpdating());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
      Map updateStatusMap = {
        "edt": event.edtHrs,
        "ticketid": ticketId,
        "userid": userId,
        "status": event.status,
        "completiondate": event.completionDate,
        "hashcode": hashCode
      };
      UpdateTicketStatusModel updateTicketStatusModel =
          await _ticketsRepository.updateTicketStatus(updateStatusMap);
      if (updateTicketStatusModel.message == '1') {
        emit(TicketStatusUpdated());
      } else {
        emit(TicketStatusNotUpdated(
            errorMessage: updateTicketStatusModel.message));
      }
    } catch (e) {
      emit(TicketStatusNotUpdated(errorMessage: e.toString()));
    }
  }
}
