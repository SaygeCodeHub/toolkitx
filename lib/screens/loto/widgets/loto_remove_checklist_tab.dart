import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../data/models/loto/loto_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';

class LotoRemoveChecklistTab extends StatelessWidget {
  const LotoRemoveChecklistTab({
    super.key, required this.data,
  });
  final LotoData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: data.removechecklistname.isEmpty ? false : true,
          child: CustomCard(
              child: ListTile(
                  title: Text(
                      data.removechecklistname,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(fontWeight: FontWeight.w400,color: AppColor.black)),
                  subtitle: InkWell(
                    onTap: () {},
                    child: Text(
                        StringConstants.kViewResponse,
                        style: Theme.of(context).textTheme.xSmall.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.deepBlue)),
                  ))),
        ),
      ],
    );
  }
}