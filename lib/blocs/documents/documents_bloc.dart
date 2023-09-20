import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../data/models/documents/documents_list_model.dart';
import '../../di/app_module.dart';
import '../../repositories/documents/documents_repository.dart';
import 'documents_events.dart';
import 'documents_states.dart';

class DocumentsBloc extends Bloc<DocumentsEvents, DocumentsStates> {
  final DocumentsRepository _documentsRepository = getIt<DocumentsRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  String roleId = '';
  Map filters = {};
  bool docListReachedMax = false;
  List<DocumentsListDatum> documentsListDatum = [];

  DocumentsStates get initialState => const DocumentsInitial();

  DocumentsBloc() : super(const DocumentsInitial()) {
    on<GetDocumentsList>(_getDocumentsList);
  }

  Future<void> _getDocumentsList(
      GetDocumentsList event, Emitter<DocumentsStates> emit) async {
    try {
      emit(const FetchingDocumentsList());
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      if (!docListReachedMax) {
        if (event.isFromHome == true) {
          filters = {};
          DocumentsListModel documentsListModel =
              await _documentsRepository.getDocumentsList(userId.toString(),
                  hashCode.toString(), {}, roleId, event.page);
          documentsListDatum.addAll(documentsListModel.data);
          docListReachedMax = documentsListModel.data.isEmpty;
          emit(DocumentsListFetched(documentsListModel: documentsListModel));
        } else {
          DocumentsListModel documentsListModel =
              await _documentsRepository.getDocumentsList(userId.toString(),
                  hashCode.toString(), filters, roleId, event.page);
          documentsListDatum.addAll(documentsListModel.data);
          docListReachedMax = documentsListModel.data.isEmpty;
          emit(DocumentsListFetched(documentsListModel: documentsListModel));
        }
      }
    } catch (e) {
      emit(DocumentsListError(message: e.toString()));
    }
  }
}
