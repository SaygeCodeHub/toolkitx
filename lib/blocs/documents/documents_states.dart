import 'package:equatable/equatable.dart';

import '../../data/models/documents/documents_list_model.dart';

class DocumentsStates extends Equatable {
  const DocumentsStates();

  @override
  List<Object?> get props => [];
}

class DocumentsInitial extends DocumentsStates {
  const DocumentsInitial();
}

class FetchingDocumentsList extends DocumentsStates {
  const FetchingDocumentsList();
}

class DocumentsListFetched extends DocumentsStates {
  final DocumentsListModel documentsListModel;

  const DocumentsListFetched({required this.documentsListModel});

  @override
  List<Object?> get props => [documentsListModel];
}

class DocumentsListError extends DocumentsStates {
  final String message;

  const DocumentsListError({required this.message});
}
