import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/qualityManagement/qm_bloc.dart';
import '../../../blocs/qualityManagement/qm_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/qualityManagement/fetch_qm_master_model.dart';
import '../../../widgets/generic_app_bar.dart';

class QualityManagementContractorList extends StatelessWidget {
  final FetchQualityManagementMasterModel fetchQualityManagementMasterModel;
  final String selectContractorId;
  final String selectContractorName;

  const QualityManagementContractorList(
      {Key? key,
      required this.fetchQualityManagementMasterModel,
      required this.selectContractorId,
      required this.selectContractorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kSelectContractor),
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
                            fetchQualityManagementMasterModel.data![5].length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColor.deepBlue,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(fetchQualityManagementMasterModel
                                  .data![5][index].groupName),
                              value: fetchQualityManagementMasterModel
                                  .data![5][index].groupId!
                                  .toString(),
                              groupValue: selectContractorId,
                              onChanged: (value) {
                                context.read<QualityManagementBloc>().add(
                                    ReportNewQualityManagementContractorListChange(
                                        selectContractorName:
                                            fetchQualityManagementMasterModel
                                                .data![5][index].groupName,
                                        selectContractorId:
                                            fetchQualityManagementMasterModel
                                                .data![5][index].groupId!
                                                .toString()));
                                Navigator.pop(context);
                              });
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
