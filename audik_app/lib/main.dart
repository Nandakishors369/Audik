import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Main%20Screens/navigation.dart';
import 'package:audik_app/Main%20Screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audik',
      home: navigationBar(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
