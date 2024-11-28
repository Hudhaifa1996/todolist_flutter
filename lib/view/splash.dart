import 'package:flutter/material.dart';
import 'package:todolists/viewmodel/vm_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:todolists/routing.dart';
import '../API/api.dart';
import 'loadingwidget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Future.wait(
              [getNextRoute(Routing.prefs), API().fetchData(context)]),
          initialData: 'wait',
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('${snapshot.data[0]}');
              });
            }
            return const LoadingWidget();
          }),
    );
  }
}
