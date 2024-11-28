import 'package:shared_preferences/shared_preferences.dart';

Future<String> getNextRoute(SharedPreferences prefs) async {
  return prefs.getBool('repeat') == false ? '/home' : '/onboarding';
}
