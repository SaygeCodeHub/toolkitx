enum PermitSwitchingScheduleEnum {
  location,
  equipmentuid,
  operation,
  instructionreceivedbyname,
  instructionreceiveddate,
  controlengineername,
  carriedoutdate,
  carriedoutconfirmeddate,
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
      case PermitSwitchingScheduleEnum.instructionreceiveddate:
        return 'Instructed Date';
      case PermitSwitchingScheduleEnum.controlengineername:
        return 'Control Engineer';
      case PermitSwitchingScheduleEnum.carriedoutdate:
        return 'Carriedout Date';
      case PermitSwitchingScheduleEnum.carriedoutconfirmeddate:
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
      case PermitSwitchingScheduleEnum.instructionreceiveddate:
        return 'instructionreceiveddate';
      case PermitSwitchingScheduleEnum.controlengineername:
        return 'controlengineername';
      case PermitSwitchingScheduleEnum.carriedoutdate:
        return 'carriedoutdate';
      case PermitSwitchingScheduleEnum.carriedoutconfirmeddate:
        return 'carriedoutconfirmeddate';
      case PermitSwitchingScheduleEnum.safetykeynumber:
        return 'safetykeynumber';
      default:
        return '';
    }
  }
}
