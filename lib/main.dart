import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:golf_flutter/common/cm.dart';
import 'package:golf_flutter/screens/ai_caddie/ai_caddie_controller.dart';
import 'package:golf_flutter/screens/bottom_bar/bottom_bar_controller.dart';
import 'package:golf_flutter/screens/courses_detail/courses_detail_controller.dart';
import 'package:golf_flutter/screens/followers/followers_controller.dart';
import 'package:golf_flutter/screens/forgot_password/forgot_password_controller.dart';
import 'package:golf_flutter/screens/full_swing_practice_detail/full_swing_practice_detail_controller.dart';
import 'package:golf_flutter/screens/home/home_controller.dart';
import 'package:golf_flutter/screens/lessons/lessons_controller.dart';
import 'package:golf_flutter/screens/login/login_controller.dart';
import 'package:golf_flutter/screens/login_type/login_type_controller.dart';
import 'package:golf_flutter/screens/my_video_player/my_video_player_controller.dart';
import 'package:golf_flutter/screens/notification/notification_controller.dart';
import 'package:golf_flutter/screens/on_boarding/on_boarding_controller.dart';
import 'package:golf_flutter/screens/otp/otp_controller.dart';
import 'package:golf_flutter/screens/play/play_controller.dart';
import 'package:golf_flutter/screens/play_at_course/play_at_course_controller.dart';
import 'package:golf_flutter/screens/play_at_course_ai_caddie/play_at_course_ai_caddie_controller.dart';
import 'package:golf_flutter/screens/play_at_practice_simulated/play_at_practice_simulated_controller.dart';
import 'package:golf_flutter/screens/play_online/play_online_controller.dart';
import 'package:golf_flutter/screens/play_saved_courses/play_saved_courses_controller.dart';
import 'package:golf_flutter/screens/practice/practice_controller.dart';
import 'package:golf_flutter/screens/practice_detail/practice_detail_controller.dart';
import 'package:golf_flutter/screens/reset_password/reset_password_controller.dart';
import 'package:golf_flutter/screens/round_setup/round_setup_controller.dart';
import 'package:golf_flutter/screens/round_setup_add_player/round_setup_add_player_controller.dart';
import 'package:golf_flutter/screens/score_card/score_card_controller.dart';
import 'package:golf_flutter/screens/search/search_controller.dart';
import 'package:golf_flutter/screens/select_tees/select_tees_controller.dart';
import 'package:golf_flutter/screens/setup_player/setup_player_controller.dart';
import 'package:golf_flutter/screens/sign_up/sign_up_controller.dart';
import 'package:golf_flutter/screens/splash/splash_controller.dart';
import 'package:golf_flutter/screens/splash/splash_screen.dart';
import 'package:golf_flutter/screens/stats/stats_controller.dart';
import 'package:golf_flutter/screens/stats_data_list/stats_data_list_controller.dart';
import 'package:golf_flutter/screens/update_profile/update_profile_controller.dart';
import 'package:golf_flutter/screens/user_profile/user_profile_controller.dart';
import 'package:golf_flutter/screens/video_screen/video_screen_controller.dart';
import 'package:golf_flutter/screens/your_dispersion/your_dispersion_controller.dart';
import 'package:golf_flutter/theme/theme_data/theme_data.dart';
import 'package:provider/provider.dart';

