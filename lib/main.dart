import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolists/providers/listprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Routing.prefs = prefs;
  runApp(ChangeNotifierProvider(
    create: (context) => ListProvider(),
    child: MaterialApp.router(
      routerConfig: Routing.router,
      debugShowCheckedModeBanner: false,
    ),
  ));
}
