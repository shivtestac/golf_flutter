import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_flutter/common/cw.dart';
import 'package:golf_flutter/screens/splash/splash_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var splashController = Provider.of<SplashController>(context);
    splashController.initMethod(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder:
          (BuildContext context, SplashController controller, Widget? child) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CW.imageView(
                isAssetImage: true,
                image: 'assets/background_img/splash_bg.png',
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.px),
                child: SizedBox(
                  height: 50.px,
                  width: 50.px,
                  child: CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
