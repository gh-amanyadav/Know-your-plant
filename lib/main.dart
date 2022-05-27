import 'package:flutter/material.dart';
import 'package:plant_species_detection/first_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Your Plant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash2(),
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new FirstPage(),
      image: new Image.asset('assets/images/Logo.png'),
      photoSize: 125.0,
      loaderColor: Colors.green,
    );
  }
}