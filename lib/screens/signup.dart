// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Signup extends StatelessWidget {
  const Signup({super.key});


  @override
  Widget build(BuildContext context) {
   final platformBrightness = MediaQuery.of(context).platformBrightness;
    String themeMode = platformBrightness == Brightness.dark ? "dark" : "light";

    return Scaffold(
      backgroundColor: themeMode == "light" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25),
      body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text("Sign in", style: TextStyle(color: themeMode == "dark" ? Colors.white : Colors.black, fontSize: 24), ),
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Container(
              width: MediaQuery.of(context).size.width -28, child: Text("Email or username", style: TextStyle(color: themeMode == "dark" ? Colors.white : Colors.black, fontSize: 14), textAlign: TextAlign.left,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email or username",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
             Divider(
              color: Colors.transparent,
            ),
            Container(
              width: MediaQuery.of(context).size.width -28, child: Text("Password", style: TextStyle(color: themeMode == "dark" ? Colors.white : Colors.black, fontSize: 14), textAlign: TextAlign.left,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25)),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: 
              Column(children: [
                 Text("Having trouble signing in?", style: TextStyle(color: themeMode == "dark" ? Colors.white : Colors.black, fontSize: 14), textAlign: TextAlign.center,),                
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Reset password", style: TextStyle(color: Color.fromARGB(255, 69, 63, 255), fontSize: 14), textAlign: TextAlign.center,),
                     Container(margin: EdgeInsets.all(10), child: Text("or", style: TextStyle(color: themeMode == "dark" ? Colors.white : Colors.black, fontSize: 14), textAlign: TextAlign.center,)),
                     Text("recover username", style: TextStyle(color: Color.fromARGB(255, 69, 63, 255), fontSize: 14), textAlign: TextAlign.center,),
                   ],
                 ),                
                     SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 50,
                       child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 69, 63, 255) ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                     ),
                     Divider(
                      color: Colors.transparent,
                     ),
                     SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 50,
                       child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                            backgroundColor: Color.fromARGB(23, 69, 63, 255) ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                        child: Text(
                          "create account",
                          style: TextStyle(color: Color.fromARGB(255, 69, 63, 255), fontSize: 16),
                        )),
                     ),
              ]),
            )
          ],
        ),
      ),
    ), 
    floatingActionButton: FloatingActionButton(onPressed: () {
      Navigator.pop(context);
    } , child: Icon(Icons.close, color: themeMode == "dark" ? Colors.white : Colors.black), 
    backgroundColor: Colors.transparent, elevation: 0, )
     , floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
