import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:scribble/scribble.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'my_video_player_screen.dart';

class MyVideoPlayerController extends ChangeNotifier {
  Offset widgetPosition = Offset(100, 200); // Initial position
  double angleDegrees = 60;
  double widgetRotationalAngle = 0;
  final double lineLength = 100;
  ScribbleNotifier notifier = ScribbleNotifier();
  ScreenshotController screenshotController = ScreenshotController();
  VideoPlayerController? videoController1;
  VideoPlayerController? videoController2;
  int count = 0;
  bool showVs = false;
  bool showAngle = true;

  int selectedIconIndex = -1;
  List<IconData> iconList = [
    Icons.arrow_back_rounded,
    Icons.circle_outlined,
    Icons.square_outlined,
  ];

  bool isInitCalled = false; // A flag to track if initMethod is called
  bool inAsyncCall = false; // A flag to track if initMethod is called

  Future<void> initMethod() async {
    if (!isInitCalled) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String videoPath=sp.getString('video')??'';
      print('Video path::--$videoPath');
      isInitCalled = true;
      inAsyncCall = true;
      videoController1 = VideoPlayerController.networkUrl(Uri.parse(videoPath
          )) // 'https://admin.astropush.com/images/astrohomepage.mp4'  //////....  'https://www.pexels.com/video/a-woman-playing-golf-6542248/'
        ..initialize().then((_) {
          notifyListeners();
        });
      // videoController1 = VideoPlayerController.file(File('assets/icons/test_video.mp4'))
      //   ..initialize().then((_) {
      //     notifyListeners();
      //   });
      notifyListeners();
      inAsyncCall = false;
    }
  }

  Widget buildVideoPlayer(
    VideoPlayerController controller,
  ) {
    return controller.value.isInitialized
        ? Expanded(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget videoController() {
    return Row(
      children: [
        if (videoController1 != null)
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  VideoProgressIndicator(videoController1!,
                      allowScrubbing: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 30,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          final newPosition = videoController1!.value.position -
                              const Duration(seconds: 10);
                          videoController1!.seekTo(newPosition >= Duration.zero
                              ? newPosition
                              : Duration.zero);
                        },
                      ),
                      IconButton(
                        icon: videoController1!.value.isPlaying
                            ? const Icon(
                                Icons.pause,
                                size: 30,
                                color: Colors.teal,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.teal,
                              ),
                        onPressed: () {
                          videoController1!.value.isPlaying
                              ? videoController1!.pause()
                              : videoController1!.play();
                          notifyListeners();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next,
                          size: 30,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          final newPosition = videoController1!.value.position +
                              const Duration(seconds: 10);
                          videoController1!.seekTo(
                              newPosition <= videoController1!.value.duration
                                  ? newPosition
                                  : videoController1!.value.duration);
                        },
                      ),
                    ],
                  )
                ],
              )),
        if (showVs)
          const SizedBox(
            width: 20,
          ),
        if (videoController2 != null)
          if (showVs)
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    VideoProgressIndicator(videoController2!,
                        allowScrubbing: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 30,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            final newPosition =
                                videoController2!.value.position -
                                    const Duration(seconds: 10);
                            videoController2!.seekTo(
                                newPosition >= Duration.zero
                                    ? newPosition
                                    : Duration.zero);
                          },
                        ),
                        IconButton(
                          icon: videoController2!.value.isPlaying
                              ? const Icon(
                                  Icons.pause,
                                  size: 30,
                                  color: Colors.teal,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.teal,
                                ),
                          onPressed: () {
                            videoController2!.value.isPlaying
                                ? videoController2!.pause()
                                : videoController2!.play();
                            notifyListeners();
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            size: 30,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            final newPosition =
                                videoController2!.value.position +
                                    const Duration(seconds: 10);
                            videoController2!.seekTo(
                                newPosition <= videoController2!.value.duration
                                    ? newPosition
                                    : videoController2!.value.duration);
                          },
                        ),
                      ],
                    )
                  ],
                ))
      ],
    );
  }

  Future<void> clickScreenShotButton() async {
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getTemporaryDirectory();
        final imagePath =
            await File('${directory.path}/screenshot.png').create();
        await imagePath.writeAsBytes(image);

        // Convert the file path to XFile
        final xFile = XFile(imagePath.path);

        // Share using XFile
        await Share.shareXFiles([xFile], text: 'Here is my screenshot!');
      }
    }).catchError((onError) {
      print('Error:-${onError}');
    });
  }

  Future<void> clickOnSpitVideo() async {
    if (!showVs) {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        videoController2 = VideoPlayerController.file(File(pickedFile.path))
          ..initialize().then((_) {
            notifyListeners();
          });
        showVs = !showVs;
        notifyListeners();
      }
    } else {
      showVs = !showVs;
      notifyListeners();
    }
  }

  clickOnCrossButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  bool recording = false;
  bool isEditAble = false;

  startScreenRecord(bool audio) async {
    bool start = false;
    /*if (audio) {
      start = await FlutterScreenRecording.startRecordScreenAndAudio(
        "Title",
        titleNotification: "titleNotification",
        messageNotification: "messageNotification",
      );
    } else {
      start = await FlutterScreenRecording.startRecordScreen(
        "Title",
        titleNotification: "titleNotification",
        messageNotification: "messageNotification",
      );
    }*/

    if (start) {
      recording = !recording;
      notifyListeners();
    }
    return start;
  }

  stopScreenRecord() async {
    /* String path = await FlutterScreenRecording.stopRecordScreen;
    recording = !recording;
    notifyListeners();
    print("Opening video");
    print(path);
    OpenFile.open(path);*/
  }

  clickOnRecording() {
    if (recording) {
      stopScreenRecord();
    } else {
      startScreenRecord(true);
    }
  }

  clickOnEditAble() {
    isEditAble = !isEditAble;
    notifyListeners();
  }

  void clickOnScreenRotation() {
    if (MediaQuery.of(Get.context!).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }


  void updateAngle(DragUpdateDetails details) {
    // angleDegrees += details.delta.dx * 0.4;
    // angleDegrees = angleDegrees.clamp(0, 180);

    angleDegrees += details.delta.dx * 2;
    if (angleDegrees < 0) angleDegrees += 360;
    if (angleDegrees >= 360) angleDegrees -= 360;

    notifyListeners();
  }

  void updateWidgetPosition(DragUpdateDetails details) {
    widgetPosition += details.delta;
    notifyListeners();
  }

  void widgetRotateRight() {
    widgetRotationalAngle += 15;
    if (widgetRotationalAngle >= 360) widgetRotationalAngle -= 360;
    notifyListeners();
  }
}
