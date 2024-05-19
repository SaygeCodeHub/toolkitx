import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class ChatVideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const ChatVideoPlayerWidget({super.key, required this.videoPath});

  @override
  State<ChatVideoPlayerWidget> createState() => _ChatVideoPlayerWidgetState();
}

class _ChatVideoPlayerWidgetState extends State<ChatVideoPlayerWidget> {
  late final PodPlayerController podPlayerController;

  @override
  void initState() {
    podPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.file(File(widget.videoPath)),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    podPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: PodVideoPlayer(controller: podPlayerController),
      ),
    );
  }
}
