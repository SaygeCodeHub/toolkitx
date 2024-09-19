import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/tickets2/save_ticket2_model.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/tickets2/fetch_ticket2_master_model.dart';
import '../../di/app_module.dart';
import '../../repositories/tickets2/tickets2_repository.dart';
import '../../utils/constants/string_constants.dart';

part 'tickets2_event.dart';

part 'tickets2_state.dart';

class Tickets2Bloc extends Bloc<Tickets2Events, Tickets2States> {
  final Tickets2Repository _ticketsRepository = getIt<Tickets2Repository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  Tickets2States get initialState => Tickets2Initial();

  Tickets2Bloc() : super(Tickets2Initial()) {
    // on<FetchTickets2>(_fetchTickets2);
    on<FetchTicket2Master>(_fetchTicket2Master);
    // on<SelectTicket2StatusFilter>(_selectTicket2StatusFilter);
    // on<SelectTicket2BugFilter>(_selectTicket2BugFilter);
    // on<SelectTicket2Application>(_selectTicket2Application);
    // on<ApplyTickets2Filter>(_applyTickets2Filter);
    // on<ClearTickets2Filter>(_clearTickets2FilterFilter);
    // on<FetchTicket2Details>(_fetchTicket2Details);
    on<SaveTicket2>(_saveTicket2);
    // on<SelectPriority>(_selectPriority);
    // on<SelectBugType>(_selectBugType);
    // on<SaveTicket2Comment>(_saveTicket2Comment);
    // on<SaveTicket2Document>(_saveTicket2Document);
    // on<UpdateTicket2Status>(_updateTicket2Status);
    // on<SaveOpenTicket2>(_saveOpenTicket2);
    // on<SelectVoValue>(_selectVoValue);
  }

  String selectApplicationName = '';
  bool hasReachedMax = false;
  List<Ticket2MasterDatum> ticketDatum = [];
  Map filters = {};
  int ticketTabIndex = 0;
  String ticketId = '';

  // Future<FutureOr<void>> _fetchTickets2(
  //     FetchTickets2 event, Emitter<Tickets2States> emit) async {
  //   emit(Tickets2Fetching());
  //   try {
  //     String? hashCode =
  //         await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
  //     if (event.isFromHome) {
  //       FetchTickets2Model fetchTickets2Model =
  //           await _ticketsRepository.fetchTickets2(event.pageNo, hashCode, '{}');
  //       ticketDatum.addAll(fetchTickets2Model.data);
  //       hasReachedMax = fetchTickets2Model.data.isEmpty;
  //       emit(Tickets2Fetched(
  //           ticketData: ticketDatum,
  //           filterMap: {},
  //           fetchTickets2Model: fetchTickets2Model));
  //     } else {
  //       FetchTickets2Model fetchTickets2Model = await _ticketsRepository
  //           .fetchTickets2(event.pageNo, hashCode, jsonEncode(filters));
  //       ticketDatum.addAll((fetchTickets2Model.data));
  //       hasReachedMax = fetchTickets2Model.data.isEmpty;
  //       emit(Tickets2Fetched(
  //           ticketData: ticketDatum,
  //           filterMap: filters,
  //           fetchTickets2Model: fetchTickets2Model));
  //     }
  //   } catch (e) {
  //     emit(Tickets2NotFetched(errorMessage: e.toString()));
  //   }
  // }

