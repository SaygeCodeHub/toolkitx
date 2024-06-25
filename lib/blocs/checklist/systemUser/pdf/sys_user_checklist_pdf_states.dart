import '../../../../data/models/checklist/systemUser/sys_user_fetch_pdf_model.dart';

abstract class FetchCheckListPdfStates {}

class FetchCheckListPdfInitial extends FetchCheckListPdfStates {}

class FetchingCheckListPdf extends FetchCheckListPdfStates {}

class PdfCheckListFetched extends FetchCheckListPdfStates {
  final GetPdfModel getPdfModel;
  String decryptedFile;

  PdfCheckListFetched({required this.getPdfModel, required this.decryptedFile});
}

class FetchCheckListPdfError extends FetchCheckListPdfStates {}
