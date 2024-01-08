import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/data/models/permit/all_permits_model.dart';
import 'package:toolkit/repositories/SignInQRCode/signin_repository_impl.dart';
import 'package:toolkit/repositories/assets/assets_repository.dart';
import 'package:toolkit/repositories/certificates/certificates_repository.dart';
import 'package:toolkit/repositories/certificates/certificates_repository_impl.dart';
import 'package:toolkit/repositories/documents/documents_repository.dart';
import 'package:toolkit/repositories/documents/documents_repository_impl.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo.dart';
import 'package:toolkit/repositories/equipmentTraceability/equipment_traceability_repo_impl.dart';
import 'package:toolkit/repositories/incident/incident_repository.dart';
import 'package:toolkit/repositories/incident/incident_repository_impl.dart';
import 'package:toolkit/repositories/location/location_repository.dart';
import 'package:toolkit/repositories/location/location_repository_impl.dart';
import 'package:toolkit/repositories/login/login_repository_impl.dart';
import 'package:toolkit/repositories/profile/profile_repository_impl.dart';
import '../repositories/LogBook/logbook_repository.dart';
import '../repositories/LogBook/logbook_repository_impl.dart';
import '../repositories/SignInQRCode/signin_repository.dart';
import '../repositories/assets/assets_repository_impl.dart';
import '../repositories/calendar/calendar_repository.dart';
import '../repositories/calendar/calendar_repository_impl.dart';
import '../repositories/checklist/systemUser/sys_user_checklist_repository.dart';
import '../repositories/checklist/systemUser/sys_user_checklist_repository_impl.dart';
import '../repositories/checklist/workforce/workforce_repository.dart';
import '../repositories/checklist/workforce/workforce_repository_impl.dart';
import '../repositories/expense/expense_repository.dart';
import '../repositories/expense/expense_repository_impl.dart';
import '../repositories/leavesAndHolidays/leaves_and_holidays_repository.dart';
import '../repositories/leavesAndHolidays/leaves_and_holidays_repository_impl.dart';
import '../repositories/loto/loto_repository.dart';
import '../repositories/loto/loto_repository_impl.dart';
import '../repositories/permit/permit_repository.dart';
import '../repositories/permit/permit_repository_impl.dart';
import '../data/cache/customer_cache.dart';
import '../repositories/client/client_repository.dart';
import '../repositories/client/client_repository_impl.dart';
import '../repositories/language/language_repository.dart';
import '../repositories/language/language_repository_impl.dart';
import '../repositories/login/login_repository.dart';
import '../repositories/profile/profile_repository.dart';
import '../repositories/qualityManagement/qm_repository.dart';
import '../repositories/qualityManagement/qm_repository_impl.dart';
import '../repositories/safetyNotice/safety_notice_repository.dart';
import '../repositories/safetyNotice/safety_notice_repository_impl.dart';
import '../repositories/timeZone/time_zone_repository.dart';
import '../repositories/timeZone/time_zone_repository_impl.dart';
import '../repositories/todo/todo_repository.dart';
import '../repositories/todo/todo_repository_impl.dart';
import '../repositories/uploadImage/upload_image_repository.dart';
import '../repositories/uploadImage/upload_image_repository_impl.dart';
import '../repositories/workorder/workorder_reposiotry.dart';
import '../repositories/workorder/workorder_repository_impl.dart';

final getIt = GetIt.instance;

configurableDependencies() {
  getIt.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  getIt.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl());
  getIt.registerLazySingleton<PermitRepository>(() => PermitRepositoryImpl());
  getIt.registerLazySingleton<AllPermitDatum>(() => AllPermitDatum());
  getIt.registerLazySingleton<CustomerCache>(
      () => CustomerCache(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TimeZoneRepository>(
      () => TimeZoneRepositoryImpl());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
  getIt.registerLazySingleton<WorkForceRepository>(
      () => WorkforceChecklistRepositoryImpl());
  getIt.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  getIt.registerLazySingleton<SysUserCheckListRepository>(
      () => SysUserCheckListRepositoryImpl());
  getIt.registerLazySingleton<UploadImageRepository>(
      () => UploadImageRepositoryImpl());
  getIt.registerLazySingleton<IncidentRepository>(
      () => IncidentRepositoryImpl());
  getIt.registerLazySingleton<LogbookRepository>(() => LogbookRepositoryImpl());
  getIt.registerLazySingleton<ToDoRepository>(() => ToDoRepositoryImpl());
  getIt.registerLazySingleton<LeavesAndHolidaysRepository>(
      () => LeavesAndHolidaysRepositoryImpl());
  getIt.registerLazySingleton<QualityManagementRepository>(
      () => QualityManagementRepositoryImpl());
  getIt.registerLazySingleton<SignInRepository>(() => SignInImpl());
  getIt.registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl());
  getIt.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl());
  getIt.registerLazySingleton<WorkOrderRepository>(
      () => WorkOrderRepositoryImpl());
  getIt.registerLazySingleton<LotoRepository>(() => LotoRepositoryImpl());
  getIt.registerLazySingleton<CertificateRepository>(
      () => CertificateRepositoryImpl());
  getIt.registerLazySingleton<DocumentsRepository>(
      () => DocumentsRepositoryImpl());
  getIt.registerLazySingleton<SafetyNoticeRepository>(
      () => SafetyNoticeRepositoryImpl());
  getIt.registerLazySingleton<AssetsRepository>(() => AssetsRepositoryImpl());
  getIt.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl());
  getIt.registerLazySingleton<EquipmentTraceabilityRepo>(
      () => EquipmentTraceabilityRepoImpl());
}
