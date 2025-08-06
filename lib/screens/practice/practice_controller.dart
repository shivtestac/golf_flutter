import 'package:flutter/material.dart';
import 'package:golf_flutter/common/nm.dart';
import 'package:golf_flutter/screens/practice_detail/practice_detail_screen.dart';

import '../full_swing_practice_detail/full_swing_practice_detail_screen.dart';

class PracticeController extends ChangeNotifier {
  String selectedCardValue = 'All';

  List topListCardTitle = [
    'All',
    'Putting',
    'Short Game',
    'Full Swing',
  ];

  bool isChipsDataLoadValue = false;

  List cardBgImgList = [
    'assets/background_img/practice_card_1_img.png',
    'assets/background_img/practice_card_3_img.png',
    'assets/background_img/practice_card_2_img.png',
  ];

  List cardDetailList = [
    ///TODO For Putting
    {
      "cardType": "Putting",
      "cardName": "Lag Putt Tornado",
      "cardDetail":
          "The ultimate drill for eliminating three putts. Get better at lagging long ASAP.",
    },
    {
      "cardType": "Putting",
      "cardName": "Stroke Test",
      "cardDetail": "Block practice for working on your putting stroke.",
    },
    {
      "cardType": "Putting",
      "cardName": "Marketable",
      "cardDetail":
          "Marketable putts from 3-12 feet. These putts are the biggest separators of pros and ams.",
    },
    {
      "cardType": "Putting",
      "cardName": "Simulated Putting Round",
      "cardDetail":
          "Play 18 simulated holes on the putting green to see your putts gained in a game like scenario.",
    },

    ///TODO For Short Game
    {
      "cardType": "Short Game",
      "cardName": "Doc's Ultimate Chipping Drill (Fairway)",
      "cardDetail":
          "The ultimate drill for eliminating three putts. Get better at lagging long ASAP.",
    },
    {
      "cardType": "Short Game",
      "cardName": "Doc's Ultimate Chipping Drill (Rough)",
      "cardDetail": "Block practice for working on your putting stroke.",
    },
    {
      "cardType": "Short Game",
      "cardName": "Survivor",
      "cardDetail":
          "Marketable putts from 3-12 feet. These putts are the biggest separators of pros and ams.",
    },

    ///TODO For Full Swing
    {
      "cardType": "Full Swing",
      "cardName": "Driver Test",
      "cardDetail":
          "20 drives is all it takes to see your strokes gained off the tee. Work on your big dog.",
    },
    {
      "cardType": "Full Swing",
      "cardName": "Approach",
      "cardDetail":
          "The best drill to work on stock approach shots. No shapes or wind shots.",
    },
    {
      "cardType": "Full Swing",
      "cardName": "Approach (Variable)",
      "cardDetail":
          "Work on approach shots with variability. 1/4 of your shots are wind shots and 1/4 are shapes.",
    },
  ];

  Future<void> clickOnPracticeTopListCardView({required int index}) async {
    isChipsDataLoadValue = true;
    if (!selectedCardValue.contains(topListCardTitle[index])) {
      selectedCardValue = topListCardTitle[index];
      notifyListeners();
    }
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        isChipsDataLoadValue = false;
      },
    );
    notifyListeners();
  }

  void clickOnPracticeCardView(
      {required BuildContext context, required int index}) {
    if (selectedCardValue == 'Full Swing' || cardDetailList[index]['cardType'] == 'Full Swing' ) {
      NM.pushMethod(
        context: context,
        screen: FullSwingPracticeDetailScreen(
          pageData: cardDetailList[index],
        ),
      );
    } else {
      NM.pushMethod(
        context: context,
        screen: PracticeDetailScreen(
          pageData: cardDetailList[index],
        ),
      );
    }
  }
}