  Future<FutureOr<void>> _fetchTicket2Master(
      FetchTicket2Master event, Emitter<Tickets2States> emit) async {
    emit(Ticket2MasterFetching());
    try {
    String? hashCode =
        await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
    FetchTicket2MasterModel fetchTicket2MasterModel = await _ticketsRepository
        .fetchTicket2Master(hashCode, event.responsequeid);
    if (fetchTicket2MasterModel.status == 200) {
      String desc = '';
      if (fetchTicket2MasterModel.data[3].isNotEmpty) {
        for (var item in fetchTicket2MasterModel.data[3]) {
          desc = item.text;
        }
      }
      emit(Ticket2MasterFetched(
          fetchTicket2MasterModel: fetchTicket2MasterModel, desc: desc));
    } else {
      emit(Ticket2MasterNotFetched(
          errorMessage: fetchTicket2MasterModel.message));
    }
    } catch (e) {
      emit(Ticket2MasterNotFetched(errorMessage: e.toString()));
    }
  }

// FutureOr<void> _selectTicket2StatusFilter(
//     SelectTicket2StatusFilter event, Emitter<Tickets2States> emit) {
//   emit(Ticket2StatusFilterSelected(
//       selected: event.selected, selectedIndex: event.selectedIndex));
// }
//
// FutureOr<void> _selectTicket2BugFilter(
//     SelectTicket2BugFilter event, Emitter<Tickets2States> emit) {
//   emit(Ticket2BugFilterSelected(
//       selected: event.selected, selectedIndex: event.selectedIndex));
// }
//
// FutureOr<void> _selectTicket2Application(
//     SelectTicket2Application event, Emitter<Tickets2States> emit) {
//   emit(Ticket2ApplicationFilterSelected(
//       selectApplicationName: event.selectApplicationName));
// }
//
// FutureOr<void> _applyTickets2Filter(
//     ApplyTickets2Filter event, Emitter<Tickets2States> emit) {
//   filters = event.ticketsFilterMap;
// }
//
// FutureOr<void> _clearTickets2FilterFilter(
//     ClearTickets2Filter event, Emitter<Tickets2States> emit) {
//   filters = {};
// }
//
// Future<FutureOr<void>> _fetchTicket2Details(
//     FetchTicket2Details event, Emitter<Tickets2States> emit) async {
//   ticketTabIndex = event.ticketTabIndex;
//   emit(Ticket2DetailsFetching());
//   // try {
//   List popUpMenuItemsList = [
//     DatabaseUtil.getText('AddComments'),
//     DatabaseUtil.getText('AddDocuments'),
//     DatabaseUtil.getText('Cancel'),
//   ];
//
//   String? hashCode =
//       await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
//   String userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
//   String clientId =
//       await _customerCache.getClientId(CacheKeys.clientId) ?? '';
//   FetchTicket2DetailsModel fetchTicket2DetailsModel = await _ticketsRepository
//       .fetchTicket2Details(hashCode, event.ticketId, userId);
//   ticketId = event.ticketId;
//   if (fetchTicket2DetailsModel.data.candeferred == '1') {
//     popUpMenuItemsList.insert(1, DatabaseUtil.getText('ticket_defer'));
//   }
//   if (fetchTicket2DetailsModel.data.canestimateedt == '1') {
//     popUpMenuItemsList.insert(2, DatabaseUtil.getText('ticket_estimateedt'));
//   }
//   if (fetchTicket2DetailsModel.data.candevelopment == '1') {
//     popUpMenuItemsList.insert(2, DatabaseUtil.getText('ticket_development'));
//   }
//   if (fetchTicket2DetailsModel.data.canapprovedfordevelopment == '1' ||
//       fetchTicket2DetailsModel.data.canapprovedfordevelopmentvo == '1') {
//     popUpMenuItemsList.insert(
//         3, DatabaseUtil.getText('ticket_approvefordevelopment'));
//   }
//   if (fetchTicket2DetailsModel.data.canwaitingfordevelopmentapproval == '1') {
//     popUpMenuItemsList.insert(
//         3, DatabaseUtil.getText('ticket_waitingfordevelopmentapproval'));
//   }
//   if (fetchTicket2DetailsModel.data.cantesting == '1') {
//     popUpMenuItemsList.insert(3, DatabaseUtil.getText('ticket_testing'));
//   }
//   if (fetchTicket2DetailsModel.data.canapproved == '1') {
//     popUpMenuItemsList.insert(3, DatabaseUtil.getText('approve'));
//   }
//   if (fetchTicket2DetailsModel.data.canrolledout == '1') {
//     popUpMenuItemsList.insert(3, DatabaseUtil.getText('ticket_rollout'));
//   }
//   if (fetchTicket2DetailsModel.data.canclose == '1') {
//     popUpMenuItemsList.insert(2, DatabaseUtil.getText('ticket_close'));
//   }
//   if (fetchTicket2DetailsModel.data.canopenticket == '1') {
//     popUpMenuItemsList.insert(3, StringConstants.kOpenTicket);
//   }
//   if (fetchTicket2DetailsModel.data.canbacktoapproved == '1') {
//     popUpMenuItemsList.insert(3, StringConstants.kBackToApprove);
//   }
//   if (fetchTicket2DetailsModel.data.canapproverolledout == '1') {
//     popUpMenuItemsList.insert(3, StringConstants.kApproveRolledOut);
//   }
//
//   if (fetchTicket2DetailsModel.status == 200) {
//     emit(Ticket2DetailsFetched(
//         fetchTicket2DetailsModel: fetchTicket2DetailsModel,
//         ticketPopUpMenu: popUpMenuItemsList,
//         clientId: clientId));
//   } else {
//     emit(Ticket2DetailsNotFetched(
//         errorMessage: fetchTicket2DetailsModel.message));
//   }
//   // } catch (e) {
//   //   emit(Ticket2DetailsNotFetched(errorMessage: e.toString()));
//   // }
// }

