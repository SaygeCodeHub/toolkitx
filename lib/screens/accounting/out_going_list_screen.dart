import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/accounting/widgets/out_going_list_tile_subtitle.dart';
import 'package:toolkit/screens/accounting/widgets/out_going_list_tile_title.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class OutGoingListScreen extends StatelessWidget {
  final List<Map<String, String>> outGoingListData = [
    {
      "id": "G9NCQgddxATriLDMGlq1cQ==",
      "entity": "ToolKitX GmBH",
      "client": "Iberdrola - Saint Brieuc",
      "date": "05.05.2023",
      "amount": "EUR 1,789.00"
    },
    {
      "id": "fGLj9XEzYUQ+1lz4/JymXw==",
      "entity": "Pandora-ICT GmbH",
      "client": "CFXD Wind Park - CFXD Wind Park Project",
      "date": "08.05.2023",
      "amount": "EUR 22.00"
    },
    {
      "id": "L3iN8BudPyzf64fv8MBMHw==",
      "entity": "Pandora-ICT GmbH",
      "client": "CFXD Wind Park - CFXD Wind Park Project",
      "date": "09.05.2023",
      "amount": "EUR 7,881.00"
    },
    //... add other entries here
  ];

  OutGoingListScreen({super.key});

  static const routeName = 'OutGoingListScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            const GenericAppBar(title: StringConstants.kOutGoingInvoiceList),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              CustomIconButtonRow(
                  secondaryOnPress: () {},
                  primaryOnPress: () {},
                  clearOnPress: () {}),
              const SizedBox(height: xxTinierSpacing),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: outGoingListData.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(xxTinierSpacing),
                        title: OutGoingListTileTitle(
                          data: outGoingListData[index],
                        ),
                        subtitle: OutGoingListTileSubtitle(
                            data: outGoingListData[index]),
                        onTap: () {
                          // print('Selected ID: ${data['id']}');
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: xxTinierSpacing);
                  },
                ),
              ),
            ])));
  }
}
