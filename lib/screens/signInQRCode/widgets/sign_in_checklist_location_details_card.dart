import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/SignInQRCode/sign_in_location_details_model.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/primary_button.dart';

class SignInCheckListLocationDetailsCard extends StatelessWidget {
  final List<Checklist> checkList;

  const SignInCheckListLocationDetailsCard({Key? key, required this.checkList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: checkList.length,
          itemBuilder: (context, index) {
            return CustomCard(
                child: Padding(
                    padding: const EdgeInsets.only(top: tinierSpacing),
                    child: ListTile(
                        onTap: () {},
                        title: Text(checkList[index].name,
                            style: Theme.of(context).textTheme.small.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.black)),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: tinierSpacing),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(checkList[index].categoryname),
                                  const SizedBox(height: tinierSpacing),
                                  Text(checkList[index].subcategoryname),
                                  const SizedBox(height: tinierSpacing),
                                  PrimaryButton(
                                      onPressed: () {},
                                      textValue: StringConstants.kAssignToMe),
                                  const SizedBox(height: tiniestSpacing),
                                ])))));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: tinierSpacing);
          }),
    );
  }
}
