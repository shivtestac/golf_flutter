import 'package:flutter/material.dart';
import 'package:golf_flutter/api/api_models/practice_model.dart';
import 'package:golf_flutter/common/graphs/custom_bar_chart_graph.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/video_screen/video_screen_screen.dart';
import 'package:video_player/video_player.dart';

import '../../api/api_constants/api_url_constants.dart';
import '../../api/api_methods/api_methods.dart';

class FullSwingPracticeDetailController extends ChangeNotifier {
  String selectedLevelValue = '';
  VideoPlayerController? videoController1;

  List levelTitleList = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
  ];

  final List<String> options = ["Last 5", "Last 20", "Last 100"];
  String selectedOption = "Last 100";
  bool isMenuOpen = false;

  final List<double> yValues = [5, 4, 3, 2, 1];
  final List<String> xLabels = [
    "",
    "18 Sept",
    "19 Sept",
    "20 Sept",
    "21 Sept",
    "22 Sept"
  ];

  final List<double> yValuesForSingleLineChartGraph = [-4, -2, 2, 4];
  final List<String> xLabelsForSingleLineChartGraph = [
    '',
    '0',
    '5',
    'You',
    '20’',
    '10h',
    '20h'
  ];

  List scoringDataList = [
    {"title": "Make", "subTitle": "Eagle"},
    {"title": "<5%", "subTitle": "Birdie"},
    {"title": "<10%", "subTitle": "Par"},
    {"title": ">10%", "subTitle": "Bogey"},
  ];

  List puttingDataList = [
    {"title": "25.0", "subTitle": "Total Putts"},
    {"title": "3.0", "subTitle": "Three Putts"},
  ];

  List<BarData> xLabelsForPerformanceOverTimeGraph = List.generate(
    21,
    (index) => BarData(value: (index + 1) * (index % 1 + 1), label: '$index'),
  );
  final List<double> yValuesForPerformanceOverTimeGraph = [5, 4, 3, 2, 1];

  final List progressBarListData = [
    {"title": "Driving Accuracy", "current": 7, "total": 14},
    {"title": "Driving Distance'", "current": 14, "total": 14},
    {"title": "Total Driving Strokes Gained'", "current": 9, "total": 14},
  ];

  bool inAsyncCall = true; // A flag to track if initMethod is called
  bool isInitCalled = false; // A flag to track if initMethod is called
  PracticeModel? practiceModel;
  PracticeStats? practiceStats;
  PracticeData? practiceData;

  Future<void> initMethod(pageData) async {
    if (!isInitCalled) {
      isInitCalled = true;
      notifyListeners();
      await apiCall(pageData);
    }
    inAsyncCall = false;
    notifyListeners();
  }

  Future<void> videoControllerInitialized() async {
    if (practiceData!=null && practiceData?.video!=null && practiceData?.video!='') {
      String videoPath='${ApiUrlConstants.baseUrlForImages}${practiceData!.video}';
      print('Video path::--$videoPath');
      isInitCalled = true;
      inAsyncCall = true;
      videoController1 = VideoPlayerController.networkUrl(Uri.parse(videoPath
      ))..initialize().then((_) {
        notifyListeners();
      });
    }
  }

  Widget buildVideoPlayer(
      VideoPlayerController controller,
      ) {
    return controller.value.isInitialized
        ? Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
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

      ],
    );
  }

  apiCall(pageData) async {
    print("pageData:::::::::::::::::");
    print(pageData['cardName']);
    switch (pageData['cardName']) {
      case 'Driver Test':
        practiceModel = await ApiMethods.driverTest();
        practiceStats = practiceModel?.stats;
        practiceData = practiceModel?.data;
        videoControllerInitialized();
        notifyListeners();
        break;
      case 'Approach':
        practiceModel = await ApiMethods.approach();
        practiceStats = practiceModel?.stats;
        practiceData = practiceModel?.data;
        videoControllerInitialized();
        notifyListeners();
        break;
      case 'Approach (Variable)':
        practiceModel = await ApiMethods.approachVariable();
        practiceStats = practiceModel?.stats;
        practiceData = practiceModel?.data;
        videoControllerInitialized();
        notifyListeners();
        break;
    }
  }

  void clickOnLevelCardView({required int index}) {
    selectedLevelValue = levelTitleList[index];
    notifyListeners();
  }

  void clickOnBackButton({required BuildContext context}) {
    NM.popMethod(context: context);
  }

  clickOnVideo({required BuildContext context}) {
    NM.pushMethod(screen: VideoScreenScreen(), context: context);
  }
}
