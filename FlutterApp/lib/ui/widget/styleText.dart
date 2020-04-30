import 'package:bsmart_connect/models/uimodel.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class TxtStyle {
  TxtStyle._();
  static TextStyle headerStyle18White70 = TextStyle(
      color: Colors.white70,
      fontSize: 18 * ScreenSize.szText,
      fontWeight: FontWeight.w600);

  static TextStyle headerStyle30White = TextStyle(
      color: Colors.white,
      fontSize: 30 * ScreenSize.szText,
      fontWeight: FontWeight.bold);

  static TextStyle normalContentGrey = TextStyle(
      color: Colors.grey[400],
      fontSize: 16 * ScreenSize.szText,
      fontWeight: FontWeight.bold);

  static TextStyle normalContentWhite = TextStyle(
      color: Colors.white,
      fontSize: 16 * ScreenSize.szText,
      fontWeight: FontWeight.bold);

  static TextStyle deviceNameWhite = TextStyle(
      color: Colors.white,
      fontSize: 16 * ScreenSize.szText,
      fontWeight: FontWeight.bold);

  static TextStyle deviceContent = TextStyle(
      color: Colors.white70,
      fontSize: 14 * ScreenSize.szText,
      fontWeight: FontWeight.bold);
}

class MyTxt extends StatelessWidget {
  final String txt;
  final Color color;
  final double size;
  final double letterSpacing;
  final FontWeight fontWeight;

  MyTxt(
      {this.txt,
      this.color = Colors.black,
      this.size = 14.0,
      this.fontWeight = FontWeight.normal,
      this.letterSpacing = 0.0,});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: size * ScreenSize.szText,
          fontWeight: fontWeight),
    );
  }
}

class TypewriterText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  TypewriterText({this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<int>(
        duration: 1000.milliseconds,
        delay: 800.milliseconds,
        tween: 0.tweenTo(text.length),
        builder: (context, child, textLength) {
          return Text(text.substring(0, textLength), style: textStyle);
        });
  }
}
