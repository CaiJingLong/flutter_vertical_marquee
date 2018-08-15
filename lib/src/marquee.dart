import 'dart:async';

import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final List<String> textList;
  final double fontSize;
  final Color textColor;
  final Duration scrollDuration;
  final Duration stopDuration;
  final bool tapToNext;

  const Marquee({
    Key key,
    this.textList = const [],
    this.fontSize = 14.0,
    this.textColor = Colors.black,
    this.scrollDuration = const Duration(seconds: 1),
    this.stopDuration = const Duration(seconds: 3),
    this.tapToNext = false,
  }) : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  double percent = 0.0;
  int current = 0;

  List<String> get textList => widget.textList;

  Timer stopTimer;

  AnimationController animationConroller;

  @override
  void initState() {
    super.initState();
    animationConroller = AnimationController(vsync: this);
    stopTimer = Timer.periodic(widget.stopDuration + widget.scrollDuration, (timer) {
      next();
    });
  }

  void next() {
    var listener = () {
      var value = animationConroller.value;
      setState(() {
        percent = value;
      });
    };

    animationConroller.addListener(listener);
    animationConroller.animateTo(1.0, duration: widget.scrollDuration * (1 - percent)).then((t) {
      animationConroller.removeListener(listener);
      animationConroller.value = 0.0;
      setState(() {
        percent = 0.0;
        current = nextPosition;
      });
    });
  }

  @override
  void dispose() {
    animationConroller.dispose();
    stopTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (textList == null || textList.isEmpty) {
      return Container();
    }

    if (textList.length == 1) {
      return Center(
        child: Text(
          textList[0],
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor,
          ),
        ),
      );
    }

    Widget _widget = ClipRect(
      child: CustomPaint(
        child: Container(),
        painter: _MarqueePainter(
          widget.textList,
          fontSize: widget.fontSize,
          textColor: widget.textColor,
          verticalSpace: 0.0,
          percent: percent,
          current: current,
        ),
      ),
    );

    if (widget.tapToNext) {
      _widget = GestureDetector(
        onTap: next,
        child: _widget,
      );
    }

    return _widget;
  }

  int get nextPosition {
    var next = current + 1;
    if (next >= textList.length) {
      next = 0;
    }
    return next;
  }
}

class _MarqueePainter extends CustomPainter {
  List<String> textList;
  double verticalSpace;
  double fontSize;
  Color textColor;

  int current = 0;

  double percent = 0.0;

  _MarqueePainter(
    this.textList, {
    this.fontSize,
    this.textColor,
    this.verticalSpace,
    this.percent = 0.0,
    this.current,
  });

  TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr, textAlign: TextAlign.center);

  @override
  void paint(Canvas canvas, Size size) {
    _paintCurrent(size, canvas);
    _paintNext(size, canvas);
  }

  void _paintCurrent(Size size, Canvas canvas) {
    String text = textList[current];
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
      ),
    );
    textPainter.textAlign = TextAlign.center;
    textPainter.maxLines = 1;
    textPainter.ellipsis = "...";

    textPainter.layout(maxWidth: size.width);
    textPainter.paint(canvas, _getTextOffset(textPainter, size));
  }

  _paintNext(Size size, Canvas canvas) {
    String text = textList[nextPosition];
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
      ),
    );
    textPainter.textAlign = TextAlign.center;
    textPainter.maxLines = 1;
    textPainter.ellipsis = "...";

    textPainter.layout(maxWidth: size.width);
    textPainter.paint(canvas, _getTextOffset(textPainter, size, isNext: true));
  }

  Offset _getTextOffset(TextPainter textPainter, Size size, {bool isNext = false}) {
    var width = textPainter.width;
    if (width >= size.width) {
      width = size.width;
    }
    var height = textPainter.height;
    var dx = size.width / 2 - width / 2;
    var dy = size.height / 2 - height / 2 - size.height * percent;
    if (isNext) {
      dy = dy + size.height;
    }
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  int get nextPosition {
    var next = current + 1;
    if (next >= textList.length) {
      next = 0;
    }
    return next;
  }
}
