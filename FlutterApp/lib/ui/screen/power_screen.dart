import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/colorstyle.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class PowerEnergy extends StatefulWidget {
  @override
  _PowerEnergyState createState() => _PowerEnergyState();
}

class _PowerEnergyState extends State<PowerEnergy> {
  GlobalKey powerGlobalKey = new GlobalKey();

  Future<bool> _onWillPop() async {
    Navigator.pop(powerGlobalKey.currentContext);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: powerGlobalKey,
          backgroundColor: Color.fromRGBO(6, 41, 74, 1),
          body: buildPageView()),
    );
  }

  Widget buildPageView() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buidAppBar(),
          BoxMargin(isVertical: true, multi: 2.0),
          Expanded(
              child:
                  Container(child: SingleChildScrollView(child: buildPage()))),
        ],
      ),
    );
  }

  Widget buildPage() {
    return Column(
      children: <Widget>[
        buildChart(),
        BoxMargin(isVertical: true, multi: 5.0),
        buildInstantaneous(),
        BoxMargin(isVertical: true, multi: 2.0),
        buildInstanParam(),
        BoxMargin(isVertical: true, multi: 5.0),
        buildLastMonth(),
        BoxMargin(isVertical: true, multi: 2.0),
        buildInstanParam(),
      ],
    );
  }

  Widget buildChart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
      height: ScreenSize.height * 0.4,
      // width: width,
      width: ScreenSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(5, 86, 128, 1),
      ),
      child: LineChart(
        powerData(),
      ),
    );
    //   },
    // );
  }

  LineChartData powerData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return "10:30";
              case 3:
                return "11:30";
              case 5:
                return "12:30";
              case 7:
                return "13:30";
              case 9:
                return "14:30";
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 100:
                return '100';
              case 500:
                return '500';
              case 1000:
                return '1000';
              case 1500:
                return '1500';
              case 2000:
                return '2000';
            }
            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      // borderData: FlBorderData(
      //     show: true,
      //     border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 2500,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 450),
            FlSpot(1, 600),
            FlSpot(2, 1250),
            FlSpot(3, 840),
            FlSpot(4, 1600),
            FlSpot(5, 600),
            FlSpot(6, 2000),
            FlSpot(7, 520),
            FlSpot(8, 950),
            FlSpot(9, 200),
          ],

          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          // isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildInstantaneous() {
    return PlayAnimation<double>(
      duration: 500.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
          width: width,
          child: width > ScreenSize.width * 0.5
              ? Container(
                  child: TypewriterText(
                    text: "Instantaneous Parameters",
                    textStyle: TxtStyle.normalContentGrey,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildLastMonth() {
    return PlayAnimation<double>(
      duration: 500.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
          width: width,
          child: width > ScreenSize.width * 0.5
              ? Container(
                  child: TypewriterText(
                    text: "April Parameters",
                    textStyle: TxtStyle.normalContentGrey,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buidAppBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
        height: ScreenSize.height * 0.1,
        width: ScreenSize.width,
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.menu, color: Colors.white),
            TypewriterText(
              text: "Power Energy",
              textStyle: TxtStyle.deviceNameWhite,
            ),
            Icon(Icons.autorenew, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget buildInstanParam() {
    return SafeArea(
      child:
          // PlayAnimation<double>(
          //   duration: 800.milliseconds,
          //   delay: 2000.milliseconds,
          //   tween: (0.0).tweenTo(ScreenSize.width),
          //   builder: (context, child, width) {
          //     return
          buildContainerParameter(),
      //     },
      //   ),
    );
  }

  Widget buildContainerParameter() {
    return Container(
      margin: EdgeInsets.only(
          bottom: ScreenSize.marginVertical, left: ScreenSize.marginHorizontal),
      height: ScreenSize.height * 0.3,
      width: ScreenSize.width,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Toast.show("Room $index", homeGlobalKey.currentContext);
                // gotoDevices(homeGlobalKey.currentContext, "Living Room");
              },
              child: Container(
                margin: EdgeInsets.only(right: ScreenSize.marginHorizontal * 2),
                width: ScreenSize.width * 0.4,
                height: ScreenSize.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(14, 71, 100, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenSize.marginHorizontal * 2,
                        left: ScreenSize.marginHorizontal * 1.5,
                      ),
                      // color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("223.5 V", style: TxtStyle.deviceNameWhite),
                          Text("Voltage", style: TxtStyle.deviceContent),
                        ],
                      ),
                    ),
                    buildImageParam(),
                    Container(
                      height: ScreenSize.height * 0.04,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          color: Color.fromRGBO(5, 86, 128, 1)),
                      child: Center(
                          child: Text(
                        "Max: 226.3 V",
                        style: TxtStyle.normalContentWhite,
                      )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Expanded buildImageParam() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildBar(0.45),
            buildBar(0.35),
            buildBar(0.5),
            buildBar(0.65),
            buildBar(0.35),
            buildBar(0.65),
            buildBar(0.5),
            buildBar(0.35),
            buildBar(0.45),
          ],
        ),
      ),
    );
  }

  Container buildBar(double param) {
    return Container(
      width: 6,
      height: ScreenSize.height * 0.15 * param,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 233, 193, 1),
          Color.fromRGBO(15, 175, 176, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
