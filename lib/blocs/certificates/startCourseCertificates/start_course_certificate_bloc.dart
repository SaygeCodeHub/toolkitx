import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/models/certificates/finish_quiz_certificate_model.dart';
import 'package:toolkit/data/models/certificates/get_course_certificate_model.dart';
import 'package:toolkit/data/models/certificates/update_user_track_model.dart';
import 'package:toolkit/data/models/certificates/get_quiz_questions_model.dart';
import 'package:toolkit/data/models/certificates/save_question_answer.dart';
import 'package:toolkit/data/models/certificates/start_quiz_model.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/certificates/get_notes_certificate_model.dart';
import '../../../data/models/certificates/get_topic_certificate_model.dart';
import '../../../data/models/certificates/get_workforce_quiz_model.dart';
import '../../../di/app_module.dart';
import '../../../repositories/certificates/certificates_repository.dart';

part 'start_course_certificate_event.dart';

part 'start_course_certificate_state.dart';

class StartCourseCertificateBloc
    extends Bloc<StartCourseCertificateEvent, StartCourseCertificateState> {
  final CertificateRepository _certificateRepository =
      getIt<CertificateRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String certificateId = '';

  StartCourseCertificateState get initialState =>
      StartCourseCertificateInitial();
  String answerId = '';
  String courseId = '';

  StartCourseCertificateBloc() : super(StartCourseCertificateInitial()) {
    on<GetCourseCertificate>(_getCourseCertificate);
    on<GetTopicCertificate>(_getTopicCertificate);
    on<GetNotesCertificate>(_getNotesCertificate);
    on<UpdateUserTrack>(_updateUserTrack);
    on<GetWorkforceQuiz>(_getWorkforceQuiz);
    on<GetQuizQuestions>(_getQuizQuestions);
    on<SelectedQuizAnswerEvent>(_selectQuizAnswer);
    on<SaveQuizQuestionAnswer>(_saveQuestionAnswer);
    on<SubmitCertificateQuiz>(_submitCertificateQuiz);
    on<StartCertificateQuiz>(_startCertificateQuiz);
  }

  Future<FutureOr<void>> _getCourseCertificate(GetCourseCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetCourseCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      certificateId = event.certificateId;
      GetCourseCertificateModel getCourseCertificateModel =
          await _certificateRepository.getCourseCertificates(
              hashCode!, event.certificateId);
      if (getCourseCertificateModel.status == 200) {
        emit(GetCourseCertificateFetched(
          getCourseCertificateModel: getCourseCertificateModel,
        ));
      }
    } catch (e) {
      emit(GetCourseCertificateError(getCourseError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getTopicCertificate(GetTopicCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetTopicCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      GetTopicCertificateModel getTopicCertificateModel =
          await _certificateRepository.getTopicCertificates(
              hashCode!, userId!, event.courseId);
      courseId = event.courseId;
      if (getTopicCertificateModel.status == 200) {
        emit(GetTopicCertificateFetched(
            getTopicCertificateModel: getTopicCertificateModel));
      }
    } catch (e) {
      emit(GetTopicCertificateError(getTopicError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getNotesCertificate(GetNotesCertificate event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(FetchingGetNotesCertificate());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? clientId = await _customerCache.getClientId(CacheKeys.clientId);
      FetchGetNotesModel fetchGetNotesModel =
          await _certificateRepository.getNotesCertificates(
              hashCode!, userId!, event.topicId, event.pageNo);
      if (fetchGetNotesModel.status == 200) {
        emit(GetNotesCertificateFetched(
            fetchGetNotesModel: fetchGetNotesModel, clientId: clientId!));
      } else {
        emit(GetNotesCertificateError(
            getNotesError: fetchGetNotesModel.message));
      }
    } catch (e) {
      emit(GetNotesCertificateError(getNotesError: e.toString()));
    }
  }

  Future<FutureOr<void>> _updateUserTrack(
      UpdateUserTrack event, Emitter<StartCourseCertificateState> emit) async {
    emit(UserTrackUpdating());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userid = await _customerCache.getUserId(CacheKeys.userId);

      Map userTrackMap = {
        "idm": event.idm,
        "hashcode": hashCode,
        "workforceid": userid,
        "noteid": event.noteId,
        "certificateid": event.certificateId
      };

      UpdateUserTrackModel updateUserTrackModel =
          await _certificateRepository.updateUserTrackRepo(userTrackMap);
      if (updateUserTrackModel.status == 200) {
        emit(UserTrackUpdated(updateUserTrackModel: updateUserTrackModel));
      } else {
        emit(UserTrackUpdateError(error: updateUserTrackModel.message));
      }
    } catch (e) {
      emit(UserTrackUpdateError(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _getWorkforceQuiz(
      GetWorkforceQuiz event, Emitter<StartCourseCertificateState> emit) async {
    emit(WorkforceQuizFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);

      GetWorkforceQuizModel getWorkforceQuizModel = await _certificateRepository
          .getWorkforceQuiz(hashCode!, userId!, event.quizId);
      if (getWorkforceQuizModel.status == 200) {
        emit(
            WorkforceQuizFetched(getWorkforceQuizModel: getWorkforceQuizModel));
      }
    } catch (e) {
      emit(WorkforceQuizError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _getQuizQuestions(
      GetQuizQuestions event, Emitter<StartCourseCertificateState> emit) async {
    emit(QuizQuestionsFetching());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      GetQuizQuestionsModel getQuizQuestionsModel = await _certificateRepository
          .getQuizQuestions(hashCode!, event.pageNo, event.workforcequizId);

      if (getQuizQuestionsModel.status == 200) {
        emit(QuizQuestionsFetched(
            getQuizQuestionsModel: getQuizQuestionsModel, answerId: ''));
      }
    } catch (e) {
      emit(QuizQuestionsError(getError: e.toString()));
    }
  }

  FutureOr<void> _selectQuizAnswer(SelectedQuizAnswerEvent event,
      Emitter<StartCourseCertificateState> emit) {
    emit(QuizQuestionsFetched(
        getQuizQuestionsModel: event.getQuizQuestionsModel,
        answerId: event.answerId));
  }

  Future<FutureOr<void>> _saveQuestionAnswer(SaveQuizQuestionAnswer event,
      Emitter<StartCourseCertificateState> emit) async {
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      Map questionAnswerMap = {
        "idm": event.questionAnswerMap["idm"],
        "hashcode": hashCode,
        "workforcequizid": event.questionAnswerMap["workforcequizid"],
        "answer": event.questionAnswerMap["answer"],
        "questionid": event.questionAnswerMap["questionid"]
      };
      SaveQuestionAnswerModel saveQuestionAnswerModel =
          await _certificateRepository.saveQuestionAnswer(questionAnswerMap);
      if (saveQuestionAnswerModel.status == 200) {
        emit(QuizQuestionAnswerSaved(
            saveQuestionAnswerModel: saveQuestionAnswerModel));
      }
    } catch (e) {
      emit(QuizQuestionAnswerError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _submitCertificateQuiz(SubmitCertificateQuiz event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(CertificateQuizSubmitting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map finishQuizMap = {
        "idm": event.finishQuizMap["idm"],
        "hashcode": hashCode,
        "workforcequizid": event.finishQuizMap["workforcequizid"],
        "answer": event.finishQuizMap["answer"],
        "questionid": event.finishQuizMap["questionid"],
        "workforceid": userId,
        "quizid": event.finishQuizMap["quizid"],
        "certificateid": event.finishQuizMap["certificateid"]
      };
      FinishQuizCertificateModel finishQuizCertificateModel =
          await _certificateRepository.finishQuizCertificate(finishQuizMap);
      if (finishQuizCertificateModel.status == 200) {
        emit(CertificateQuizSubmitted(
            finishQuizCertificateModel: finishQuizCertificateModel));
      }
    } catch (e) {
      emit(CertificateQuizSubmitError(getError: e.toString()));
    }
  }

  Future<FutureOr<void>> _startCertificateQuiz(StartCertificateQuiz event,
      Emitter<StartCourseCertificateState> emit) async {
    emit(CertificateQuizSubmitting());
    try {
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      Map startQuizMap = {
        "quizid": event.quizId,
        "workforceid": userId,
        "hashcode": hashCode
      };
      StartQuizModel startQuizModel =
          await _certificateRepository.startQuiz(startQuizMap);
      if (startQuizModel.status == 200) {
        emit(CertificateQuizStarted(startQuizModel: startQuizModel));
      }
    } catch (e) {
      emit(CertificateQuizNotStarted(getError: e.toString()));
    }
  }
}
