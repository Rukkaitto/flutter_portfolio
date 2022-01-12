import 'package:flutter/material.dart';
import 'package:flutter_portfolio/utils/utils.dart';
import 'package:flutter_portfolio/views/views.dart';
import 'package:flutter_portfolio/widgets/widgets.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  static const renScale = 1.0;
  static const takeYourTimeScale = 0.8;
  static const desktopPadding = 50.0;
  static const repeatDelay = Duration(milliseconds: 300);
  static const takeYourTimeStartDelay = Duration(milliseconds: 250);
  static const loadingDuration = Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    showHome(
      context,
      after: loadingDuration,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, contraints) {
          if (contraints.maxWidth < Responsive.phoneScreenWidth) {
            return Center(
              child: buildLoadingSpinner(renScale),
            );
          } else {
            return Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: desktopPadding,
                  right: desktopPadding,
                ),
                child: buildLoadingSpinner(takeYourTimeScale),
              ),
            );
          }
        },
      ),
    );
  }

  void showHome(BuildContext context, {required Duration after}) {
    final Future<Home> waitForHome = Future.delayed(after, () => const Home());

    waitForHome.then((value) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
            return value;
          },
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  Widget buildLoadingSpinner(double scale) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spinner(
          curve: Curves.easeInOutCubic,
          repeatDelay: repeatDelay,
          child: Image.network(
            'assets/assets/images/ren.png',
            scale: 1 / scale,
          ),
        ),
        Spinner(
          curve: Curves.easeInOutCubic,
          startDelay: takeYourTimeStartDelay,
          repeatDelay: repeatDelay,
          child: Image.network(
            'assets/assets/images/takeyourtime.png',
            scale: 1 / scale * 1.2,
          ),
        ),
      ],
    );
  }
}
