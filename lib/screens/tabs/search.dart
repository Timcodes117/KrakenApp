import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController exploreInput = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    String inputSearch = exploreInput.text;
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
            child: Text("Explore", style: TextStyle(fontSize: 24, color: themeMode == "dark" ? Colors.white : Colors.black87), )
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
        //  Image.asset("lib/images/crak.png", width: MediaQuery.of(context).size.width - 50, height: 270,),
         Divider(color: Colors.transparent,),
         Divider(color: Colors.transparent,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
            child: 
            TextField(
              style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25)),
              onChanged: (value) {
                setState(() {
                  inputSearch = exploreInput.toString();
                });
              },
              controller: exploreInput,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type your search",
                hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
           ),
         ),
         Container(
           width: MediaQuery.of(context).size.width - 100,
           child: exploreInput.text.length < 1 ?
            Text("explore the world of crypto.", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: themeMode == "dark" ? const Color.fromARGB(255, 226, 226, 226) : Colors.black87, fontWeight: FontWeight.w300), )
: 
           Text("searching for $inputSearch", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: themeMode == "dark" ? const Color.fromARGB(255, 226, 226, 226) : Colors.black87, fontWeight: FontWeight.w300), ))
      
         ],
        ),
      )
    );
  }
}