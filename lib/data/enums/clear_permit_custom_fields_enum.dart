import 'package:toolkit/utils/constants/string_constants.dart';

enum ClearPermitCustomFieldsEnum {
  allGear(type: StringConstants.kAllGearPermit),
  keySafeNo(type: StringConstants.kKeySafeNo),
  earthingScheduleNo(type: StringConstants.kEarthingScheduleNo),
  selectedPersonReport(type: StringConstants.kSelectedPersonReport),
  portableDrainEarth(type: StringConstants.kPortableDrainEarth),
  circuitIdentificationFlag(type: StringConstants.kCircuitIdentificationFlag),
  circuitIdentificationWristlets(
      type: StringConstants.kCircuitIdentificationWristlets),
  singleLineDiagram(type: StringConstants.kSingleLineDiagram),
  pID(type: StringConstants.kPID),
  accessKeys(type: StringConstants.kAccessKeys),
  other(type: StringConstants.kOther);

  const ClearPermitCustomFieldsEnum({required this.type});

  final String type;
}
