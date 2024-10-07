import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class BankStatementListScreen extends StatelessWidget {
  const BankStatementListScreen({super.key});
  static const routeName = 'BankStatementListScreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenericAppBar(
        title: StringConstants.kBankStatementList,
      ),
    );
  }
}
