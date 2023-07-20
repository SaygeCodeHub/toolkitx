import '../data/models/modules_model.dart';

abstract class ModulesUtil {
  static String kBaseImagePath = 'assets/icons/';
  static List<ModulesModel> listModulesMode = [
    ModulesModel(
        moduleName: 'LogBook',
        moduleImage: '${kBaseImagePath}logbook.png',
        key: 'sl',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'Calendar',
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'wf_calendar',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'Calendar',
        moduleImage: '${kBaseImagePath}calendar.png',
        key: 'calendar',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'QualityManagement',
        moduleImage: '${kBaseImagePath}quality_service.png',
        key: 'qareport',
        notificationKey: 'qa'),
    ModulesModel(
        moduleName: 'Permit',
        moduleImage: '${kBaseImagePath}permit.png',
        offLineSupport: true,
        key: 'ptw',
        notificationKey: 'permit'),
    ModulesModel(
        moduleName: 'Accounting',
        moduleImage: '${kBaseImagePath}accounting.png',
        key: 'accounting',
        notificationKey: 'accounting'),
    ModulesModel(
        moduleName: 'TimeVacation',
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'timesheet',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'TimeVacation',
        moduleImage: '${kBaseImagePath}holiday.png',
        key: 'wf_timesheet',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'Incident',
        moduleImage: '${kBaseImagePath}incident.png',
        key: 'hse',
        notificationKey: 'incident'),
    ModulesModel(
        moduleName: 'ToDo',
        moduleImage: '${kBaseImagePath}to_do.png',
        key: 'todo',
        notificationKey: 'todo'),
    ModulesModel(
        moduleName: 'SafetyNotice',
        moduleImage: '${kBaseImagePath}shield.png',
        key: 'safetyNotice',
        notificationKey: 'safetynotice'),
    ModulesModel(
        moduleName: 'WorkOrder',
        moduleImage: '${kBaseImagePath}workOrder.png',
        key: 'workorder',
        notificationKey: 'workorder'),
    ModulesModel(
        moduleName: 'meetingRoom',
        moduleImage: '${kBaseImagePath}briefing.png',
        key: 'meeting',
        notificationKey: 'meeting'),
    ModulesModel(
        moduleName: 'Assets',
        moduleImage: '${kBaseImagePath}assets.png',
        key: 'eam',
        notificationKey: 'eam'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'timesheet',
        notificationKey: 'expensereport'),
    ModulesModel(
        moduleName: 'Expense',
        moduleImage: '${kBaseImagePath}expenses.png',
        key: 'wf_timesheet',
        notificationKey: 'expensereport'),
    ModulesModel(
        moduleName: 'Certificates',
        moduleImage: '${kBaseImagePath}certificate.png',
        key: 'certificates',
        notificationKey: 'certificate'),
    ModulesModel(
        moduleName: 'Checklist',
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'checklist',
        notificationKey: 'checklist'),
    ModulesModel(
        moduleName: 'Checklist',
        moduleImage: '${kBaseImagePath}checklist.png',
        key: 'wf_checklist',
        notificationKey: 'checklist'),
    ModulesModel(
        moduleName: 'Documents',
        moduleImage: '${kBaseImagePath}documents.png',
        key: 'dms',
        notificationKey: 'dms'),
    ModulesModel(
        moduleName: 'EquipmentTraceability',
        moduleImage: '${kBaseImagePath}mechanic.png',
        key: 'trace',
        notificationKey: 'et'),
    ModulesModel(
        moduleName: 'LOTO',
        moduleImage: '${kBaseImagePath}lottery.png',
        key: 'loto',
        notificationKey: 'loto'),
    ModulesModel(
        moduleName: 'Ticket',
        moduleImage: '${kBaseImagePath}ticket.png',
        key: 'tickets',
        notificationKey: 'tickets'),
    ModulesModel(
        moduleName: 'Trips',
        moduleImage: '${kBaseImagePath}trips.png',
        key: 'hf',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'Trips',
        moduleImage: '${kBaseImagePath}trips.png',
        key: 'wf_trips',
        notificationKey: ''),
    ModulesModel(
        moduleName: 'Signout',
        moduleImage: '${kBaseImagePath}trips.png',
        key: 'tracking',
        notificationKey: ''),
  ];
}
