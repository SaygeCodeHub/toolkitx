import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/tickets/fetch_ticket_master_model.dart';
import 'package:toolkit/data/models/tickets/fetch_tickets_model.dart';
import 'package:toolkit/repositories/tickets/tickets_repository.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';

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
  }

  String selectApplicationName = '';
  bool hasReachedMax = false;
  List<TicketListDatum> ticketDatum = [];
  Map filters = {};

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
}
