enum PermitSwitchingScheduleEnum {
  location,
  equipmentuid,
  operation,
  instructionreceivedbyname,
  instructionreceiveddatetime,
  controlengineername,
  carriedoutdatetime,
  carriedoutconfirmeddatetime,
  safetykeynumber
}

extension PermitSwitchingScheduleEnumExtension on PermitSwitchingScheduleEnum {
  String get value {
    switch (this) {
      case PermitSwitchingScheduleEnum.location:
        return 'Location';
      case PermitSwitchingScheduleEnum.equipmentuid:
        return 'Equipment uid';
      case PermitSwitchingScheduleEnum.operation:
        return 'Operation';
      case PermitSwitchingScheduleEnum.instructionreceivedbyname:
        return 'Instruction Received By';
      case PermitSwitchingScheduleEnum.instructionreceiveddatetime:
        return 'Instructed Date';
      case PermitSwitchingScheduleEnum.controlengineername:
        return 'Control Engineer';
      case PermitSwitchingScheduleEnum.carriedoutdatetime:
        return 'Carriedout Date';
      case PermitSwitchingScheduleEnum.carriedoutconfirmeddatetime:
        return 'Carriedout Confirmed Date';
      case PermitSwitchingScheduleEnum.safetykeynumber:
        return 'Safety Key Number';
      default:
        return '';
    }
  }

  String get jsonKey {
    switch (this) {
      case PermitSwitchingScheduleEnum.location:
        return 'location';
      case PermitSwitchingScheduleEnum.equipmentuid:
        return 'equipmentuid';
      case PermitSwitchingScheduleEnum.operation:
        return 'operation';
      case PermitSwitchingScheduleEnum.instructionreceivedbyname:
        return 'instructionreceivedbyname';
      case PermitSwitchingScheduleEnum.instructionreceiveddatetime:
        return 'instructionreceiveddatetime';
      case PermitSwitchingScheduleEnum.controlengineername:
        return 'controlengineername';
      case PermitSwitchingScheduleEnum.carriedoutdatetime:
        return 'carriedoutdatetime';
      case PermitSwitchingScheduleEnum.carriedoutconfirmeddatetime:
        return 'carriedoutconfirmeddatetime';
      case PermitSwitchingScheduleEnum.safetykeynumber:
        return 'safetykeynumber';
      default:
        return '';
    }
  }
}
