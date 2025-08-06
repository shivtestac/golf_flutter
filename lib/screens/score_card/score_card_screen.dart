import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cp/gradient_circular_progress_bar.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/score_card/score_card_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScoreCardScreen extends StatefulWidget {
  const ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreCardController>(
      builder: (context, ScoreCardController controller, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     /* SizedBox(height: 16.px),
                      Text(
                        'Andrew Wade / 31 hcp',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.px),
                      ),
                      SizedBox(height: 6.px),
                      Text(
                        'Meadow Springs Golf And Country Club / Jan 16, 2020',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.px),
                      CW.commonGradiantDividerView(),
                      SizedBox(height: 16.px),*/
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Image.asset('assets/img/img_score_card.png',height: MediaQuery.of(context).size.height *.7),
                      ),
                      SizedBox(height: 16.px),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget loadingProgressBarView({required ScoreCardController controller}) => Padding(
    padding: EdgeInsets.all(24.px),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.px,
          width: 20.px,
          child: const GradientCircularProgressIndicator(),
        ),
        SizedBox(width: 12.px),
        Text(
          'Searching for “Emm”...',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    ),
  );

  Widget gridView(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 16.px,mainAxisSpacing: 16.px),
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 24.px,vertical: 16.px),
      itemBuilder: (context, index) {
        return Container(
          // height: 180.px,
          // width: 148.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.px),
            image: const DecorationImage(
              image: AssetImage('assets/dummy_img/play_ground_img.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.px),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.px),
                    bottomRight: Radius.circular(16.px),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.1),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 24.px,
                      width: 24.px,
                      margin: EdgeInsets.only(right: 8.px),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.px,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Theme.of(context).colorScheme.error,
                          size: 12.px,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.px),
                    Flexible(
                      child: Text(
                        'Try it out! Analyse a Golf Swing FO',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.px
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
