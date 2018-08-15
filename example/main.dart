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
    var controller = MarqueeController();
    return GestureDetector(
      child: Container(
        height: 40.0,
        color: Colors.lightBlueAccent.shade100,
        child: Marquee(
          textList: _tipMarqueeList, // your text list
          fontSize: 14.0, // text size
          scrollDuration: Duration(seconds: 1), // every scroll duration
          stopDuration: Duration(seconds: 3), //every stop duration
          tapToNext: false, // tap to next
          textColor: Colors.black, // text color
          controller: controller, // the controller can get the position
        ),
      ),
      onTap: () {
        print(controller.position); // get the position
      },
    );
  }
}
