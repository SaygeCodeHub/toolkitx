import 'package:toolkit/utils/constants/string_constants.dart';

class ModulesModel {
  final String equipmentModuleName;

  ModulesModel({required this.equipmentModuleName});
}

List<ModulesModel> equipment = [
  ModulesModel(equipmentModuleName: StringConstants.kScanEquipment),
  ModulesModel(equipmentModuleName: StringConstants.kTransferEquipment),
  ModulesModel(equipmentModuleName: StringConstants.kSearchEquipment),
  ModulesModel(equipmentModuleName: StringConstants.kViewMyEquipment),
];
