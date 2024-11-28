import 'package:shared_preferences/shared_preferences.dart';

List<String> imageList = [
  'lib/assets/1.jpg',
  'lib/assets/2.jpg',
  'lib/assets/3.jpg'
];
List<String> titleList = [
  'To do list App',
  'Adding many points',
  'Deleting completed ones'
];
List<String> textList = [
  'it is a program to manipulate your daily to do list',
  'You can add many points to your daily list and edit them',
  'You can delete completed points from your daily list'
];

class SkipNext {
  String buttonText = "skip";
  String buttonText2 = "next";
  int index = 0;

  SkipNext(index) {
    if (index == 2) {
      buttonText = 'finish';
      buttonText2 = '          ';
    } else {
      buttonText = 'skip';
      buttonText2 = 'next';
    }
  }
}

void onBoardingSkip(SharedPreferences prefs) {
  prefs.setBool('repeat', false);
}
