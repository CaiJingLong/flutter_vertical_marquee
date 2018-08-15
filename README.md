# flutter_vertical_marquee

## screenshot

![image](https://raw.githubusercontent.com/CaiJingLong/some_asset/master/flutter_vertical_marquee1.gif)

## install

in yaml

```yaml
dependencies:
  flutter:
    sdk: flutter

  ...
  # marquee
  flutter_vertical_marquee: ^0.1.1
```

import in dart:

```dart
import 'package:flutter_vertical_marquee/flutter_vertical_marquee.dart';
```

build widget

```dart
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
```

or see example tab

## call me

email cjl_spy@163.com
