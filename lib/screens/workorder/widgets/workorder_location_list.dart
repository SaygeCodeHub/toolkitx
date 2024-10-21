import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class WorkOrderLocationList extends StatelessWidget {
  final List<List<WorkOrderMasterDatum>> data;
  final String locationId;
  final Map workOrderDetailsMap;

  const WorkOrderLocationList(
      {super.key,
      required this.data,
      required this.locationId,
      required this.workOrderDetailsMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectLocation),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin, right: leftRightMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data[0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(data[0][index].location),
                              value: data[0][index].id.toString(),
                              groupValue: locationId,
                              onChanged: (value) {
                                workOrderDetailsMap['locationid'] =
                                    data[0][index].id.toString();
                                context.read<WorkOrderTabDetailsBloc>().add(
                                    SelectWorkOrderLocationOptions(
                                        locationId:
                                            data[0][index].id.toString(),
                                        locationName: data[0][index].location));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
