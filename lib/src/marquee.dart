import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final List<String> textList;
  final double lineHeight;
  final double verticalSpace;
  final double fontSize;
  final Color textColor;

  const Marquee(
      {Key key,
      this.textList = const [],
      this.lineHeight = 30.0,
      this.verticalSpace = 10.0,
      this.fontSize = 14.0,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  List<String> get textList => widget.textList;

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

    return CustomPaint(
      child: Container(),
      painter: _MarqueePainter(widget.textList),
    );
  }
}

class _MarqueePainter extends CustomPainter {
  List<String> textList;
  double lineHeight;
  double verticalSpace;
  double fontSize;
  Color textColor;

  _MarqueePainter(
    this.textList, {
    this.lineHeight,
    this.fontSize,
    this.textColor,
    this.verticalSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
  }
}
