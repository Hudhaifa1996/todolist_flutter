import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todolists/viewmodel/vm_onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:todolists/routing.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  static SkipNext buttonText = SkipNext(0);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int itemIndex) {
            return SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(imageList[itemIndex], height: 400),
                    Text(
                      titleList[itemIndex],
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'calibri',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      height: 200.0,
                      child: Text(
                        textList[itemIndex],
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[800],
                          fontFamily: 'calibri',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ]),
            );
          },
          controller: pageController,

          onPageChanged: (index) {
            buttonText = SkipNext(index);
            (context as Element).markNeedsBuild();
          },
          // children: [
          //
          // ],
        ),
        Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    onBoardingSkip(Routing.prefs);
                    context.go('/home');
                  },
                  child: Text(
                    buttonText.buttonText,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'calibri',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SmoothPageIndicator(controller: pageController, count: 3),
                TextButton(
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    buttonText.buttonText2,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'calibri',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
