import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class QuoteMessageReplyContainer extends StatelessWidget {
  final Map messageData;

  const QuoteMessageReplyContainer({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: (messageData['isReceiver'] == 1)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
            padding: const EdgeInsets.all(xxxTinierSpacing),
            margin: const EdgeInsets.all(tiniestSpacing),
            decoration: BoxDecoration(
                color: (messageData['isReceiver'] == 1)
                    ? AppColor.lightestblueGrey.withOpacity(1)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(4)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(messageData['quotemsg'].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(overflow: TextOverflow.ellipsis)),
              const SizedBox(height: xxTiniestSpacing),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const Icon(Icons.reply,
                    size: kReplyIconSize, color: Colors.grey),
                const SizedBox(width: xxTiniestSpacing),
                Text(messageData['quote_sender'].toString(),
                    style: Theme.of(context).textTheme.tinySmall.copyWith(
                        color: AppColor.grey,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1)
              ]),
              const SizedBox(height: xxTiniestSpacing),
              const Divider(
                  height: kQuoteMessageDividerHeight, color: Colors.grey)
            ])));
  }
}
