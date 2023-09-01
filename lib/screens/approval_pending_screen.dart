import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../configs/app_color.dart';
import '../configs/app_dimensions.dart';
import '../configs/app_spacing.dart';

class ApprovalPendingScreen extends StatelessWidget {
  static const routeName = 'ApprovalPendingScreen';
  const ApprovalPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: xxxSmallestSpacing,
            right: xxxSmallestSpacing,
            top: xxxSmallestSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bench Test',
                style: Theme.of(context).textTheme.large.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.black)),
            const SizedBox(
              height: tinierSpacing,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColor.lightGrey)),
              child: Padding(
                padding: const EdgeInsets.all(tiniestSpacing),
                child: Text('Approval Pending',
                    style: Theme.of(context).textTheme.xxSmall.copyWith(
                        fontWeight: FontWeight.bold, color: AppColor.grey)),
              ),
            ),
            const SizedBox(
              height: smallerSpacing,
            ),
            Text('Last Uploaded : ',
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.mediumBlack)),
            const SizedBox(
              height: tinierSpacing,
            ),
            Row(
              children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(
                  width: tinierSpacing,
                ),
                Text('29.08.2023 - 29.08.2023',
                    style: Theme.of(context).textTheme.xxSmall.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.mediumBlack)),
              ],
            ),
            const SizedBox(
              height: smallerSpacing,
            ),
            Text('View Certificate : ',
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.mediumBlack)),
            const SizedBox(
              height: tinierSpacing,
            ),
            Image.asset('assets/icons/certificate.png', height: 50, width: 50),
            const SizedBox(
              height: smallerSpacing,
            ),
            Text('Upload new Certificate : ',
                style: Theme.of(context).textTheme.xSmall.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.mediumBlack)),
            const SizedBox(
              height: tinierSpacing,
            ),
            Text(
                "You can't upload new certificate as approval is pending for selected certificate",
                style: Theme.of(context).textTheme.xxSmall.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.grey))
          ],
        ),
      ),
    );
  }
}
