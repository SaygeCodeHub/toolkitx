import 'dart:async';

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
  }

  Future<FutureOr<void>> _fetchTickets(
      FetchTickets event, Emitter<TicketsStates> emit) async {
    emit(TicketsFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchTicketsModel fetchTicketsModel =
          await _ticketsRepository.fetchTickets(event.pageNo, hashCode, '');
      if (fetchTicketsModel.status == 200) {
        emit(TicketsFetched(fetchTicketsModel: fetchTicketsModel));
      } else {
        emit(TicketsNotFetched(errorMessage: fetchTicketsModel.message));
      }
    } catch (e) {
      emit(TicketsNotFetched(errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _fetchTicketMaster(FetchTicketMaster event, Emitter<TicketsStates> emit) async {
    emit(TicketMasterFetching());
    try {
      String? hashCode =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      FetchTicketMasterModel fetchTicketMasterModel =
          await _ticketsRepository.fetchTicketMaster(hashCode);
      if (fetchTicketMasterModel.status == 200) {
        emit(TicketMasterFetched(fetchTicketMasterModel: fetchTicketMasterModel));
      } else {
        emit(TicketMasterNotFetched(errorMessage: fetchTicketMasterModel.message));
      }
    } catch (e) {
      emit(TicketMasterNotFetched(errorMessage: e.toString()));
    }
  }
}
