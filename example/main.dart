import 'package:flutter_vertical_marquee/flutter_vertical_marquee.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('title'),
          ),
          body: Column(
            children: <Widget>[
              _buildMarquee(),
            ],
          )),
      initialRoute: "home",
    );
  }

  List<String> _tipMarqueeList = [];

  _initMarquee() {
    _tipMarqueeList.clear();
    _tipMarqueeList.addAll(["test1", "test2"]);
  }

  Widget _buildMarquee() {
    _initMarquee();
    return Container(
      height: 40.0,
      color: Colors.lightBlueAccent.shade100,
      child: Marquee(
        textList: _tipMarqueeList, //
        fontSize: 14.0,
        scrollDuration: Duration(seconds: 1),
        stopDuration: Duration(seconds: 3),
        tapToNext: false,
        textColor: Colors.black,
      ),
    );
  }
}
