// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kraken/screens/home.dart';
import 'package:kraken/screens/login.dart';
import 'package:kraken/screens/main.dart';
import 'package:kraken/screens/signup.dart';
import 'package:kraken/screens/welcome.dart';
import 'package:flutter/services.dart';


void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,    
  ));

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
   MyApp({super.key});



  // This widget is the root of your application.
bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
     // Use MediaQuery to check the current theme mode
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    bool themeMode = platformBrightness == Brightness.dark ? true : false;

    // Check the theme state and set the system navigation bar color.
    if (themeMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color.fromARGB(244, 25, 25, 25), statusBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Color.fromARGB(255, 229, 229, 229), statusBarIconBrightness: Brightness.dark));
    }

    return MaterialApp(
      title: 'Kraken',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Welcome(),
      routes: {
        '/welcome': (context)=> Welcome(),
        '/main': (context)=> MainApp(),
        '/home': (context)=> HomeScreen(),
        '/login': (context)=> Login(),
        '/signup': (context)=> Signup()
      },
    );
  }
}
