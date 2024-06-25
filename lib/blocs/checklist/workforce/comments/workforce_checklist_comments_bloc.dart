import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/comments/workforce_checklist_comments_events.dart';
import 'package:toolkit/blocs/checklist/workforce/comments/workforce_checklist_comments_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/workforce/workforce_fetch_comment_model.dart';
import '../../../../data/models/checklist/workforce/workforce_save_comment_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/workforce/workforce_repository.dart';

class WorkForceCheckListCommentBloc extends Bloc<
    WorkForceCheckListCommentsEvent, WorkForceCheckListCommentStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map allDataForChecklistMap = {};
  String questionResponseId = '';

  WorkForceCheckListCommentBloc() : super(CheckListCommentsInitial()) {
    on<CheckListFetchComment>(_fetchQuestionComments);
    on<CheckListSaveComment>(_saveQuestionComments);
  }

  FutureOr<void> _fetchQuestionComments(CheckListFetchComment event,
      Emitter<WorkForceCheckListCommentStates> emit) async {
    emit(CheckListFetchingComment());
    try {
      allDataForChecklistMap["questionResponseId"] = event.questionResponseId;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      GetQuestionCommentsModel getQuestionCommentsModel =
          await _workForceRepository.fetchComment(
              allDataForChecklistMap["questionResponseId"], hashCode);
      emit(CheckListCommentFetched(
          getQuestionCommentsModel: getQuestionCommentsModel));
    } catch (e) {
      emit(CheckListCommentNotFetched(
          quesResponseId: allDataForChecklistMap["questionResponseId"]));
    }
  }

  FutureOr<void> _saveQuestionComments(CheckListSaveComment event,
      Emitter<WorkForceCheckListCommentStates> emit) async {
    emit(CheckListSavingComment());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.saveQuestionCommentMap["comments"] == null ||
          event.saveQuestionCommentMap["comments"].toString().trim().isEmpty) {
        emit(CheckListCommentNotSaved(message: StringConstants.kSelectComment));
      } else {
        Map saveQuestionCommentMap = {
          "id": allDataForChecklistMap["userId"],
          "queresponseid": allDataForChecklistMap["questionResponseId"],
          "comments": event.saveQuestionCommentMap["comments"],
          "filenames": event.saveQuestionCommentMap["filenames"],
          "hashcode": hashCode
        };
        SaveQuestionCommentsModel saveQuestionCommentsModel =
            await _workForceRepository.saveComment(saveQuestionCommentMap);
        emit(CheckListCommentSaved(
            saveQuestionCommentsModel: saveQuestionCommentsModel));
      }
    } catch (e) {
      emit(CheckListCommentNotSaved(message: e.toString()));
    }
  }
}
