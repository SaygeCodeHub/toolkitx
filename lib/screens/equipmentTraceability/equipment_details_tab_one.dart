import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/equipmentTraceability/fetch_search_equipment_details_model.dart';

import '../../configs/app_spacing.dart';

class EquipmentDetailsTabOne extends StatelessWidget {
  final int tabIndex;
  final SearchEquipmentDetailsData data;

  const EquipmentDetailsTabOne(
      {super.key, required this.tabIndex, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Equipment Name",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.equipmentname,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Equipment No",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.equipmentno,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Article No",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.articleno,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Email Address",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.emailAddress,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Equipment Code",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.barcode,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Position",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text('${data.positionname} ${data.warehousename}',
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Technical Position No",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.techPositionno,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Technical Position Name",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.techPositionname,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Equipment Role",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.rolename,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Equipment Type",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.machinetype,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Equipment Sub-Type",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.subtypetext,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
              Text("Description",
                  style: Theme.of(context).textTheme.smallTextBlack),
              const SizedBox(height: tiniestSpacing),
              Text(data.description,
                  style: Theme.of(context).textTheme.smallTextGrey),
              const SizedBox(height: xxxSmallestSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
