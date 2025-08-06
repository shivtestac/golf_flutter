import 'package:flutter/material.dart';
import 'package:golf_flutter/screens/login_type/login_type_screen.dart';

import '../../common/nm.dart';

class OnBoardingController extends ChangeNotifier {
  List onboardingImgList = [
    'assets/img/onboarding1_img.png',
    'assets/img/onboarding2_img.png',
    'assets/img/onboarding3_img.png',
  ];

  List onboardingTitleList = [
    'Welcome to RED',
    'Moneyback Guarantee',
    'Analytics... on things that matter',
  ];

  List onboardingSubTitleList = [
    '''Red is the ultimate golf app. With features like GPS stat tracking (compatible with Apple Watch), online lessons, and practice drills designed by motor learning experts, Red elevates your game and maximizes your practice time. We cater to the deep diving stats nut, but also help the weekend warrior save strokes with simple drills and analysis.''',
    '''Whether you're a complete beginner or a club champion, no golf app elevates your game more efficiently than RED. What sets us apart? RED leverages AI technology and is crafted by PGA professionals with expertise in motor learning and biomechanics. If you put in the effort, we guarantee you'll see improvement—or your money back!''',
    '''For collegiate or professional golfers looking to fully immerse themselves in their game, RED has everything you need. With strokes gained metrics and handicap metrics in various areas of your game you can easily identify biases and weaknesses, allowing for swift corrections. You can even grade yourself on course management by using the watch or your phone during a round to choose targets. By comparing your target and club choice to the "caddy recommendations" you can find out how many strokes you're losing with poor choices.''',
  ];

  PageController pageController = PageController();

  String currentPageIndex = '0';

  void clickOnSkipButton({required BuildContext context}) {
    NM.pushAndRemoveUntilMethod(
        context: context, screen: const LoginTypeScreen());
  }

  void onPageChange({required int value}) {
    currentPageIndex = value.toString();
    notifyListeners();
  }

  void clickOnBackButton() {
    if (currentPageIndex != '0') {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    }
  }

  void clickOnNextButton({required BuildContext context}) {
    if (currentPageIndex != '2') {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    } else if (currentPageIndex == '2') {
      clickOnSkipButton(context: context);
    }
  }
}
