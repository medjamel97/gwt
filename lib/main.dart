import 'package:flutter/material.dart';
import 'package:gwt/view/register_view.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: mainNavigatorKey,
      home: const RegisterView(),
    );
  }
}
