import 'package:flutter/material.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class InComingListScreen extends StatelessWidget {
  const InComingListScreen({super.key});
  static const routeName = 'InComingListScreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GenericAppBar(
        title: StringConstants.kInComingInvoiceList,
      ),
    );
  }
}
