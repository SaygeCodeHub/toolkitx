import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/incident/fetch_permit_to_link_model.dart';
import '../../../data/models/encrypt_class.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../data/models/incident/save_incident_comments_files_model.dart';
import '../../../data/models/incident/save_incident_comments_model.dart';
import '../../../data/models/incident/saved_linked_permit_model.dart';
import '../../../data/models/pdf_generation_model.dart';
import '../../../utils/database_utils.dart';
import '../../../repositories/incident/incident_repository.dart';
import 'incident_details_event.dart';
import 'incident_details_states.dart';

class IncidentDetailsBloc
    extends Bloc<IncidentDetailsEvent, IncidentDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  int incidentTabIndex = 0;
  List savedList = [];
  String commentId = '';

  IncidentDetailsStates get initialState => const IncidentDetailsInitial();

  IncidentDetailsBloc() : super(const IncidentDetailsInitial()) {
    on<FetchIncidentDetailsEvent>(_fetchDetails);
    on<FetchPermitToLinkList>(_fetchPermitToLink);
    on<SaveLikedPermits>(_saveLinkedPermits);
    on<GenerateIncidentPDF>(_generateIncidentPDF);
    on<SaveIncidentComments>(_saveComments);
    on<SaveIncidentCommentsFiles>(_saveCommentsFiles);
  }

  FutureOr<void> _fetchDetails(FetchIncidentDetailsEvent event,
      Emitter<IncidentDetailsStates> emit) async {
    emit(const FetchingIncidentDetails());
    try {
      List popUpMenuItems = [
        DatabaseUtil.getText('AddComments'),
      ];
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashKey = await _customerCache.getClientId(CacheKeys.clientId);
      incidentTabIndex = event.initialIndex;
      IncidentDetailsModel incidentDetailsModel =
          await _incidentRepository.fetchIncidentDetails(
              event.incidentId, hashCode!, userId!, event.role);
      if (incidentDetailsModel.status == 200) {
        if (incidentDetailsModel.data!.canEdit == '1') {
          popUpMenuItems.add(DatabaseUtil.getText('EditIncident'));
        }
        if (incidentDetailsModel.data!.nextStatus == '0') {
          popUpMenuItems.add(DatabaseUtil.getText('Report'));
        }
        if (incidentDetailsModel.data!.nextStatus == '1') {
          popUpMenuItems.add(DatabaseUtil.getText('Acknowledge'));
        }
        if (incidentDetailsModel.data!.nextStatus == '2') {
          popUpMenuItems.add(DatabaseUtil.getText('DefineMitigation'));
        }
        if (incidentDetailsModel.data!.nextStatus == '3') {
          popUpMenuItems.add(DatabaseUtil.getText('ApproveMitigation'));
        }
        if (incidentDetailsModel.data!.nextStatus == '4') {
          popUpMenuItems.add(DatabaseUtil.getText('ImplementMitigation'));
        }
        if (incidentDetailsModel.data!.canResolve == '1') {
          popUpMenuItems.add(DatabaseUtil.getText('Markasresolved'));
        }
        popUpMenuItems.add(DatabaseUtil.getText('GenerateReport'));
        emit(IncidentDetailsFetched(
            incidentDetailsModel: incidentDetailsModel,
            clientId: hashKey!,
            incidentPopUpMenu: popUpMenuItems,
            showPopUpMenu: true));
      }
    } catch (e) {
      emit(const IncidentDetailsNotFetched());
    }
  }

  FutureOr<void> _generateIncidentPDF(
      GenerateIncidentPDF event, Emitter<IncidentDetailsStates> emit) async {
    try {
      emit(const GeneratingIncidentPDF());
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String aipKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      final PdfGenerationModel pdfGenerationModel =
          await _incidentRepository.generatePdf(hashCode, event.incidentId);
      String pdfLink =
          EncryptData.decryptAESPrivateKey(pdfGenerationModel.message, aipKey);
      emit(IncidentPDFGenerated(
          pdfGenerationModel: pdfGenerationModel, pdfLink: pdfLink));
    } catch (e) {
      emit(const IncidentPDFGenerationFailed());
      rethrow;
    }
  }

  FutureOr<void> _fetchPermitToLink(
      FetchPermitToLinkList event, Emitter<IncidentDetailsStates> emit) async {
    emit(FetchingPermitToLink());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? filter = "";
      FetchPermitToLinkModel permitToLinkModel = await _incidentRepository
          .fetchPermitToLink(event.pageNo, hashCode!, filter, event.incidentId);
      emit(FetchedPermitToLink(fetchPermitToLinkModel: permitToLinkModel));
    } catch (e) {
      emit(FetchPermitToLinkError());
    }
  }

  FutureOr<void> _saveLinkedPermits(
      SaveLikedPermits event, Emitter<IncidentDetailsStates> emit) async {
    emit(SavingLinkedPermits());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      Map linkedPermitMap = {
        "userid": userid,
        "incidentid": event.incidentId,
        "hashcode": hashCode,
        "permitid": event.savedPermitList
      };
      SaveLinkedPermitModel savedPermitModel =
          await _incidentRepository.saveLinkedPermit(linkedPermitMap);
      if (savedPermitModel.status == 200) {
        emit(SavedLinkedPermits(saveLinkedPermitModel: savedPermitModel));
      } else {
        emit(LinkedPermitsNotSaved(
            permitNotSavedMessage:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(FetchPermitToLinkError());
    }
  }

  FutureOr<void> _saveComments(
      SaveIncidentComments event, Emitter<IncidentDetailsStates> emit) async {
    emit(SavingIncidentComments());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      Map saveCommentMap = event.saveCommentsMap;
      if (saveCommentMap['comments'] == null ||
          saveCommentMap['comments'].isEmpty) {
        emit(IncidentCommentsNotSaved(
            commentsNotSaved: DatabaseUtil.getText('CommentsInsert')));
      } else {
        Map saveCommentsMap = {
          "userid": userid,
          "incidentid": saveCommentMap['incidentId'],
          "hashcode": hashCode,
          "status": "",
          "comments": saveCommentMap['comments'],
          "classification": ""
        };
        SaveIncidentCommentsModel saveIncidentCommentsModel =
            await _incidentRepository.saveComments(saveCommentsMap);
        if (saveIncidentCommentsModel.status == 200) {
          commentId = saveIncidentCommentsModel.message;
          emit(IncidentCommentsSaved(
              saveIncidentCommentsModel: saveIncidentCommentsModel));
          if (saveCommentMap['filenames'] != null) {
            add(SaveIncidentCommentsFiles(saveCommentsMap: saveCommentMap));
          }
        } else {
          emit(IncidentCommentsNotSaved(
              commentsNotSaved:
                  DatabaseUtil.getText('some_unknown_error_please_try_again')));
        }
      }
    } catch (e) {
      emit(IncidentCommentsNotSaved(commentsNotSaved: e.toString()));
    }
  }

  FutureOr<void> _saveCommentsFiles(SaveIncidentCommentsFiles event,
      Emitter<IncidentDetailsStates> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);
      Map sameFilesMap = event.saveCommentsMap;
      Map saveCommentsFilesMap = {
        "userid": userid,
        "incidentid": sameFilesMap['incidentId'],
        "commentid": commentId,
        "filenames": sameFilesMap['filenames'],
        "hashcode": hashCode
      };
      SaveIncidentCommentsFilesModel saveIncidentCommentsModel =
          await _incidentRepository.saveCommentsFiles(saveCommentsFilesMap);
      if (saveIncidentCommentsModel.status == 200) {
        emit(IncidentCommentsFilesSaved(
            saveIncidentCommentsModel: saveIncidentCommentsModel));
      } else {
        emit(IncidentCommentsFilesNotSaved(
            commentsFilesNotSaved:
                DatabaseUtil.getText('some_unknown_error_please_try_again')));
      }
    } catch (e) {
      emit(IncidentCommentsFilesNotSaved(commentsFilesNotSaved: e.toString()));
    }
  }
}
