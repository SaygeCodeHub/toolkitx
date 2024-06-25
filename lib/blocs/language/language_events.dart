abstract class LanguageEvent {}

class FetchLanguages extends LanguageEvent {
  final bool isFromProfile;

  FetchLanguages({required this.isFromProfile});
}

class FetchLanguageKeys extends LanguageEvent {
  final String languageId;
  final bool isFromProfile;
  final String syncDate;

  FetchLanguageKeys({
    this.syncDate = '',
    required this.isFromProfile,
    required this.languageId,
  });
}

class CheckNewLanguageKeys extends LanguageEvent {
  final String languageId;
  final String syncDate;

  CheckNewLanguageKeys({required this.languageId, required this.syncDate});
}
