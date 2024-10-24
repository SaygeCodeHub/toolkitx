import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class AccountingUtilModel {
  final String accountingModuleName;
  final IconData icon;

  AccountingUtilModel({required this.accountingModuleName, required this.icon});
}

List<AccountingUtilModel> accounting = [
  AccountingUtilModel(
      accountingModuleName: StringConstants.kOutGoingInvoice,
      icon: Icons.output_outlined),
  AccountingUtilModel(
      accountingModuleName: StringConstants.kInComingInvoice,
      icon: Icons.install_mobile_rounded),
  AccountingUtilModel(
      accountingModuleName: StringConstants.kBankStatement,
      icon: Icons.account_balance_wallet_outlined),
];
