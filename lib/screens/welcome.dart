// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Welcome extends StatelessWidget {
  const Welcome({super.key});


  @override
  Widget build(BuildContext context) {
   final platformBrightness = MediaQuery.of(context).platformBrightness;
    String themeMode = platformBrightness == Brightness.dark ? "dark" : "light";

    return Scaffold(
      backgroundColor: themeMode == "light" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/images/person.png",
            width: 300,
            height: 300,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            "Welcome to Kraken!",
            style: TextStyle(fontSize: 30, color: themeMode == "dark" ? Colors.white : Colors.black),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Text(
              "Create your account or sign in to an existing account to build and manage your portfoilio.",
              style: TextStyle(
                fontSize: 18,
              color: themeMode == "dark" ? Colors.grey : Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Column(
            children: [
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                    child: Text(
                      "create account",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  ))
            ],
          )
        ],
      ),
    ), 
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.pushNamed(context, '/main');
    } , child: Icon(Icons.close, color: themeMode == "dark" ? Colors.white : Colors.black), 
    backgroundColor: Colors.transparent, elevation: 0, )
     , floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
