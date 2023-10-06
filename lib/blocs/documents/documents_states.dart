import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/documents/document_master_model.dart';
import 'package:toolkit/data/models/documents/document_roles_model.dart';

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

class FetchingDocumentRoles extends DocumentsStates {
  const FetchingDocumentRoles();
}

class DocumentRolesFetched extends DocumentsStates {
  final DocumentRolesModel documentRolesModel;
  final String? roleId;

  const DocumentRolesFetched(
      {required this.roleId, required this.documentRolesModel});
}

class CouldNotFetchDocumentRoles extends DocumentsStates {
  const CouldNotFetchDocumentRoles();
}

class DocumentRoleSelected extends DocumentsStates {
  const DocumentRoleSelected();
}

class FetchingDocumentMaster extends DocumentsStates {}

class DocumentMasterFetched extends DocumentsStates {
  final FetchDocumentMasterModel fetchDocumentMasterModel;

  const DocumentMasterFetched({required this.fetchDocumentMasterModel});
}

class DocumentMasterError extends DocumentsStates {
  final String fetchError;

  const DocumentMasterError({required this.fetchError});
}

class DocumentStatusFilterSelected extends DocumentsStates {
  final String selectedIndex;

  const DocumentStatusFilterSelected({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

class DocumentTypeFilterSelected extends DocumentsStates {
  final String selectedType;

  const DocumentTypeFilterSelected({required this.selectedType});

  @override
  List<Object?> get props => [selectedType];
}