  Future<FutureOr<void>> _saveTicket2(
      SaveTicket2 event, Emitter<Tickets2States> emit) async {
    emit(Ticket2Saving());
    try {
      event.saveTicket2Map['hashcode'] =
          await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
      event.saveTicket2Map['userid'] =
          await _customerCache.getUserId(CacheKeys.userId) ?? '';
      if (event.saveTicket2Map['header'] != null &&
          event.saveTicket2Map['application'] != null &&
          event.saveTicket2Map['priority'] != null &&
          event.saveTicket2Map['description'] != null &&
          event.saveTicket2Map['description'] != '' &&
          event.saveTicket2Map['distlist'] != null) {
        SaveTicket2Model saveTicket2Model =
            await _ticketsRepository.saveTicket2Model(event.saveTicket2Map);
        if (saveTicket2Model.status == 200) {
          emit(Ticket2Saved(saveTicket2Model: saveTicket2Model));
        } else {
          emit(Ticket2NotSaved(errorMessage: saveTicket2Model.message));
        }
      } else {
        emit(
            Ticket2NotSaved(errorMessage: StringConstants.kAllFieldsMandatory));
      }
    } catch (e) {
      emit(Ticket2NotSaved(errorMessage: e.toString()));
    }
  }

// FutureOr<void> _selectPriority(
//     SelectPriority event, Emitter<Tickets2States> emit) {
//   emit(PrioritySelected(
//       priorityId: event.priorityId, priorityName: event.priorityName));
// }
//
// FutureOr<void> _selectBugType(
//     SelectBugType event, Emitter<Tickets2States> emit) {
//   emit(BugTypeSelected(bugType: event.bugType, bugValue: event.bugValue));
// }
//
// Future<FutureOr<void>> _saveTicket2Comment(
//     SaveTicket2Comment event, Emitter<Tickets2States> emit) async {
//   emit(Ticket2CommentSaving());
//   try {
//     String? hashCode =
//         await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
//     String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
//     Map saveCommentMap = {
//       "hashcode": hashCode,
//       "ticketid": ticketId,
//       "comments": event.comment,
//       "commentid": "",
//       "userid": userId
//     };
//     SaveTicket2CommentModel saveTicket2CommentModel =
//         await _ticketsRepository.saveTicket2Comment(saveCommentMap);
//     if (saveTicket2CommentModel.message == '1') {
//       emit(Ticket2CommentSaved());
//     } else {
//       emit(Ticket2CommentNotSaved(
//           errorMessage: saveTicket2CommentModel.message));
//     }
//   } catch (e) {
//     emit(Ticket2CommentNotSaved(errorMessage: e.toString()));
//   }
// }
//
// Future<FutureOr<void>> _saveTicket2Document(
//     SaveTicket2Document event, Emitter<Tickets2States> emit) async {
//   emit(Ticket2DocumentSaving());
//   try {
//     String? hashCode =
//         await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
//     String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
//     Map saveDocumentMap = {
//       "filename": event.saveDocumentMap['fileName'],
//       "ticketid": ticketId,
//       "comments": event.saveDocumentMap['comments'],
//       "userid": userId,
//       "hashcode": hashCode
//     };
//     SaveTicket2DocumentModel saveTicket2DocumentModel =
//         await _ticketsRepository.saveTicket2Document(saveDocumentMap);
//     if (saveTicket2DocumentModel.message == '1') {
//       emit(Ticket2DocumentSaved());
//     } else {
//       emit(Ticket2DocumentNotSaved(
//           errorMessage: saveTicket2DocumentModel.message));
//     }
//   } catch (e) {
//     emit(Ticket2DocumentNotSaved(errorMessage: e.toString()));
//   }
// }
//
// Future<FutureOr<void>> _updateTicket2Status(
//     UpdateTicket2Status event, Emitter<Tickets2States> emit) async {
//   emit(Ticket2StatusUpdating());
//   try {
//     String? hashCode =
//         await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
//     String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
//     Map updateStatusMap = {
//       "edt": event.edtHrs,
//       "ticketid": ticketId,
//       "userid": userId,
//       "status": event.status,
//       "completiondate": event.completionDate,
//       "hashcode": hashCode
//     };
//     if (event.status == "11" && event.edtHrs! <= 0) {
//       emit(Ticket2StatusNotUpdated(
//           errorMessage: StringConstants.kEdtShouldBeGreaterThan0));
//     } else if (event.status == '5' && event.completionDate == '') {
//       emit(Ticket2StatusNotUpdated(
//           errorMessage: StringConstants.kPleaseEnterCompletionDate));
//     } else {
//       UpdateTicket2StatusModel updateTicket2StatusModel =
//           await _ticketsRepository.updateTicket2Status(updateStatusMap);
//       if (updateTicket2StatusModel.message == '1') {
//         emit(Ticket2StatusUpdated());
//       } else {
//         emit(Ticket2StatusNotUpdated(
//             errorMessage: updateTicket2StatusModel.message));
//       }
//     }
//   } catch (e) {
//     emit(Ticket2StatusNotUpdated(errorMessage: e.toString()));
//   }
// }
//
// Future<FutureOr<void>> _saveOpenTicket2(
//     SaveOpenTicket2 event, Emitter<Tickets2States> emit) async {
//   emit(OpenTicket2Saving());
//   try {
//     String? hashCode =
//         await _customerCache.getHashCode(CacheKeys.hashcode) ?? '';
//     String? userId = await _customerCache.getUserId(CacheKeys.userId) ?? '';
//     Map openTicket2Map = {
//       "ticketid": ticketId,
//       "userid": userId,
//       "vo": event.value,
//       "hashcode": hashCode
//     };
//     if (event.value != '') {
//       OpenTicket2Model openTicket2Model =
//           await _ticketsRepository.openTicket2(openTicket2Map);
//       if (openTicket2Model.message == '1') {
//         emit(OpenTicket2Saved());
//       } else {
//         emit(OpenTicket2NotSaved(errorMessage: openTicket2Model.message));
//       }
//     } else {
//       emit(OpenTicket2NotSaved(errorMessage: StringConstants.kPleaseSelectVo));
//     }
//   } catch (e) {
//     emit(OpenTicket2NotSaved(errorMessage: e.toString()));
//   }
// }
//
// FutureOr<void> _selectVoValue(
//     SelectVoValue event, Emitter<Tickets2States> emit) {
//   emit(VoValueSelected(value: event.value, vo: event.vo));
// }
}