import 'screens/play_gps_online/play_gps_online_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => LoginTypeController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordController()),
        ChangeNotifierProvider(create: (_) => OtpController()),
        ChangeNotifierProvider(create: (_) => ResetPasswordController()),
        ChangeNotifierProvider(create: (_) => SignUpController()),
        ChangeNotifierProvider(create: (_) => YourDispersionController()),
        ChangeNotifierProvider(create: (_) => BottomBarController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => SearchDiscoverController()),
        ChangeNotifierProvider(create: (_) => PlayController()),
        ChangeNotifierProvider(create: (_) => PlaySavedCoursesController()),
        ChangeNotifierProvider(create: (_) => PlayOnlineController()),
        ChangeNotifierProvider(create: (_) => PlayGpsOnlineController()),
        ChangeNotifierProvider(create: (_) => CoursesDetailController()),
        ChangeNotifierProvider(create: (_) => LessonsController()),
        ChangeNotifierProvider(create: (_) => StatsController()),
        ChangeNotifierProvider(create: (_) => UserProfileController()),
        ChangeNotifierProvider(create: (_) => FollowersController()),
        ChangeNotifierProvider(create: (_) => StatsDataListController()),
        ChangeNotifierProvider(create: (_) => PracticeController()),
        ChangeNotifierProvider(create: (_) => PracticeDetailController()),
        ChangeNotifierProvider(create: (_) => PlayAtCourseController()),
        ChangeNotifierProvider(create: (_) => FullSwingPracticeDetailController()),
        ChangeNotifierProvider(create: (_) => ScoreCardController()),
        ChangeNotifierProvider(create: (_) => UpdateProfileController()),
        ChangeNotifierProvider(create: (_) => MyVideoPlayerController()),
        ChangeNotifierProvider(create: (_) => AiCaddieController()),
        ChangeNotifierProvider(create: (_) => PlayAtCourseAiCaddieController()),
        ChangeNotifierProvider(create: (_) => VideoScreenController()),
        ChangeNotifierProvider(create: (_) => PlayAtPracticeSimulatedController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocsKeyBoard(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MaterialApp(
          title: 'Golf Flutter',
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          theme: AppThemeData.themeData(
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

/*

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:quiver/async.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool recording = false;
  int _time = 0;

  requestPermissions() async {
    if (!kIsWeb) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
      if (await Permission.microphone.request().isDenied) {
        await Permission.microphone.request();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    startTimer();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: 1000),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() => _time++);
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Screen Recording'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Time: $_time\n'),
            !recording
                ? Center(
              child: ElevatedButton(
                child: Text("Record Screen"),
                onPressed: () => startScreenRecord(false),
              ),
            )
                : Container(),
            !recording
                ? Center(
              child: ElevatedButton(
                child: Text("Record Screen & audio"),
                onPressed: () => startScreenRecord(true),
              ),
            )
                : Center(
              child: ElevatedButton(
                child: Text("Stop Record"),
                onPressed: () => stopScreenRecord(),
              ),
            )
          ],
        ),
      ),
    );
  }

  startScreenRecord(bool audio) async {
    bool start = false;

    if (audio) {
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
    }

    if (start) {
      setState(() => recording = !recording);
    }

    return start;
  }

  stopScreenRecord() async {
    String path = await FlutterScreenRecording.stopRecordScreen;
    setState(() {
      recording = !recording;
    });
    print("Opening video");
    print(path);
    OpenFile.open(path);
  }
}


*/

/*
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Recorder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Screen Recorder Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isRecording = false;
  String? _recordedFilePath;

  /// Request required permissions
  Future<void> _requestPermissions() async {
    await [
      Permission.storage,
      Permission.microphone,
      Permission.manageExternalStorage
    ].request();
  }

  /// Start recording
  Future<void> _startRecording() async {
    await _requestPermissions();
    bool started = await FlutterScreenRecording.startRecordScreen(
        "my_recording",
        titleNotification: "Screen Recording",
        messageNotification: "Recording screen..."
    );
    setState(() {
      _isRecording = started;
    });
  }

  /// Stop recording and save the file
  Future<void> _stopRecording() async {
    String? path = await FlutterScreenRecording.stopRecordScreen;
    if (path != null) {
      setState(() {
        _isRecording = false;
        _recordedFilePath = path;
      });
      debugPrint("Saved Recording: $path");
    }
  }

  /// Share the recorded MP4 file
  Future<void> _shareRecording() async {
    if (_recordedFilePath == null) {
      return;
    }
    Share.shareXFiles([XFile(_recordedFilePath!)], text: "Check out my screen recording!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isRecording
                ? const Text("Recording in progress...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                : const Text("Press start to record", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: const Text("Start Recording"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : null,
              child: const Text("Stop Recording"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _recordedFilePath != null ? _shareRecording : null,
              child: const Text("Share Recording"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
