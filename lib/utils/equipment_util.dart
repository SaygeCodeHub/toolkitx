import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class ModulesModel {
  final String equipmentModuleName;
  final IconData icon;

  ModulesModel({required this.equipmentModuleName, required this.icon});
}

List<ModulesModel> equipment = [
  ModulesModel(
      equipmentModuleName: StringConstants.kScanEquipment,
      icon: Icons.qr_code_scanner),
  ModulesModel(
      equipmentModuleName: StringConstants.kTransferEquipment,
      icon: Icons.compare_arrows),
  ModulesModel(
      equipmentModuleName: StringConstants.kSearchEquipment,
      icon: Icons.search_outlined),
  ModulesModel(
      equipmentModuleName: StringConstants.kViewMyRequest,
      icon: Icons.visibility_outlined),
];
