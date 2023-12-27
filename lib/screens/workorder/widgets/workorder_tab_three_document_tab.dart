import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workorder/workOrderTabsDetails/workorder_tab_details_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/workorder/workOrderTabsDetails/workorder_tab_details_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/workorder/fetch_workorder_details_model.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/android_pop_up.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import 'workorder_view_document.dart';

class WorkOrderTabThreeDocumentTab extends StatelessWidget {
  final WorkOrderDetailsData data;
  final String clientId;

  const WorkOrderTabThreeDocumentTab(
      {Key? key, required this.data, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.documents.isNotEmpty,
      replacement: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
        child: Center(
            child: Text(StringConstants.kNoDocuments,
                style: Theme.of(context).textTheme.medium)),
      ),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.documents.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(xxxTinierSpacing),
                    title: Text(data.documents[index].name,
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.black,
                            overflow: TextOverflow.ellipsis)),
                    trailing: CustomIconButton(
                        icon: Icons.delete,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AndroidPopUp(
                                    titleValue:
                                        DatabaseUtil.getText('DeleteRecord'),
                                    contentValue: '',
                                    onPrimaryButton: () {
                                      context
                                          .read<WorkOrderTabDetailsBloc>()
                                          .add(WorkOrderDeleteDocument(
                                              docId: data.documents[index].id));
                                      Navigator.pop(context);
                                    });
                              });
                        },
                        size: kEditAndDeleteIconTogether),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: tinierSpacing),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(data.documents[index].type),
                              const SizedBox(height: tinierSpacing),
                              Visibility(
                                  visible: data.documents[index].files != '',
                                  child: WorkOrderViewDocument(
                                      documents: data.documents[index],
                                      clientId: clientId)),
                            ]))));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
