import 'package:go_router/go_router.dart';
import 'package:todolists/view/waiting.dart';
import 'view/onboarding.dart';
import 'view/splash.dart';
import 'view/home.dart';
import 'view/listedit.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Routing {
  static late final SharedPreferences prefs;

// GoRouter configuration
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => OnBoarding(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        name: 'listedit',
        path: '/listedit',
        builder: (context, state) => ListEdit(),
      ),
      GoRoute(
        name: 'waiting',
        path: '/waiting',
        builder: (context, state) => const Waiting(),
      )
    ],
  );
}
