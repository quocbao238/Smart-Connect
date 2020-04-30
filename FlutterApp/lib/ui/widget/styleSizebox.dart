import 'package:bsmart_connect/models/uimodel.dart';
import 'package:flutter/material.dart';

class BoxMargin extends StatelessWidget {
  final bool isVertical;
  final double multi;
  const BoxMargin({this.isVertical, this.multi = 1.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? 0.0 : ScreenSize.marginVertical * multi,
      height: isVertical ? ScreenSize.marginVertical * multi : 0.0,
    );
  }
}
