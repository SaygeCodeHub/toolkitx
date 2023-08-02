import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';

class QualityManagementSiteList extends StatelessWidget {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectSiteName;

  const QualityManagementSiteList(
      {Key? key,
      required this.fetchQualityManagementMasterModel,
      required this.selectSiteName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectSite),
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
                        itemCount:
                            fetchQualityManagementMasterModel.data![0].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(fetchQualityManagementMasterModel
                                  .data![0][index].name),
                              value: fetchQualityManagementMasterModel
                                  .data![0][index].name,
                              groupValue: selectSiteName,
                              onChanged: (value) {
                                value = fetchQualityManagementMasterModel
                                    .data![0][index].name;
                                context
                                    .read<QualityManagementBloc>()
                                    .add(ReportQualityManagementSiteListChange(
                                      selectSiteName:
                                          fetchQualityManagementMasterModel
                                              .data![0][index].name,
                                    ));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
