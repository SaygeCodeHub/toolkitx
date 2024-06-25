import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/pdf/sys_user_checklist_pdf_events.dart';
import 'package:toolkit/blocs/checklist/systemUser/pdf/sys_user_checklist_pdf_states.dart';
import 'package:toolkit/data/models/encrypt_class.dart';
import '../../../../data/cache/cache_keys.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';
import '../../../../di/app_module.dart';
import '../../../../repositories/checklist/systemUser/sys_user_checklist_repository.dart';

class FetchCheckListPdfBloc
    extends Bloc<FetchCheckListPdfEvent, FetchCheckListPdfStates> {
  final SysUserCheckListRepository _sysUserCheckListRepository =
      getIt<SysUserCheckListRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  FetchCheckListPdfStates get initialState => FetchCheckListPdfInitial();

  FetchCheckListPdfBloc() : super(FetchCheckListPdfInitial()) {
    on<FetchCheckListPdfEvent>(_fetchPdf);
  }

  FutureOr<void> _fetchPdf(FetchCheckListPdfEvent event,
      Emitter<FetchCheckListPdfStates> emit) async {
    emit(FetchingCheckListPdf());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      String apiKey = (await _customerCache.getApiKey(CacheKeys.apiKey))!;
      GetPdfModel getPdfModel = await _sysUserCheckListRepository
          .fetchCheckListPdf(event.responseId, hashCode);
      var decrypted =
          EncryptData.decryptAESPrivateKey(getPdfModel.message, apiKey);
      emit(PdfCheckListFetched(
          getPdfModel: getPdfModel, decryptedFile: decrypted));
    } catch (e) {
      emit(FetchCheckListPdfError());
    }
  }
}
