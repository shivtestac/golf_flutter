import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/video_screen/video_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoScreenScreen extends StatefulWidget {
  const VideoScreenScreen({super.key});

  @override
  State<VideoScreenScreen> createState() => _VideoScreenScreenState();
}

class _VideoScreenScreenState extends State<VideoScreenScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var videoScreenController = Provider.of<VideoScreenController>(context);
    videoScreenController.initMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoScreenController>(
      builder:
          (BuildContext context, VideoScreenController controller, Widget? child) {
        return Scaffold(
          body: Center(
            child: controller.videoPlayerController.value.isInitialized
                ? AspectRatio(
              aspectRatio: controller.videoPlayerController.value.aspectRatio,
              child: VideoPlayer(controller.videoPlayerController),
            )
                : Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                controller.videoPlayerController.value.isPlaying
                    ? controller.videoPlayerController.pause()
                    : controller.videoPlayerController.play();
              });
            },
            child: Icon(
              controller.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        );
      },
    );
  }
}
