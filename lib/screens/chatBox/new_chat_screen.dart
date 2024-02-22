import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/blocs/chatBox/chat_box_state.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class NewChatScreen extends StatelessWidget {
  static const routeName = 'NewChatScreen';
  static Map<String, dynamic> employeeDetailsMap = {};

  const NewChatScreen({super.key});

  void _handleMessage(String text, BuildContext context) {
    if (text.isEmpty) return;
    context.read<ChatBoxBloc>().messagesList.insert(0, {'msg': text});
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ChatBoxBloc>()
        .add(RebuildChat(employeeDetailsMap: employeeDetailsMap));
    return Scaffold(
        appBar: GenericAppBar(title: employeeDetailsMap['employee_name'] ?? ''),
        body: BlocBuilder<ChatBoxBloc, ChatBoxState>(
          buildWhen: (previousState, currentState) =>
              currentState is ChatHasBeenRebuild,
          builder: (context, state) {
            if (state is ChatHasBeenRebuild) {
              return Column(children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) =>
                        ChatMessage(message: state.messages[index]['msg']),
                  ),
                ),
                const Divider(height: kChatScreenDividerHeight),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: _buildTextComposer(context),
                )
              ]);
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }

  Widget _buildTextComposer(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return IconTheme(
        data: const IconThemeData(color: AppColor.deepBlue),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: xxxTinierSpacing),
            child: Row(children: <Widget>[
              Flexible(
                child: TextField(
                  controller: textEditingController,
                  onChanged: (String text) {
                    textEditingController.text = text;
                    employeeDetailsMap['message'] = textEditingController.text;
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message'),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _handleMessage(textEditingController.text, context);
                    context
                        .read<ChatBoxBloc>()
                        .add(SendMessage(sendMessageMap: employeeDetailsMap));
                  }),
            ])));
  }
}

class ChatMessage extends StatelessWidget {
  final String message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    List<String> fullName =
        NewChatScreen.employeeDetailsMap['employee_name']?.split(' ') ?? '';
    String firstName = fullName[0][0].toUpperCase();
    String lastName = fullName[1][0].toUpperCase();
    return Container(
        margin: const EdgeInsets.symmetric(
            vertical: xxTinierSpacing, horizontal: xxTinySpacing),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: xxTinySpacing),
                  child: CircleAvatar(child: Text('$firstName$lastName'))),
              Expanded(
                  child: CustomCard(
                      color: AppColor.lightestBlue,
                      child: Padding(
                          padding: const EdgeInsets.all(xxTinierSpacing),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  NewChatScreen.employeeDetailsMap[
                                          'employee_name'] ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .small
                                      .copyWith(color: AppColor.black),
                                ),
                                const SizedBox(height: tiniestSpacing),
                                Text(message, maxLines: 2),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('dfh',
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxSmall))
                              ]))))
            ]));
  }
}
