import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});


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

    return  Scaffold(
      backgroundColor:  themeMode == "light" ? Color.fromARGB(244, 255, 255, 255) : Color.fromARGB(244, 25, 25, 25),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Customize the height
        child: AppBar(
          flexibleSpace: Center(
            child: Text("Portfolio", style: TextStyle(fontSize: 24, color: themeMode == "dark" ? Colors.white : Colors.black87), )
          ),
          automaticallyImplyLeading: false, // Hide the back button
          backgroundColor:  Colors.transparent,
        ),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
         Image.asset("lib/images/crak.png", width: MediaQuery.of(context).size.width - 50, height: 270,),
         Divider(color: Colors.transparent,),
         Divider(color: Colors.transparent,),
         Text("Jump in", style: TextStyle(fontSize: 30, color: themeMode == "dark" ? Colors.white : Colors.black87, fontWeight: FontWeight.bold), ),
         Container(
           width: MediaQuery.of(context).size.width - 100,
           child: Text("Make your first purchase and jump into the world of crypto", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: themeMode == "dark" ? const Color.fromARGB(255, 226, 226, 226) : Colors.black87, fontWeight: FontWeight.w300), )),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                        child: Text(
                          "Buy Crypto",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
         ),
      
         ],
        ),
      )
    );
  }
}