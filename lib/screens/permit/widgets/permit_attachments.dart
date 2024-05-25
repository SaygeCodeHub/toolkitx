import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/generic_alphanumeric_generator_util.dart';
import '../../../utils/incident_view_image_util.dart';
import '../../../widgets/custom_card.dart';

class PermitAttachments extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;
  final String clientId;

  const PermitAttachments(
      {Key? key, required this.permitDetailsModel, required this.clientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: permitDetailsModel.data.tab5.length,
        itemBuilder: (context, index) {
          String files = permitDetailsModel.data.tab5[index].files;
          return CustomCard(
              child: Padding(
                  padding: const EdgeInsets.only(top: xxTinierSpacing),
                  child: ListTile(
                      title: Text(permitDetailsModel.data.tab5[index].name,
                          style: Theme.of(context).textTheme.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.mediumBlack)),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(top: xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(permitDetailsModel.data.tab5[index].type),
                                const SizedBox(height: xxTinierSpacing),
                                ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        ViewImageUtil.viewImageList(files)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          splashColor: AppColor.transparent,
                                          highlightColor: AppColor.transparent,
                                          onTap: () {
                                            launchUrlString(
                                                '${ApiConstants.viewDocBaseUrl}${ViewImageUtil.viewImageList(files)[index]}&code=${RandomValueGeneratorUtil.generateRandomValue(clientId)}',
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: xxxTinierSpacing),
                                            child: Text(
                                                ViewImageUtil.viewImageList(
                                                    files)[index],
                                                style: const TextStyle(
                                                    color: AppColor.deepBlue)),
                                          ));
                                    }),
                                const SizedBox(height: xxTiniestSpacing)
                              ])),
                      trailing:
                          const Icon(Icons.attach_file, size: kIconSize))));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: xxTinierSpacing);
        });
  }
}
