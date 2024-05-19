import 'package:toolkit/utils/constants/string_constants.dart';

enum PermitCustomFieldsTitleEnum {
  keySafeNo(type: StringConstants.kKeySafeNo),
  keySafeKeyNo(type: StringConstants.kKeySafeKeyNo),
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

  const PermitCustomFieldsTitleEnum({required this.type});

  final String type;
}
