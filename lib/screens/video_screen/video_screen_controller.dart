import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoScreenController extends ChangeNotifier {

  bool isInitCalled = false;
  bool inAsyncCall = false;

  late VideoPlayerController videoPlayerController;



  Future<void> initMethod() async {
    if (!isInitCalled) {
      isInitCalled = true;
      inAsyncCall = true;
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
        ..initialize().then((_) {
          notifyListeners();
        });
    }
    inAsyncCall = false;
  }


}
