import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/chat/widgets/quote_message_reply_container.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import 'chat_subtitle.dart';

class MsgTextWidget extends StatelessWidget {
  final Map messageData;

  const MsgTextWidget({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double margin = 0;
      if (messageData['quotemsg'] != "") {
        double textWidth = getTextWidth(
            context,
            (messageData['quotemsg'].toString().length >
                    messageData['msg'].toString().length)
                ? messageData['quotemsg'].toString()
                : messageData['msg'].toString());
        margin = (constraints.maxWidth - textWidth) / 2;
      }
      return Visibility(
          visible: (messageData['quotemsg'] != ""),
          replacement: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: kMessageTilePadding),
              title: Align(
                  alignment: (messageData['isReceiver'] == 1)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                      padding: const EdgeInsets.all(xxxTinierSpacing),
                      margin: (messageData['isReceiver'] == 1)
                          ? const EdgeInsets.only(right: xxSmallSpacing)
                          : const EdgeInsets.only(left: xxSmallSpacing),
                      decoration: BoxDecoration(
                          color: (messageData['isReceiver'] == 1)
                              ? AppColor.blueGrey
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(kCardRadius)),
                      child: SelectionArea(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            if (messageData['isReceiver'] == 1) ...[
                              Flexible(child: Text(messageData['msg'])),
                              const SizedBox(height: tiniestSpacing),
                              (messageData['msg_status'] != '1')
                                  ? const Icon(Icons.timer,
                                      size: kMessageTimerIconSize)
                                  : const SizedBox.shrink()
                            ] else ...[
                              Flexible(child: Text(messageData['msg'])),
                              const SizedBox(height: tiniestSpacing),
                              (messageData['msg_status'] != '1')
                                  ? const Icon(Icons.timer,
                                      size: kMessageTimerIconSize)
                                  : const SizedBox.shrink()
                            ]
                          ])))),
              subtitle: ChatSubtitle(messageData: messageData)),
          child: ListTile(
              title: Align(
                  alignment: (messageData['isReceiver'] == 1)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                      decoration: BoxDecoration(
                          color: (messageData['isReceiver'] == 1)
                              ? AppColor.blueGrey
                              : Colors.grey[300],
                          borderRadius:
                              BorderRadius.circular(xxxTinierSpacing)),
                      margin: (messageData['isReceiver'] == 1)
                          ? EdgeInsets.only(right: margin)
                          : EdgeInsets.only(left: margin),
                      child: Column(children: [
                        QuoteMessageReplyContainer(messageData: messageData),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: xxxTinierSpacing,
                                vertical: kQuoteMessageTilePadding),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: SelectionArea(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      if (messageData['isReceiver'] == 1) ...[
                                        Flexible(
                                            child: Text(messageData['msg'])),
                                        const SizedBox(height: tiniestSpacing),
                                        (messageData['msg_status'] != '1')
                                            ? const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(Icons.timer,
                                                    size:
                                                        kMessageTimerIconSize))
                                            : const SizedBox.shrink()
                                      ] else ...[
                                        Flexible(
                                            child: Text(messageData['msg'])),
                                        const SizedBox(height: tiniestSpacing),
                                        (messageData['msg_status'] != '1')
                                            ? const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(Icons.timer,
                                                    size:
                                                        kMessageTimerIconSize))
                                            : const SizedBox.shrink()
                                      ]
                                    ]))))
                      ]))),
              subtitle: ChatSubtitle(messageData: messageData)));
    });
  }

  double getTextWidth(BuildContext context, String text) {
    TextPainter textPainter = TextPainter();
    if (text.length < 35) {
      textPainter = TextPainter(
          text: TextSpan(text: text, style: Theme.of(context).textTheme.small),
          textDirection: ui.TextDirection.ltr);
    } else {
      textPainter = TextPainter(
          text: TextSpan(
              text: text.substring(0, 35),
              style: Theme.of(context).textTheme.small),
          textDirection: ui.TextDirection.ltr);
    }
    textPainter.layout();
    return textPainter.width;
  }
}
