import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({required this.video, super.key});

  final String video;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late VideoPlayerController controller;
  bool visible = true;
  Timer? timer;

  @override
  void initState() {
    controller = VideoPlayerController.file(File(widget.video))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!visible) {
          setState(() {
            visible = true;
          });
          fader();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            Visibility(
              visible: visible,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (controller.value.isPlaying) {
                          visible = true;
                          controller.pause();
                          timer?.cancel();
                        } else {
                          visible = false;
                          controller.play();
                          fader();
                        }
                      });
                    },
                    icon: Icon(
                      controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                    iconSize: 50,
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fader() {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
    });
  }
}
