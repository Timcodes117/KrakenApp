// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:heroicons_flutter/heroicons_list.dart';
import 'package:kraken/screens/home.dart';
import 'package:kraken/screens/login.dart';
import 'package:kraken/screens/tabs/account.dart';
import 'package:kraken/screens/tabs/portfolio.dart';
import 'package:kraken/screens/tabs/search.dart';
import 'package:kraken/screens/tabs/swap.dart';
import 'package:kraken/screens/welcome.dart';
import 'dart:io';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

int _selectedTab = 0;

class _MainAppState extends State<MainApp> {
  final List _screens = [HomeScreen(), Search(), Swap(), Portfolio(), Account() ];

  void _onChange(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(244, 255, 255, 255),
      body: _screens[_selectedTab],
      bottomNavigationBar: CustomBNavBar(changeBar: (index)=> _onChange(index),),
    );
  }
}

class CustomBNavBar extends StatelessWidget {
  final Function(int index) changeBar;

  CustomBNavBar({super.key, required this.changeBar});

  @override
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    String themeMode = platformBrightness == Brightness.dark ? "dark" : "light";

    if (themeMode == "dark") {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Color.fromARGB(244, 25, 25, 25),
          statusBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
          statusBarIconBrightness: Brightness.dark));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1)),
        color: themeMode == "light"
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(244, 25, 25, 25),
      ),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: BottomAppBar(
        elevation: 0,
        color: themeMode == "light"
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(244, 25, 25, 25),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BarCon(
                  name: "Home",
                  mode: themeMode,
                  icon: HeroiconsOutline.home,
                  barIndex: 0,
                  press: (index) {
                   changeBar(index);
                  },
                ),
                BarCon(
                  name: "Explore",
                  mode: themeMode,
                  icon: HeroiconsOutline.magnifyingGlass,
                  barIndex: 1,
                  press: (index) {
                   changeBar(index);
                  },
                ),
                BarCon(
                  name: "Swap",
                  mode: themeMode,
                  icon: HeroiconsOutline.home,
                  barIndex: 2,
                  press: (index) {
                  //  changeBar(index);
                  Navigator.pushNamed(context, '/login');
                  },
                ),
                BarCon(
                  name: "Portfolio",
                  mode: themeMode,
                  icon: HeroiconsOutline.wallet,
                  barIndex: 3,
                  press: (index) {
                   changeBar(index);
                  },
                ),
                BarCon(
                  name: "Account",
                  mode: themeMode,
                  icon: HeroiconsOutline.user,
                  barIndex: 4,
                  press: (index) {
                   changeBar(index);
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class BarCon extends StatelessWidget {
  // const BarCon({super.key});
  final name, mode, icon, barIndex;

  final Function(int index) press;

  BarCon(
      {required this.name,
      required this.mode,
      required this.icon,
      required this.barIndex,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press(barIndex);
      },
      child: Container(
        height: 50,
        width: 50,
        child: Column(
          children: [
            name != "Swap"
                ? Column(children: [
                    Icon(
                      icon,
                      color: _selectedTab == barIndex
                          ? Color.fromARGB(255, 69, 63, 255)
                          : Colors.grey,
                      size: 28,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 12,
                        color: 
                        _selectedTab != barIndex ?
                        mode == "dark"
                            ? Color.fromARGB(255, 235, 235, 235)
                            : Color.fromARGB(244, 25, 25, 25)
                            
                            : Color.fromARGB(255, 69, 63, 255),
                      ),
                    )
                  ])
                : Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(255, 69, 63, 255)),
                    child: Transform.rotate(
                      angle: 30 * (3.141592653589793 / 180),
                      child: 
                     Icon(HeroiconsOutline.arrowsUpDown, color: Colors.white,))
                    ,)
          ],
        ),
      ),
    );
  }
}
