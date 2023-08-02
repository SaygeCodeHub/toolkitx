import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../../widgets/generic_app_bar.dart';

class QualityManagementLocationList extends StatelessWidget {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectLocationName;

  const QualityManagementLocationList(
      {Key? key,
      required this.fetchQualityManagementMasterModel,
      required this.selectLocationName})
      : super(key: key);

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
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            fetchQualityManagementMasterModel.data![1].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(fetchQualityManagementMasterModel
                                  .data![1][index].location),
                              value: fetchQualityManagementMasterModel
                                  .data![1][index].location,
                              groupValue: selectLocationName,
                              onChanged: (value) {
                                value = fetchQualityManagementMasterModel
                                    .data![1][index].location;
                                context.read<QualityManagementBloc>().add(
                                        ReportNewQualityManagementLocationChange(
                                      selectLocationName:
                                          fetchQualityManagementMasterModel
                                              .data![1][index].location,
                                    ));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
